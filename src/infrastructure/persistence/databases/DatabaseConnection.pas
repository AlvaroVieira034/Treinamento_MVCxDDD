unit DatabaseConnection;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.DApt,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, System.SysUtils,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MySQL, System.IniFiles, System.IOUtils;

type
  TDatabaseConnection = class

  private
    FConexao: TFDConnection;
    FTransacao: TFDTransaction;
    procedure ConfigurarSQLServer(AIni: TIniFile);

  public
    constructor Create;
    destructor Destroy; override;

    function GetConexao: TFDConnection;
    function TestarConexao: Boolean;
    function CriarQuery: TFDQuery;
    function CriarDataSource: TDataSource;
    function CriarTransaction: TFDTransaction;
    procedure InciarTransacao;
    procedure CommitTransacao;
    procedure RollbackTransacao;

  end;

implementation

{ TDatabaseConnection }


constructor TDatabaseConnection.Create;
var FDPhysMSSQL: TFDPhysMSSQLDriverLink;
    FDPhysMySQL: TFDPhysMySQLDriverLink;
    Banco: string;
    Ini: TIniFile;
    IniFileName: string;
begin
  inherited Create;
  // Caminho do arquivo INI
  IniFileName := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'confsys.ini');

  // Carregar o arquivo INI
  Ini := TIniFile.Create(IniFileName);
  try
    // Ler o tipo de banco de dados configurado
    Banco := Ini.ReadString('DatabaseConfig', 'Banco', 'MSSQL');

    if Banco = 'MSSQL' then
    begin
      // Configuração para MSSQL
      FDPhysMSSQL := TFDPhysMSSQLDriverLink.Create(nil);

      FConexao := TFDConnection.Create(nil);
      FConexao.Params.DriverID := 'MSSQL';
      FConexao.Params.Database := Ini.ReadString('Database', 'Database', 'bdtestedguarani');
      FConexao.Params.UserName := Ini.ReadString('Database', 'UserName', 'sa');
      FConexao.Params.Password := Ini.ReadString('Database', 'Password', 'info');
      FConexao.Params.Add('Server=' + Ini.ReadString('Database', 'Server', 'NOTEBOOKALVARO\SQLEXPRESS'));
      FConexao.Params.Add('Port=' + Ini.ReadString('Database', 'Port', '1433'));
      FConexao.LoginPrompt := False;
    end
    else if Banco = 'MYSQL' then
    begin
      // Configuração para MySQL
      FDPhysMySQL := TFDPhysMySQLDriverLink.Create(nil);
      FDPhysMySQL.VendorLib := 'c:\windows\system32\libmysql.dll';

      FConexao := TFDConnection.Create(nil);
      FConexao.Params.DriverID := 'MySQL';
      FConexao.Params.Database := Ini.ReadString('Database', 'Database', 'bdtestedexian');
      FConexao.Params.UserName := Ini.ReadString('Database', 'UserName', 'root');
      FConexao.Params.Password := Ini.ReadString('Database', 'Password', '');
      FConexao.Params.Add('Server=' + Ini.ReadString('Database', 'Server', 'localhost'));
      FConexao.Params.Add('Port=' + Ini.ReadString('Database', 'Port', '3307'));
      FConexao.Params.Add('AuthMode=Normal');
      FConexao.LoginPrompt := False;
    end
    else
      raise Exception.Create('Banco de dados não configurado corretamente no arquivo INI.');

    // Criação da transação
    FTransacao := TFDTransaction.Create(nil);
    FTransacao.Connection := FConexao;
    FConexao.Transaction := FTransacao;

    TestarConexao;
  finally
    Ini.Free;
  end;
end;

destructor TDatabaseConnection.Destroy;
begin
  FreeAndNil(FConexao);
  inherited;
end;

procedure TDatabaseConnection.ConfigurarSQLServer(AIni: TIniFile);
var Ini: TIniFile;
    IniFileName: string;
begin
  // Caminho do arquivo INI
  IniFileName := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'confsys.ini');

  // Verifica se o arquivo INI existe
  if not FileExists(IniFileName) then
    raise Exception.Create('Arquivo confsys.ini não encontrado!');

   // Carregar o arquivo INI
  Ini := TIniFile.Create(IniFileName);
  try
    FConexao.Params.Values['Banco'] := Ini.ReadString('DatabaseConfig', 'Banco', 'MSSQL');
    FConexao.Params.UserName := Ini.ReadString('Database', 'UserName', 'sa');
    FConexao.Params.Password := Ini.ReadString('Database', 'Password', 'info');
    FConexao.Params.Add('Server=' + Ini.ReadString('Database', 'Server', 'NOTEBOOKALVARO\SQLEXPRESS'));
    FConexao.Params.Add('Port=' + Ini.ReadString('Database', 'Port', '1433'));
    FConexao.LoginPrompt := False;
  finally
    Ini.Free;
  end;

end;

function TDatabaseConnection.GetConexao: TFDConnection;
begin
  Result := FConexao;
end;

function TDatabaseConnection.CriarQuery: TFDQuery;
var Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FConexao;
  Query.Transaction := FTransacao;
  Result := Query;
end;

function TDatabaseConnection.CriarDataSource: TDataSource;
var DataSource: TDataSource;
begin
  DataSource := TDataSource.Create(nil);
  Result := DataSource;
end;

function TDatabaseConnection.TestarConexao: Boolean;
begin
  Result := False;
  try
    FConexao.Connected := True;
    Result := FConexao.Connected;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao conectar: ' + E.Message);
    end;
  end;
end;

function TDatabaseConnection.CriarTransaction: TFDTransaction;
begin
  Result := FTransacao;
end;

procedure TDatabaseConnection.InciarTransacao;
begin
  if FTransacao.Active then
  begin
    // Se já há transação ativa, faz rollback da anterior
    // para evitar transações aninhadas não intencionais
    FTransacao.Rollback;
  end;

  FTransacao.StartTransaction;
end;

procedure TDatabaseConnection.CommitTransacao;
begin
  if not FTransacao.Active then
    raise Exception.Create('Não há transação ativa para commit');

  FTransacao.Commit;
end;

procedure TDatabaseConnection.RollbackTransacao;
begin
  if FTransacao.Active then
    FTransacao.Rollback;
end;

end.

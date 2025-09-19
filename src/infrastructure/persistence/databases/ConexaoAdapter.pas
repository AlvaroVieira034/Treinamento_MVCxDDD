unit ConexaoAdapter;

interface

uses
  IConexao.Database, ConexaoSingleton, Data.DB, FireDAC.Comp.Client;

type
  TConexao = class(TInterfacedObject, IConexaoDatabase)

  public
    function GetConexao: TFDConnection;
    function TestarConexao: Boolean;
    function CriarQuery: TFDQuery;
    function CriarDataSource: TDataSource;
    function CriarTransaction: TFDTransaction;
    procedure IniciarTransacao;
    procedure CommitTransacao;
    procedure RollbackTransacao;

  end;

implementation

{ TConexaoAdapter }

function TConexao.GetConexao: TFDConnection;
begin
  Result := TConexaoSingleton.GetInstance.DatabaseConnection.GetConexao;
end;

function TConexao.TestarConexao: Boolean;
begin
  Result := TConexaoSingleton.GetInstance.DatabaseConnection.TestarConexao;
end;

function TConexao.CriarQuery: TFDQuery;
begin
  Result := TConexaoSingleton.GetInstance.DatabaseConnection.CriarQuery;
end;

function TConexao.CriarDataSource: TDataSource;
begin
  Result := TConexaoSingleton.GetInstance.DatabaseConnection.CriarDataSource;
end;

function TConexao.CriarTransaction: TFDTransaction;
begin
  Result := TConexaoSingleton.GetInstance.DatabaseConnection.CriarTransaction;
end;

procedure TConexao.IniciarTransacao;
begin
  TConexaoSingleton.GetInstance.DatabaseConnection.InciarTransacao;
end;

procedure TConexao.CommitTransacao;
begin
  TConexaoSingleton.GetInstance.DatabaseConnection.CommitTransacao;
end;

procedure TConexao.RollbackTransacao;
begin
  TConexaoSingleton.GetInstance.DatabaseConnection.RollbackTransacao;
end;

end.

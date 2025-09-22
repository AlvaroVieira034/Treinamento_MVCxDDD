unit ClienteRepository;

interface

uses
  ClienteModel, ConexaoAdapter, ConexaoSingleton, ICliente.Repository, ClienteDTO,
  ClienteExceptions, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TClienteRepository = class(TInterfacedObject, IClienteRepository)

  private
    QryClientes: TFDQuery;
    Transacao: TFDTransaction;
    Conexao: TConexao;
    FConexao: TFDConnection;

    // Constantes SQL
    const
      SQL_INSERT =
        'insert into tab_cliente(' +
        'cod_ativo, des_razaosocial, des_nomefantasia, des_contato, ' +
        'des_cep, des_logradouro, des_numero, des_complemento, ' +
        'des_cidade, des_uf, des_cnpj, des_telefone, des_email) ' +
        'values (' +
        ':cod_ativo, :des_razaosocial, :des_nomefantasia, :des_contato, ' +
        ':des_cep, :des_logradouro, :des_numero, :des_complemento, ' +
        ':des_cidade, :des_uf, :des_cnpj, :des_telefone, :des_email)';

      SQL_UPDATE =
        'update tab_cliente set ' +
        'cod_ativo = :cod_ativo, ' +
        'des_razaosocial = :des_razaosocial, ' +
        'des_nomefantasia = :des_nomefantasia, ' +
        'des_contato = :des_contato, ' +
        'des_cep = :des_cep, ' +
        'des_logradouro = :des_logradouro, ' +
        'des_numero = :des_numero, ' +
        'des_complemento = :des_complemento, ' +
        'des_cidade = :des_cidade, ' +
        'des_uf = :des_uf, ' +
        'des_cnpj = :des_cnpj, ' +
        'des_telefone = :des_telefone, ' +
        'des_email = :des_email ' +
        'where cod_cliente = :cod_cliente';

  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;

    function Inserir(ACliente: TCliente): Boolean;
    function Alterar(ACliente: TCliente; AId: Integer): Boolean;
    function Excluir(AId: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;
    procedure CriarTabelas;

  end;

implementation

{ TClienteRepository }

constructor TClienteRepository.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConexao := AConnection;
  CriarTabelas();
end;

destructor TClienteRepository.Destroy;
begin
  QryClientes.Free;

  inherited Destroy;
end;

function TClienteRepository.Inserir(ACliente: TCliente): Boolean;
var DTO: TClienteDTO;
begin
  DTO := TClienteDTO.FromEntity(ACliente);
  try
    Result := ExecutarTransacao(
      procedure
      begin
        with QryClientes do
        begin
          Close;
          SQL.Clear;
          SQL.Text := SQL_INSERT;
          DTO.MapearParaQuery(QryClientes);
          ExecSQL;
        end;
      end);
  finally
    DTO.Free
  end;
end;

function TClienteRepository.Alterar(ACliente: TCliente; AId: Integer): Boolean;
var DTO: TClienteDTO;
begin
  DTO := TClienteDTO.FromEntity(ACliente);
  try
    Result := ExecutarTransacao(
      procedure
      begin
        with QryClientes do
        begin
          Close;
          SQL.Clear;
          SQL.Text := SQL_UPDATE;
          DTO.MapearParaQuery(QryClientes);
          ParamByName('COD_CLIENTE').AsInteger := AId;
          ExecSQL;
        end;
      end);
  finally
    DTO.Free
  end;
end;

function TClienteRepository.Excluir(AId: Integer): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryClientes do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'delete from tab_cliente where cod_cliente = :cod_cliente';
        ParamByName('COD_CLIENTE').AsInteger := AId;

        ExecSQL;
      end;
    end);
end;

function TClienteRepository.ExecutarTransacao(AOperacao: TProc): Boolean;
begin
  Result := False;
  if not Transacao.Connection.Connected then
    Transacao.Connection.Open();

  Transacao.StartTransaction;
  try
    AOperacao;
    Transacao.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      Transacao.Rollback;
      raise Exception.Create('Ocorreu um erro na transação do cliente! Erro: ' + E.Message);
    end;
  end;
end;

procedure TClienteRepository.CriarTabelas;
begin
  QryClientes := Conexao.CriarQuery;
  Transacao := Conexao.CriarTransaction;
  QryClientes.Transaction := Transacao;
end;

end.

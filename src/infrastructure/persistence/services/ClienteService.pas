unit ClienteService;

interface

uses
  ClienteModel, ConexaoAdapter, ICliente.Service, ClienteExceptions, ClienteDTO, System.SysUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TClienteService = class(TInterfacedObject, IClienteService)

  private
    TblClientes: TFDQuery;
    QryTemp: TFDQuery;
    DsClientes: TDataSource;
    Conexao: TConexao;
    FConexao: TFDConnection;

    // Constantes SQL
    const
      SQL_SELECT =
        'select cli.cod_cliente, cli.cod_ativo, cli.cod_tipo, cli.des_razaosocial as nomecliente, ' + #13 +
        'cli.des_nomefantasia, cli.des_contato, cli.des_cep, cli.des_logradouro, cli.des_numero, ' + #13 +
        'cli.des_complemento, cli.des_cidade, cli.des_uf, cli.des_documento, cli.des_telefone,  ' + #13 +
        'cli.des_email ' + #13 +
        'from tab_cliente cli';

  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;

    // Metodos de Acesso a banco de dados -> View
    procedure PreencheGridClientes(APesquisa, ACampo: string);
    procedure PreencherComboClientes(TblClientes: TFDQuery);
    procedure PreencherCamposForm(ACliente: TCliente; AId: Integer);
    function BuscarClientePorCodigo(AId: Integer): TCliente;

    // Metódos de Validação
    procedure ValidarDocumentoUnico(const ADocumento: string; ACodigoCliente, ATipoCliente: Integer);
    procedure ValidarCliente(ACliente: TCliente);
    function VerificarDocumentoExistente(const ADocumento: string; ACodigoCliente: Integer): Boolean;
    function ClientePodeSerExcluido(AClienteId: Integer): Boolean;

    // Metodos de criação de DataSets
    procedure CriarTabelas;
    function GetDataSource: TDataSource;

  end;

implementation

{ TClienteService }


constructor TClienteService.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConexao := AConnection;
  CriarTabelas();
end;

destructor TClienteService.Destroy;
begin
  TblClientes.Free;
  QryTemp.Free;
  DsClientes.Free;
  inherited;
end;

procedure TClienteService.PreencheGridClientes(APesquisa, ACampo: string);
begin
  with TblClientes do
  begin
    Close;
    SQL.Clear;
    SQL.Text := SQL_SELECT;
    SQL.Add('where ' + ACampo + ' like :pNOME');
    SQL.Add('order by ' + ACampo);

    ParamByName('PNOME').AsString := APesquisa;
    Open();
  end;
end;

procedure TClienteService.PreencherComboClientes(TblClientes: TFDQuery);
begin
  with TblClientes do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select cod_cliente, des_nomefantasia from tab_cliente order by des_nomefantasia ');
    Open();
  end;
end;

procedure TClienteService.PreencherCamposForm(ACliente: TCliente; AId: Integer);
var DTO: TClienteDTO;
begin
  with TblClientes do
  begin
    Close;
    SQL.Clear;
    SQL.Text := SQL_SELECT;
    SQL.Add('where cod_cliente = :cod_cliente');
    ParamByName('cod_cliente').AsInteger := AId;
    Open;

    if not IsEmpty then
    begin
      DTO := TClienteDTO.FromDataset(TblClientes);
      try
        DTO.ToEntity(ACliente);
      finally
        DTO.Free;
      end;
    end
    else
      raise Exception.Create('Cliente não encontrado com ID: ' + IntToStr(AId));

  end;
end;

procedure TClienteService.ValidarDocumentoUnico(const ADocumento: string; ACodigoCliente, ATipoCliente: Integer);
begin
  if VerificarDocumentoExistente(ADocumento, ACodigoCliente) then
  begin
    if ATipoCliente = 1 then
      raise EDocumentoDuplicadoException.Create('CNPJ: ' + ADocumento)
    else
      raise EDocumentoDuplicadoException.Create('CPF: ' + ADocumento);
  end;
end;

procedure TClienteService.ValidarCliente(ACliente: TCliente);
begin
  ACliente.Validar;
  /// Validar documento conforme tipo
  ACliente.Documento.Validar(ACliente.Cod_Tipo);

  // Validar se documento já existe
  if ACliente.Cod_Tipo = 1 then
    ValidarDocumentoUnico(ACliente.Documento.CNPJ, ACliente.Cod_Cliente, ACliente.Cod_Tipo)
  else
    ValidarDocumentoUnico(ACliente.Documento.CPF, ACliente.Cod_Cliente, ACliente.Cod_Tipo);
end;

procedure TClienteService.CriarTabelas;
begin
  TblClientes := Conexao.CriarQuery;
  QryTemp := Conexao.CriarQuery;
  DsClientes := Conexao.CriarDataSource;
  DsClientes.DataSet := TblClientes;
end;

function TClienteService.BuscarClientePorCodigo(AId: Integer): TCliente;
var Query: TFDQuery;
    DTO: TClienteDTO;
begin
  Result := TCliente.Create;
  try
    Query := Conexao.CriarQuery();
    try
      with Query do
      begin
        Close;
        SQL.Clear;
        SQL.Text := SQL_SELECT;
        SQL.Add('where cod_cliente = :cod_cliente');
        ParamByName('cod_cliente').AsInteger := AId;
        Open;

        if not IsEmpty then
        begin
          DTO := TClienteDTO.FromDataset(Query);
          try
            DTO.ToEntity(Result);
          finally
            DTO.Free;
          end;
        end
        else
          raise Exception.Create('Cliente não encontrado!');
      end;
    finally
      Query.Free;
    end;
  except
    Result.Free;
    raise;
  end;
end;

function TClienteService.VerificarDocumentoExistente(const ADocumento: string; ACodigoCliente: Integer): Boolean;
begin
  Result := False;
  QryTemp.Close;
  QryTemp.SQL.Add('select count(*) as quant from tab_cliente where des_documento = :documento');
  if ACodigoCliente > 0 then
  begin
    QryTemp.SQL.Text := QryTemp.SQL.Text + ' and cod_cliente <> :cod_cliente';
    QryTemp.ParamByName('COD_CLIENTE').AsInteger := ACodigoCliente;
  end;

  QryTemp.ParamByName('DOCUMENTO').AsString := ADocumento;
  QryTemp.Open();

  Result := QryTemp.FieldByName('QUANT').AsInteger > 0;
end;

function TClienteService.ClientePodeSerExcluido(AClienteId: Integer): Boolean;
begin
  Result := False;
  if AClienteId <= 0 then
    Exit(False);

  QryTemp.Close;
  QryTemp.SQL.Text := ('select count(*) as quant from tab_pedido where cod_cliente = :cod_cliente');
  QryTemp.ParamByName('COD_CLIENTE').AsInteger := AClienteId;
  QryTemp.Open;

  Result := QryTemp.FieldByName('QUANT').AsInteger = 0;
end;

function TClienteService.GetDataSource: TDataSource;
begin
  Result := DsClientes;
end;

end.

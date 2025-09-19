unit ClienteService;

interface

uses
  ClienteModel, ConexaoAdapter, ICliente.Service, ClienteExceptions, ClienteMapper, ClienteDTO, System.SysUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TClienteService = class(TInterfacedObject, IClienteService)

  private
    TblClientes: TFDQuery;
    QryTemp: TFDQuery;
    DsClientes: TDataSource;
    Conexao: TConexao;
    FConexao: TFDConnection;

  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;

    procedure PreencheGridClientes(APesquisa, ACampo: string);
    procedure PreencherComboClientes(TblClientes: TFDQuery);
    procedure PreencherCamposForm(ACliente: TCliente; AId: Integer);
    procedure ValidarCNPJUnico(const ACNPJ: string; ACodigoCliente: Integer);
    procedure ValidarCliente(ACliente: TCliente);
    procedure CriarTabelas;
    function BuscarClientePorCodigo(AId: Integer): TCliente;
    function VerificarCnpjExistente(const ACNPJ: string; ACodigoCliente: Integer): Boolean;
    function ClientePodeSerExcluido(AClienteId: Integer): Boolean;
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
    SQL.Add('select cli.cod_cliente,  ');
    SQL.Add('cli.des_razaosocial, ');
    SQL.Add('cli.des_nomefantasia, ');
    SQL.Add('cli.des_logradouro, ');
    SQL.Add('cli.des_complemento, ');
    SQL.Add('cli.des_cep, ');
    SQL.Add('cli.des_cidade, ');
    SQL.Add('cli.des_uf, ');
    SQL.Add('cli.des_cnpj, ');
    SQL.Add('cli.des_telefone ');
    SQL.Add('from tab_cliente cli');
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
    SQL.Add('select * from tab_cliente order by des_razaosocial ');
    Open();
  end;
end;

procedure TClienteService.PreencherCamposForm(ACliente: TCliente; AId: Integer);
begin
  with TblClientes do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select cli.cod_cliente,  ');
    SQL.Add('cli.cod_ativo, ');
    SQL.Add('cli.des_nomefantasia, ');
    SQL.Add('cli.des_razaosocial, ');
    SQL.Add('cli.des_contato, ');
    SQL.Add('cli.des_cep, ');
    SQL.Add('cli.des_logradouro, ');
    SQL.Add('cli.des_numero, ');
    SQL.Add('cli.des_complemento, ');
    SQL.Add('cli.des_cidade, ');
    SQL.Add('cli.des_uf, ');
    SQL.Add('cli.des_cnpj, ');
    SQL.Add('cli.des_telefone, ');
    SQL.Add('cli.des_email ');
    SQL.Add('from tab_cliente cli');
    SQL.Add('where cod_cliente = :cod_cliente');
    ParamByName('cod_cliente').AsInteger := AId;
    Open;

    if not IsEmpty then
    begin
      //Result := TClienteMapper.DatasetToEntity()
      ACliente.Cod_Ativo := FieldByName('COD_ATIVO').AsInteger;
      ACliente.Cod_Cliente := FieldByName('COD_CLIENTE').AsInteger;
      ACliente.Des_RazaoSocial := FieldByName('DES_RAZAOSOCIAL').AsString;
      ACliente.Des_NomeFantasia := FieldByName('DES_NOMEFANTASIA').AsString;
      ACliente.Des_Contato := FieldByName('DES_CONTATO').AsString;
      ACliente.Des_Cep := FieldByName('DES_CEP').AsString;
      ACliente.Des_Logradouro := FieldByName('DES_LOGRADOURO').AsString;
      ACliente.Des_Numero := FieldByName('DES_NUMERO').AsString;
      ACliente.Des_Complemento := FieldByName('DES_COMPLEMENTO').AsString;
      ACliente.Des_Cidade := FieldByName('DES_CIDADE').AsString;
      ACliente.Des_UF := FieldByName('DES_UF').AsString;
      ACliente.Des_CNPJ := FieldByName('DES_CNPJ').AsString;
      ACliente.Des_Telefone := FieldByName('DES_TELEFONE').AsString;
      ACliente.Des_Email := FieldByName('DES_EMAIL').AsString;
    end
    else
      raise Exception.Create('Cliente não encontrado com ID: ' + IntToStr(AId));

    //Close;
  end;
end;

procedure TClienteService.ValidarCNPJUnico(const ACNPJ: string; ACodigoCliente: Integer);
begin
  if VerificarCnpjExistente(ACNPJ, ACodigoCliente) then
    raise ECNPJDuplicadoException.Create(ACNPJ);
end;

procedure TClienteService.ValidarCliente(ACliente: TCliente);
begin
  // Validações básicas da entidade
  ACliente.ValidarDados;

  // Validações de negócio (CNPJ único)
  if VerificarCnpjExistente(ACliente.Des_Cnpj, ACliente.Cod_Cliente) then
    raise ECNPJDuplicadoException.Create(ACliente.Des_Cnpj);
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
begin
  Query := Conexao.CriarQuery();
  try
    with Query do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select cli.cod_cliente,  ');
      SQL.Add('cli.cod_ativo, ');
      SQL.Add('cli.des_nomefantasia, ');
      SQL.Add('cli.des_razaosocial, ');
      SQL.Add('cli.des_contato, ');
      SQL.Add('cli.des_cep, ');
      SQL.Add('cli.des_logradouro, ');
      SQL.Add('cli.des_numero, ');
      SQL.Add('cli.des_complemento, ');
      SQL.Add('cli.des_cidade, ');
      SQL.Add('cli.des_uf, ');
      SQL.Add('cli.des_cnpj, ');
      SQL.Add('cli.des_telefone, ');
      SQL.Add('cli.des_email ');
      SQL.Add('from tab_cliente cli');
      SQL.Add('where cod_cliente = :cod_cliente');
      ParamByName('cod_cliente').AsInteger := AId;
      Open;

      if not IsEmpty then
        Result := TClienteMapper.DatasetToEntity(Query)
      else
        raise Exception.Create('Cliente não encontrado!');

    end;
  finally
    Query.Free;
  end;
end;

function TClienteService.VerificarCnpjExistente(const ACNPJ: string; ACodigoCliente: Integer): Boolean;
begin
  QryTemp.Close;
  QryTemp.SQL.Add('select count(*) as quant from tab_cliente where des_cnpj = :cnpj');
  if ACodigoCliente > 0 then
  begin
    QryTemp.SQL.Text := QryTemp.SQL.Text + ' and cod_cliente <> :cod_cliente';
    QryTemp.ParamByName('COD_CLIENTE').AsInteger := ACodigoCliente;
  end;

  QryTemp.ParamByName('CNPJ').AsString := ACNPJ;
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

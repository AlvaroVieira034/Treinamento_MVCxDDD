unit ClienteDTO;

interface

uses
  System.SysUtils, ClienteModel, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TClienteDTO = class

  private
    FCod_Cliente: Integer;
    FCod_Ativo: Integer;
    FCod_Tipo: Integer;
    FDes_NomeFantasia: string;
    FDes_RazaoSocial: string;
    FDes_Contato: string;
    FDes_Cep: string;
    FDes_Logradouro: string;
    FDes_Numero: string;
    FDes_Complemento: string;
    FDes_Cidade: string;
    FDes_UF: string;
    FDes_Documento: string;
    FDes_Telefone: string;
    FDes_Email: string;

  public
    constructor Create; overload;
    constructor Create(ACod_Cliente, ACod_Ativo, ACod_Tipo: Integer; ADes_NomeFantasia, ADes_RazaoSocial,
                       ADes_Contato, ADes_Cep, ADes_Logradouro, ADes_Numero, ADes_Complemento, ADes_Cidade,
                       ADes_UF, ADes_Documento, ADes_Telefone, ADes_Email: string); overload;

    // Métodos de conversão
    class function FromEntity(ACliente: TCliente): TClienteDTO;
    class function FromDataset(ADataset: TDataSet): TClienteDTO;
    procedure ToEntity(var ACliente: TCliente);
    procedure MapearParaQuery(AQuery: TFDQuery);

    // Properties
    property Cod_Cliente: Integer read FCod_Cliente write FCod_Cliente;
    property Cod_Ativo: Integer read FCod_Ativo write FCod_Ativo;
    property Cod_Tipo: Integer read FCod_Tipo write FCod_Tipo;
    property Des_RazaoSocial: string read FDes_RazaoSocial write FDes_RazaoSocial;
    property Des_NomeFantasia: string read FDes_NomeFantasia write FDes_NomeFantasia;
    property Des_Contato: string read FDes_Contato write FDes_Contato;
    property Des_Cep: string read FDes_Cep write FDes_Cep;
    property Des_Logradouro: string read FDes_Logradouro write FDes_Logradouro;
    property Des_Numero: string read FDes_Numero write FDes_Numero;
    property Des_Complemento: string read FDes_Complemento write FDes_Complemento;
    property Des_Cidade: string read FDes_Cidade write FDes_Cidade;
    property Des_UF: string read FDes_UF write FDes_UF;
    property Des_Documento: string read FDes_Documento write FDes_Documento;
    property Des_Telefone: string read FDes_Telefone write FDes_Telefone;
    property Des_Email: string read FDes_Email write FDes_Email;
  end;

implementation

{ TClienteDTO }

constructor TClienteDTO.Create;
begin
  inherited Create;
  FCod_Ativo := 1; // Valor padrão: ativo
end;

constructor TClienteDTO.Create(ACod_Cliente, ACod_Ativo, ACod_Tipo: Integer; ADes_NomeFantasia, ADes_RazaoSocial,
                               ADes_Contato, ADes_Cep, ADes_Logradouro, ADes_Numero, ADes_Complemento, ADes_Cidade,
                               ADes_UF, ADes_Documento, ADes_Telefone, ADes_Email: string);
begin
  inherited Create;
  FCod_Cliente := ACod_Cliente;
  FCod_Ativo := ACod_Ativo;
  FCod_Tipo := ACod_Tipo;
  FDes_NomeFantasia := ADes_NomeFantasia;
  FDes_RazaoSocial := ADes_RazaoSocial;
  FDes_Contato := ADes_Contato;
  FDes_Cep := ADes_Cep;
  FDes_Logradouro := ADes_Logradouro;
  FDes_Numero := ADes_Numero;
  FDes_Complemento := ADes_Complemento;
  FDes_Cidade := ADes_Cidade;
  FDes_UF := ADes_UF;
  FDes_Documento := ADes_Documento;
  FDes_Telefone := ADes_Telefone;
  FDes_Email := ADes_Email;
end;

class function TClienteDTO.FromEntity(ACliente: TCliente): TClienteDTO;
begin
  Result := TClienteDTO.Create;
  Result.Cod_Cliente := ACliente.Cod_Cliente;
  Result.Cod_Ativo := ACliente.Cod_Ativo;
  Result.Cod_Tipo := ACliente.Cod_Tipo;
  Result.Des_RazaoSocial := ACliente.Des_RazaoSocial;
  Result.Des_NomeFantasia := ACliente.Des_NomeFantasia;
  Result.Des_Contato := ACliente.Des_Contato;

  // Acessando dados através dos Value Objects
  Result.Des_Cep := ACliente.Endereco.Cep;
  Result.Des_Logradouro := ACliente.Endereco.Logradouro;
  Result.FDes_Numero := ACliente.Endereco.Numero;
  Result.Des_Complemento := ACliente.Endereco.Complemento;
  Result.Des_Cidade := ACliente.Endereco.Cidade;
  Result.Des_UF := ACliente.Endereco.UF;

  // Mapeamento do documento conforme tipo
  if ACliente.Cod_Tipo = 0 then
    Result.Des_Documento := ACliente.Documento.CPF
  else
    Result.Des_Documento := ACliente.Documento.CNPJ;

  Result.Des_Telefone := ACliente.Contato.Telefone;
  Result.Des_Email := ACliente.Contato.Email;
end;

class function TClienteDTO.FromDataset(ADataset: TDataSet): TClienteDTO;
begin
  Result := TClienteDTO.Create;
  with ADataset do
  begin
    Result.Cod_Cliente := FieldByName('COD_CLIENTE').AsInteger;
    Result.Cod_Ativo := FieldByName('COD_ATIVO').AsInteger;
    Result.Cod_Tipo := FieldByName('COD_TIPO').AsInteger;
    Result.Des_RazaoSocial := FieldByName('DES_RAZAOSOCIAL').AsString;
    Result.Des_NomeFantasia := FieldByName('DES_NOMEFANTASIA').AsString;
    Result.Des_Contato := FieldByName('DES_CONTATO').AsString;
    Result.Des_Cep := FieldByName('DES_CEP').AsString;
    Result.Des_Logradouro := FieldByName('DES_LOGRADOURO').AsString;
    Result.Des_Numero := FieldByName('DES_NUMERO').AsString;
    Result.Des_Complemento := FieldByName('DES_COMPLEMENTO').AsString;
    Result.Des_Cidade := FieldByName('DES_CIDADE').AsString;
    Result.Des_UF := FieldByName('DES_UF').AsString;
    Result.Des_Documento := FieldByName('DES_DOCUMENTO').AsString;
    Result.Des_Telefone := FieldByName('DES_TELEFONE').AsString;
    Result.Des_Email := FieldByName('DES_EMAIL').AsString;
  end;
end;

procedure TClienteDTO.ToEntity(var ACliente: TCliente);
begin
  ACliente.Cod_Cliente := FCod_Cliente;
  ACliente.Cod_Ativo := FCod_Ativo;
  ACliente.Cod_Tipo := FCod_Tipo;
  ACliente.Des_RazaoSocial := FDes_RazaoSocial;
  ACliente.Des_NomeFantasia := FDes_NomeFantasia;
  ACliente.Des_Contato := FDes_Contato;
  ACliente.Endereco.CEP := FDes_Cep;
  ACliente.Endereco.Logradouro := FDes_Logradouro;
  ACliente.Endereco.Numero := FDes_Numero;
  ACliente.Endereco.Complemento := FDes_Complemento;
  ACliente.Endereco.Cidade := FDes_Cidade;
  ACliente.Endereco.UF := FDes_UF;

  if FCod_Tipo = 0 then
    ACliente.Documento.CPF := FDes_Documento
  else
    ACliente.Documento.CNPJ := FDes_Documento;

  ACliente.Contato.Telefone := FDes_Telefone;
  ACliente.Contato.Email := FDes_Email;
end;

procedure TClienteDTO.MapearParaQuery(AQuery: TFDQuery);
begin
  with AQuery do
  begin
    ParamByName('COD_ATIVO').AsInteger := FCod_Ativo;
    ParamByName('COD_TIPO').AsInteger := FCod_Tipo;
    ParamByName('DES_RAZAOSOCIAL').AsString := FDes_RazaoSocial;
    ParamByName('DES_NOMEFANTASIA').AsString := FDes_NomeFantasia;
    ParamByName('DES_CONTATO').AsString := FDes_Contato;
    ParamByName('DES_CEP').AsString := FDes_Cep;
    ParamByName('DES_LOGRADOURO').AsString := FDes_Logradouro;
    ParamByName('DES_NUMERO').AsString := FDes_Numero;
    ParamByName('DES_COMPLEMENTO').AsString := FDes_Complemento;
    ParamByName('DES_CIDADE').AsString := FDes_Cidade;
    ParamByName('DES_UF').AsString := FDes_UF;
    ParamByName('DES_DOCUMENTO').AsString := FDes_Documento;
    ParamByName('DES_TELEfone').AsString := FDes_Telefone;
    ParamByName('DES_EMAIL').AsString := FDes_Email;
  end;
end;

end.

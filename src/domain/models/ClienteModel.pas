unit ClienteModel;

interface

uses
  System.SysUtils, System.Generics.Collections, EnderecoValueObject, ContatoValueObject,
  DocumentoValueObject;

type
  EClienteException = class(Exception);
  TCliente = class

  private
    FCod_Cliente: Integer;
    FCod_Ativo: Integer;
    FCod_Tipo: Integer;
    FDes_NomeFantasia: string;
    FDes_RazaoSocial: string;
    FDes_Contato: string;

    // Value Objects
    FEndereco: TEndereco;
    FContato: TContato;
    FDocumento: TDocumento;

    // Métodos de validação
    procedure ValidarNomeFantasia;
    procedure ValidarRazaoSocial;
    procedure SetDes_NomeFantasia(const Value: string);
    procedure SetDes_RazaoSocial(const Value: string);
    procedure SetDes_Contato(const Value: string);

  public
    constructor Create;
    destructor Destroy; override;

    // Comportamentos
    procedure Validar;
    procedure Ativar;
    procedure Desativar;
    function EstaAtivo: Boolean;
    function ObterErrosValidacao: TArray<string>;

    // Properties
    property Cod_Cliente: Integer read FCod_Cliente write FCod_Cliente;
    property Cod_Ativo: Integer read FCod_Ativo write FCod_Ativo;
    property Cod_Tipo: Integer read FCod_Tipo write FCod_Tipo;
    property Des_NomeFantasia: string read FDes_NomeFantasia write SetDes_NomeFantasia;
    property Des_RazaoSocial: string read FDes_RazaoSocial write SetDes_RazaoSocial;
    property Des_Contato: string read FDes_Contato write SetDes_Contato;

    // Value Objects properties
    property Endereco: TEndereco read FEndereco;
    property Contato: TContato read FContato;
    property Documento: TDocumento read FDocumento;

    // Métodos para configurar VOs
    procedure ConfigurarEndereco(const ACEP, ALogradouro, ANumero, AComplemento, ACidade, AUF: string);
    procedure ConfigurarContato(const ATelefone, AEmail: string);
    procedure ConfigurarDocumento(const ADocumento: string; ATipoCliente: Integer);
  end;

implementation

{ TCliente }


constructor TCliente.Create;
begin
  inherited Create;
  FEndereco := TEndereco.Create;
  FContato := TContato.Create;
  FDocumento := TDocumento.Create;
  FCod_Ativo := 1;
end;

destructor TCliente.Destroy;
begin
  FEndereco.Free;
  FContato.Free;
  FDocumento.Free;

  inherited Destroy;
end;

procedure TCliente.Validar;
var Erros: TArray<string>;
begin
  Erros := ObterErrosValidacao;

  if Length(Erros) > 0 then
    raise EClienteException.Create('Dados inválidos: ' + string.Join('; ', Erros));

end;

procedure TCliente.ValidarNomeFantasia;
begin
  if Length(FDes_NomeFantasia) < 3 then
    raise EClienteException.Create('Nome fantasia deve ter pelo menos 3 caracteres');

  if Length(FDes_NomeFantasia) > 100 then
    raise EClienteException.Create('Nome fantasia muito longo (máx. 100 caracteres)');
end;

procedure TCliente.ValidarRazaoSocial;
begin
  if (FDes_RazaoSocial <> '') and (Length(FDes_RazaoSocial) < 5) then
    raise EClienteException.Create('Razão social deve ter pelo menos 5 caracteres');

  if (FDes_RazaoSocial <> '') and (Length(FDes_RazaoSocial) > 100) then
    raise EClienteException.Create('Razão social muito longa (máx. 100 caracteres)');
end;

procedure TCliente.SetDes_NomeFantasia(const Value: string);
begin
  if FDes_NomeFantasia <> Value then
  begin
    FDes_NomeFantasia := Value.Trim;
    ValidarNomeFantasia;
  end;
end;

procedure TCliente.SetDes_RazaoSocial(const Value: string);
begin
  if FDes_RazaoSocial <> Value then
  begin
    FDes_RazaoSocial := Value.Trim;
    if FDes_RazaoSocial <> '' then
      ValidarRazaoSocial;
  end;
end;

procedure TCliente.SetDes_Contato(const Value: string);
begin
  FDes_Contato := Value.Trim;
end;

procedure TCliente.ConfigurarEndereco(const ACEP, ALogradouro, ANumero, AComplemento, ACidade, AUF: string);
begin
  FEndereco.CEP := ACEP;
  FEndereco.Logradouro := ALogradouro;
  FEndereco.Numero := ANumero;
  FEndereco.Complemento := AComplemento;
  FEndereco.Cidade := ACidade;
  FEndereco.UF := AUF;
end;

procedure TCliente.ConfigurarContato(const ATelefone, AEmail: string);
begin
  FContato.Telefone := ATelefone;
  FContato.Email := AEmail;
end;

procedure TCliente.ConfigurarDocumento(const ADocumento: string; ATipoCliente: Integer);
begin
  case ATipoCliente of
    0: // Pessoa Física
      FDocumento.CPF := ADocumento;
    1: // Pessoa Jurídica
      FDocumento.CNPJ := ADocumento;
    else
      raise Exception.Create('Tipo de cliente inválido');
  end;
end;

procedure TCliente.Ativar;
begin
  FCod_Ativo := 1;
end;

procedure TCliente.Desativar;
begin
  FCod_Ativo := 0;
end;

function TCliente.EstaAtivo: Boolean;
begin
  Result := FCod_Ativo = 1;
end;

function TCliente.ObterErrosValidacao: TArray<string>;
begin
  Result := []; // Inicializar o array

  // Validações básicas do cliente
  if FDes_NomeFantasia.Trim = '' then
    Result := Result + ['Nome do cliente é obrigatório!'];

  if Length(FDes_NomeFantasia) < 3 then
    Result := Result + ['Nome do cliente deve ter pelo menos 3 caracteres'];

  if Length(FDes_NomeFantasia) > 100 then
    Result := Result + ['Nome fantasia muito longo (máx. 100 caracteres)'];

  if FEndereco.Cidade.Trim = '' then
    Result := Result + ['Cidade é obrigatória!'];

  if FEndereco.UF.Trim = '' then
    Result := Result + ['UF é obrigatória!'];

  // VALIDAÇÃO DO DOCUMENTO CONFORME TIPO
  case FCod_Tipo of
    0: // Pessoa Física
      begin
        if FDocumento.CPF.Trim = '' then
          Result := Result + ['CPF é obrigatório para Pessoa Física!']
        else if not FDocumento.ValidarCPF then
          Result := Result + ['CPF inválido!'];
      end;
    1: // Pessoa Jurídica
      begin
        if FDocumento.CNPJ.Trim = '' then
          Result := Result + ['CNPJ é obrigatório para Pessoa Jurídica!']
        else if not FDocumento.ValidarCNPJ then
          Result := Result + ['CNPJ inválido!'];
      end;
    else
      Result := Result + ['Tipo de cliente inválido!'];
  end;

  // Validações do Value Object Endereço
  Result := Result + FEndereco.ObterErrosValidacao;

  // Validações do Value Object Contato
  Result := Result + FContato.ObterErrosValidacao;

end;


end.

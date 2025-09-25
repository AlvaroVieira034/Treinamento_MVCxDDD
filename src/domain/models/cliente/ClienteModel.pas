unit ClienteModel;

interface

uses
  System.SysUtils, System.Generics.Collections, EnderecoValueObject, ContatoValueObject, DocumentoValueObject,
  ClienteValidacoes;

type
  EClienteException = class(Exception);
  TCliente = class

  private
    FCod_Ativo: Integer;
    FCod_Cliente: Integer;
    FDes_NomeFantasia: string;
    FDes_RazaoSocial: string;
    FDes_Contato: string;
    FDes_Cep: string;
    FDes_Logradouro: string;
    FDes_Numero: string;
    FDes_Complemento: string;
    FDes_Cidade: string;
    FDes_UF: string;
    FDes_Cnpj: string;
    FDes_Telefone: string;
    FDes_Email: string;

    FEndereco: TEndereco;
    FContato: TContato;
    FDocumento: TDocumento;

    // Setters para propriedades que afetam os ValueObjects
    procedure SetDes_Cep(const Value: string);
    procedure SetDes_Logradouro(const Value: string);
    procedure SetDes_Numero(const Value: string);
    procedure SetDes_Complemento(const Value: string);
    procedure SetDes_Cidade(const Value: string);
    procedure SetDes_UF(const Value: string);
    procedure SetDes_Cnpj(const Value: string);
    procedure SetDes_Telefone(const Value: string);
    procedure SetDes_Email(const Value: string);

  public
    constructor Create;
    destructor Destroy; override;

    // Métodos de validação simplificados
    procedure ValidarDados;
    function ObterErrosValidacao: TArray<string>;

    // Métodos de comportamento
    procedure Ativar;
    procedure Desativar;
    function EstaAtivo: Boolean;

    // Properties para acesso direto
    property Cod_Cliente: Integer read FCod_Cliente write FCod_Cliente;
    property Cod_Ativo: Integer read FCod_Ativo write FCod_Ativo;
    property Des_NomeFantasia: string read FDes_NomeFantasia write FDes_NomeFantasia;
    property Des_RazaoSocial: string read FDes_RazaoSocial write FDes_RazaoSocial;
    property Des_Contato: string read FDes_Contato write FDes_Contato;

    // Properties com setters que atualizam os VOs
    property Des_Cep: string read FDes_Cep write FDes_Cep;
    property Des_Logradouro: string read FDes_Logradouro write FDes_Logradouro;
    property Des_Numero: string read FDes_Numero write FDes_Numero;
    property Des_Complemento: string read FDes_Complemento write FDes_Complemento;
    property Des_Cidade: string read FDes_Cidade write FDes_Cidade;
    property Des_UF: string read FDes_UF write FDes_UF;
    property Des_Telefone: string read FDes_Telefone write FDes_Telefone;
    property Des_Cnpj: string read FDes_Cnpj write FDes_Cnpj;
    property Des_Email: string read FDes_Email write FDes_Email;

    property Endereco: TEndereco read FEndereco;
    property Contato: TContato read FContato;
    property Documento: TDocumento read FDocumento;

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

procedure TCliente.ValidarDados;
begin
  TClienteValidacoes.ValidarCliente(FDes_NomeFantasia, FDes_Cidade, FDes_UF, FDes_Cnpj,
    FDes_Telefone, FDes_Logradouro, FDes_Cep, FDes_Email, FDocumento, FContato, FEndereco);
end;

function TCliente.ObterErrosValidacao: TArray<string>;
begin
  Result := TClienteValidacoes.ObterErrosValidacao(FDes_NomeFantasia, FDes_Cidade, FDes_UF,
    FDes_Cnpj, FDes_Telefone, FDes_Logradouro, FDes_Cep, FDes_Email, FDocumento, FContato, FEndereco);
end;

procedure TCliente.SetDes_Cep(const Value: string);
begin
  if FDes_Cep <> Value then
  begin
    FDes_Cep := Value;
    FreeAndNil(FEndereco);
    FEndereco := TEndereco.Create(FDes_Cep, FDes_Logradouro, FDes_Numero, FDes_Complemento, FDes_Cidade, FDes_UF);
  end;
end;

procedure TCliente.SetDes_Logradouro(const Value: string);
begin
  if FDes_Logradouro <> Value then
  begin
    FDes_Logradouro := Value;
    FreeAndNil(FEndereco);
    FEndereco := TEndereco.Create(FDes_Cep, FDes_Logradouro, FDes_Numero, FDes_Complemento, FDes_Cidade, FDes_UF);
  end;
end;

procedure TCliente.SetDes_Numero(const Value: string);
begin
  if FDes_Numero <> Value then
  begin
    FDes_Numero := Value;
    FreeAndNil(FEndereco);
    FEndereco := TEndereco.Create(FDes_Cep, FDes_Logradouro, FDes_Numero, FDes_Complemento, FDes_Cidade, FDes_UF);
  end;
end;

procedure TCliente.SetDes_Complemento(const Value: string);
begin
  if FDes_Complemento <> Value then
  begin
    FDes_Complemento := Value;
    FreeAndNil(FEndereco);
    FEndereco := TEndereco.Create(FDes_Cep, FDes_Logradouro, FDes_Numero, FDes_Complemento, FDes_Cidade, FDes_UF);
  end;
end;

procedure TCliente.SetDes_Cidade(const Value: string);
begin
  if FDes_Cidade <> Value then
  begin
    FDes_Cidade := Value;
    FreeAndNil(FEndereco);
    FEndereco := TEndereco.Create(FDes_Cep, FDes_Logradouro, FDes_Numero, FDes_Complemento, FDes_Cidade, FDes_UF);
  end;
end;

procedure TCliente.SetDes_UF(const Value: string);
begin
  if FDes_UF <> Value then
  begin
    FDes_UF := Value;
    FreeAndNil(FEndereco);
    FEndereco := TEndereco.Create(FDes_Cep, FDes_Logradouro, FDes_Numero, FDes_Complemento, FDes_Cidade, FDes_UF);
  end;
end;

procedure TCliente.SetDes_Telefone(const Value: string);
begin
  if FDes_Telefone <> Value then
  begin
    FDes_Telefone := Value;
    FreeAndNil(FContato);
    FContato := TContato.Create(FDes_Telefone, FDes_Email);
  end;
end;

procedure TCliente.SetDes_Cnpj(const Value: string);
begin
  if FDes_Cnpj <> Value then
  begin
    FDes_Cnpj := Value;
    FreeAndNil(FDocumento);
    FDocumento := TDocumento.Create(FDes_Cnpj, '');
  end;
end;

procedure TCliente.SetDes_Email(const Value: string);
begin
  if FDes_Email <> Value then
  begin
    FDes_Email := Value;
    FreeAndNil(FContato);
    FContato := TContato.Create(FDes_Telefone, FDes_Email);
  end;
end;

end.

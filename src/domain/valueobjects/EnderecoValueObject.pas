unit EnderecoValueObject;

interface

uses System.SysUtils, System.RegularExpressions, Validadores;

type
  EEnderecoInvalidoException = class(Exception);
  TEndereco = class

  private
    FCEP: string;
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FCidade: string;
    FUF: string;

  public
    constructor Create; overload;
    constructor Create(const ACEP, ALogradouro, ANumero, AComplemento, ACidade, AUF: string); overload;

    procedure Validar;
    function ValidarCEP: Boolean;
    function ValidarUF: Boolean;
    function ToString: string;
    function EstaVazio: Boolean;
    function Equals(OutroEndereco: TEndereco): Boolean;
    function ObterErrosValidacao: TArray<string>;

    property CEP: string read FCEP write FCEP;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Numero: string read FNumero write FNumero;
    property Complemento: string read FComplemento write FComplemento;
    property Cidade: string read FCidade write FCidade;
    property UF: string read FUF write FUF;

  end;

implementation

{ TEndereco }

constructor TEndereco.Create;
begin
   inherited Create;
  // Construtor Vazio
end;

constructor TEndereco.Create(const ACEP, ALogradouro, ANumero, AComplemento, ACidade, AUF: string);
begin
  inherited Create;
  FCEP := ACEP;
  FLogradouro := ALogradouro;
  FNumero := ANumero;
  FComplemento := AComplemento;
  FCidade := ACidade;
  FUF := AUF;

  Validar();
end;

procedure TEndereco.Validar;
var Erros: TArray<string>;
begin
  Erros := ObterErrosValidacao;
  if Length(Erros) > 0 then
    raise EEnderecoInvalidoException.Create(string.Join(sLineBreak, Erros));
end;

function TEndereco.ValidarCEP: Boolean;
begin
  Result := (FCEP = '') or TValidadores.ValidarCEP(FCEP);
end;

function TEndereco.ValidarUF: Boolean;
begin
  Result := (FUF = '') or TValidadores.ValidarUF(FUF);
end;

function TEndereco.ToString: string;
begin
  Result := Format('%s, %s - %s - %s - %s', [FLogradouro, FNumero, FComplemento, FCidade, FUF]);
end;

function TEndereco.EstaVazio: Boolean;
begin
  Result := (FCEP = '') and (FLogradouro = '') and (FCidade = '') and (FUF = '');
end;

function TEndereco.ObterErrosValidacao: TArray<string>;
begin
  Result := [];

  if not ValidarCEP then
    Result := Result + ['CEP inválido: ' + FCEP];

  if not ValidarUF then
    Result := Result + ['UF inválida: ' + FUF];
end;

function TEndereco.Equals(OutroEndereco: TEndereco): Boolean;
begin
  if not Assigned(OutroEndereco) then
    Exit(False);

  Result := (FCEP = OutroEndereco.CEP) and
            (FLogradouro = OutroEndereco.Logradouro) and
            (FNumero = OutroEndereco.Numero) and
            (FComplemento = OutroEndereco.Complemento) and
            (FCidade = OutroEndereco.Cidade) and
            (FUF = OutroEndereco.UF);
end;

end.

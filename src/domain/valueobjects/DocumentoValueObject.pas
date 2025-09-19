unit DocumentoValueObject;

interface

uses System.SysUtils, System.RegularExpressions, Validadores;

type
  EDocumentoInvalidoException = class(Exception);
  TDocumento = class

  private
    FCNPJ: string;
    FCPF: string;

    procedure Validar;

  public
    constructor Create; overload;
    constructor Create(const ACNPJ, ACPF: string); overload;

    function ValidarCNPJ: Boolean;
    function ValidarCPF: Boolean;
    function LimparFormatacao(const AValor: string): string;
    function ToString: string; override;
    function Equals(OutroDocumento: TDocumento): Boolean;

    property CNPJ: string read FCNPJ write FCNPJ;
    property CPF: string read FCPF write FCPF;
  end;

implementation

{ TDocumento }

constructor TDocumento.Create;
begin
  inherited Create;
  // Construtor Vazio
end;

constructor TDocumento.Create(const ACNPJ, ACPF: string);
begin
  inherited Create;
  FCNPJ := ACNPJ;
  FCPF := ACPF;

  Validar();
end;

procedure TDocumento.Validar;
begin
  if (FCNPJ <> '') and not ValidarCNPJ then
    raise EDocumentoInvalidoException.Create('CNPJ inválido: ' + FCNPJ);

  if (FCPF <> '') and not ValidarCPF then
    raise EDocumentoInvalidoException.Create('CPF inválido: ' + FCPF);
end;

function TDocumento.ValidarCNPJ: Boolean;
begin
  Result := (FCNPJ = '') or TValidadores.ValidarCNPJ(FCNPJ);
end;

function TDocumento.ValidarCPF: Boolean;
begin
  Result := (FCPF = '') or TValidadores.ValidarCPF(FCPF);
end;

function TDocumento.ToString: string;
begin
  if FCNPJ <> '' then
    Result := FCNPJ
  else if FCPF <> '' then
    Result := FCPF
  else
    Result := '';
end;

function TDocumento.Equals(OutroDocumento: TDocumento): Boolean;
begin
  if not Assigned(OutroDocumento) then
    Exit(False);

  Result := (FCNPJ = OutroDocumento.CNPJ) and (FCPF = OutroDocumento.CPF);
end;

function TDocumento.LimparFormatacao(const AValor: string): string;
begin
  Result := AValor.Replace('.', '').Replace('-', '').Replace('/', '');
end;

end.




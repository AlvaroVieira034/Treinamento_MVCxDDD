unit DocumentoValueObject;

interface

uses System.SysUtils, System.RegularExpressions, Validadores;

type
  EDocumentoInvalidoException = class(Exception);
  TDocumento = class

  private
    FCNPJ: string;
    FCPF: string;

  public
    constructor Create; overload;
    constructor Create(const ACNPJ, ACPF: string); overload;

    procedure Validar(ATipoCliente: Integer);
    function ValidarCNPJ: Boolean;
    function ValidarCPF: Boolean;
    function LimparFormatacao(const AValor: string): string;
    function ToString: string; override;
    function Equals(OutroDocumento: TDocumento): Boolean;
    function ObterErrosValidacao(ATipoCliente: Integer): TArray<string>;

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
end;

procedure TDocumento.Validar(ATipoCliente: Integer);
begin
  case ATipoCliente of
    0: // Pessoa Física
      if (FCPF <> '') and not ValidarCPF then
        raise EDocumentoInvalidoException.Create('CPF inválido: ' + FCPF);

    1: // Pessoa Jurídica
      if (FCNPJ <> '') and not ValidarCNPJ then
        raise EDocumentoInvalidoException.Create('CNPJ inválido: ' + FCNPJ);
    else
      EDocumentoInvalidoException.Create('Tipo de cliente inválido!');
  end;
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

function TDocumento.ObterErrosValidacao(ATipoCliente: Integer): TArray<string>;
begin
  Result := [];
  case ATipoCliente of
    0: // Pessoa Física
      if not ValidarCPF then
        Result := Result + ['CPF inválido: ' + FCPF];
    1: // Pessoa Jurídica
      if not ValidarCNPJ then
        Result := Result + ['CNPJ inválido: ' + FCNPJ];
  end;


end;

end.




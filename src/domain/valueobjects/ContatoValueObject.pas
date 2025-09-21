unit ContatoValueObject;

interface

uses System.SysUtils, System.RegularExpressions, Validadores;

type
  EContatoInvalidoException = class(Exception);
  TContato = class

  private
    FTelefone: string;
    FEmail: string;

  public
    constructor Create; overload;
    constructor Create(const ATelefone, AEmail: string); overload;

    procedure Validar;
    function ValidarTelefone: Boolean;
    function ValidarEmail: Boolean;
    function ToString: string; override;
    function Equals(OutroContato: TContato): Boolean;
    function ObterErrosValidacao: TArray<string>;

    property Telefone: string read FTelefone write FTelefone;
    property Email: string read FEmail write FEmail;
  end;

implementation

{ TContato }

constructor TContato.Create;
begin
  inherited Create;
  // Construtor Vazio
end;

constructor TContato.Create(const ATelefone, AEmail: string);
begin
  inherited Create;
  FTelefone := ATelefone;
  FEmail := AEmail;

  Validar();
end;

procedure TContato.Validar;
begin
  if (FTelefone <> '') and not ValidarTelefone then
    raise EContatoInvalidoException.Create('Telefone inv�lido: ' + FTelefone);

  if (FEmail <> '') and not ValidarEmail then
    raise EContatoInvalidoException.Create('Email inv�lido: ' + FEmail);
end;

function TContato.ValidarTelefone: Boolean;
begin
  Result := (FTelefone = '') or TValidadores.ValidarTelefone(FTelefone);
end;

function TContato.ValidarEmail: Boolean;
begin
  Result := (FEmail = '') or TValidadores.ValidarEmail(FEmail);
end;

function TContato.ToString: string;
begin
  if FTelefone <> '' then
    Result := FTelefone
  else if FEmail <> '' then
    Result := FEmail
  else
    Result := '';
end;

function TContato.Equals(OutroContato: TContato): Boolean;
begin
  if not Assigned(OutroContato) then
    Exit(False);

  Result := (FTelefone = OutroContato.Telefone) and (FEmail = OutroContato.Email);
end;

function TContato.ObterErrosValidacao: TArray<string>;
begin
  Result := [];
  // Telefone � opcional, mas se preenchido deve ser v�lido
  if (FTelefone.Trim <> '') and (not ValidarTelefone) then
    Result := Result + ['Telefone inv�lido: ' + FTelefone];

  // Email � opcional, mas se preenchido deve ser v�lido
  if (FEmail.Trim <> '') and (not ValidarEmail) then
    Result := Result + ['Email inv�lido: ' + FEmail];
end;

end.


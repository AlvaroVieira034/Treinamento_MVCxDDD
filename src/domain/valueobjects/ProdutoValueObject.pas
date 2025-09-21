unit ProdutoValueObject;

interface

uses
  System.SysUtils, System.RegularExpressions;

type
  EDescricaoProdutoException = class(Exception);
  EMarcaProdutoException = class(Exception);
  EPrecoProdutoException = class(Exception);

  TDescricaoProduto = class
  private
    FValor: string;
    procedure SetValor(const Value: string);

  public
    procedure Validar;
    property Valor: string read FValor write SetValor;

  end;

  TMarcaProduto = class
  private
    FValor: string;
    procedure SetValor(const Value: string);

  public
    procedure Validar;
    property Valor: string read FValor write SetValor;

  end;

  TPrecoProduto = class
  private
    FValor: Double;
    procedure SetValor(const Value: Double);

  public
    procedure Validar;
    property Valor: Double read FValor write SetValor;

  end;

implementation

{ TDescricaoProduto }

procedure TDescricaoProduto.SetValor(const Value: string);
begin
  FValor := Value.Trim;
end;

procedure TDescricaoProduto.Validar;
begin
  if FValor = '' then
    raise EDescricaoProdutoException.Create('A descrição do produto não pode ser em branco!');

end;

{ TMarcaProduto }

procedure TMarcaProduto.SetValor(const Value: string);
begin
  FValor := Value.Trim;
end;

procedure TMarcaProduto.Validar;
begin
  if FValor = '' then
    raise EMarcaProdutoException.Create('A marca do produto não pode estar em branco!');

  if Length(FValor) < 5 then
    raise EMarcaProdutoException.Create('A marca do produto deve ter no minimo 5 caracteres!');

end;

{ TPrecoProduto }

procedure TPrecoProduto.SetValor(const Value: Double);
begin
  FValor := Value;
end;

procedure TPrecoProduto.Validar;
begin
  if FValor <= 0 then
    raise EPrecoProdutoException.Create('Preço do produto deve ser maior que zero!');

end;

end.

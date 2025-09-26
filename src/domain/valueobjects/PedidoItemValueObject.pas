unit PedidoItemValueObject;

interface

uses
  System.SysUtils;

type
  EProdutoPedidoException = class(Exception);
  EQuantidadePedidoException = class(Exception);
  EPrecoUnitarioPedidoException = class(Exception);
  EPrecoTotalItemException = class(Exception);

  TProdutoPedido = class
  private
    FValor: Integer;
    procedure SetValor(const Value: Integer);
  public
    procedure Validar;
    property Valor: Integer read FValor write SetValor;
  end;

  TQuantidadePedido = class
  private
    FValor: Integer;
    procedure SetValor(const Value: Integer);
  public
    procedure Validar;
    property Valor: Integer read FValor write SetValor;
  end;

  TPrecoUnitarioPedido = class
  private
    FValor: Double;
    procedure SetValor(const Value: Double);
  public
    procedure Validar;
    property Valor: Double read FValor write SetValor;
  end;

  TPrecoTotalItem = class
  private
    FValor: Double;
    procedure SetValor(const Value: Double);
  public
    procedure Validar;
    property Valor: Double read FValor write SetValor;
  end;

implementation

{ TProdutoPedido }

procedure TProdutoPedido.SetValor(const Value: Integer);
begin
  FValor := Value;
  Validar;
end;

procedure TProdutoPedido.Validar;
begin
  if FValor <= 0 then
    raise EProdutoPedidoException.Create('Produto deve ser informado.');
end;

{ TQuantidadePedido }

procedure TQuantidadePedido.SetValor(const Value: Integer);
begin
  FValor := Value;
  Validar;
end;

procedure TQuantidadePedido.Validar;
begin
  if FValor <= 0 then
    raise EQuantidadePedidoException.Create('Quantidade deve ser maior que zero.');
end;

{ TPrecoUnitarioPedido }

procedure TPrecoUnitarioPedido.SetValor(const Value: Double);
begin
  FValor := Value;
  Validar;
end;

procedure TPrecoUnitarioPedido.Validar;
begin
  if FValor <= 0 then
    raise EPrecoUnitarioPedidoException.Create('Preço unitário deve ser maior que zero.');
end;

{ TPrecoTotalItem }

procedure TPrecoTotalItem.SetValor(const Value: Double);
begin
  FValor := Value;
  Validar;
end;

procedure TPrecoTotalItem.Validar;
begin
  if FValor <= 0 then
    raise EPrecoTotalItemException.Create('Preço total do item deve ser maior que zero.');
end;

end.

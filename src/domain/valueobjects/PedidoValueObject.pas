unit PedidoValueObject;

interface

uses
  System.SysUtils, System.RegularExpressions, System.DateUtils;

type
  EDataPedidoException = class(Exception);
  EClientePedidoException = class(Exception);
  EValorPedidoException = class(Exception);

  TDataPedido = class
  private
    FValor: TDateTime;
    procedure SetValor(const Value: TDateTime);
  public
    procedure Validar;
    property Valor: TDateTime read FValor write SetValor;
  end;

  TClientePedido = class
  private
    FValor: Integer;
    procedure SetValor(const Value: Integer);
  public
    procedure Validar;
    property Valor: Integer read FValor write SetValor;
  end;

  TValorPedido = class
  private
    FValor: Double;
    procedure SetValor(const Value: Double);
  public
    procedure Validar;
    property Valor: Double read FValor write SetValor;
  end;

implementation

{ TDataPedido }

procedure TDataPedido.SetValor(const Value: TDateTime);
begin
  FValor := Value;
  Validar;
end;

procedure TDataPedido.Validar;
begin
  if FValor > Now then
    raise EDataPedidoException.Create('Data do pedido não pode ser futura.');
end;

{ TClientePedido }

procedure TClientePedido.SetValor(const Value: Integer);
begin
  FValor := Value;
  Validar;
end;

procedure TClientePedido.Validar;
begin
  if FValor <= 0 then
    raise EClientePedidoException.Create('Código do cliente deve ser maior que zero.');
end;

{ TValorPedido }

procedure TValorPedido.SetValor(const Value: Double);
begin
  FValor := Value;
  Validar;
end;

procedure TValorPedido.Validar;
begin
  if FValor < 0 then
    raise EValorPedidoException.Create('Valor do pedido não pode ser negativo.');
end;

end.

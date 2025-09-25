unit PedidoModel;

interface

uses
  System.SysUtils, System.Generics.Collections, PedidoValueObject, PedidoExceptions;

type
  EPedidoException = class(Exception);

  TPedido = class
  private
    FCod_Pedido: Integer;
    FDataPedido: TDataPedido;
    FClientePedido: TClientePedido;
    FValorPedido: TValorPedido;

    // Getters
    function GetDta_Pedido: TDateTime;
    function GetCod_Cliente: Integer;
    function GetVal_Pedido: Double;

    // Setters
    procedure SetDta_Pedido(const Value: TDateTime);
    procedure SetCod_Cliente(const Value: Integer);
    procedure SetVal_Pedido(const Value: Double);

  public
    constructor Create;
    destructor Destroy; override;

    procedure Validar;
    function ObterErrosValidacao: TArray<string>;

    property Cod_Pedido: Integer read FCod_Pedido write FCod_Pedido;
    property Dta_Pedido: TDateTime read GetDta_Pedido write SetDta_Pedido;
    property Cod_Cliente: Integer read GetCod_Cliente write SetCod_Cliente;
    property Val_Pedido: Double read GetVal_Pedido write SetVal_Pedido;

    // Value Objects (apenas leitura, para acesso interno se necessário)
    property DataPedidoVO: TDataPedido read FDataPedido;
    property ClientePedidoVO: TClientePedido read FClientePedido;
    property ValorPedidoVO: TValorPedido read FValorPedido;
  end;

implementation

{ TPedido }

constructor TPedido.Create;
begin
  FDataPedido := TDataPedido.Create;
  FClientePedido := TClientePedido.Create;
  FValorPedido := TValorPedido.Create;
end;

destructor TPedido.Destroy;
begin
  FDataPedido.Free;
  FClientePedido.Free;
  FValorPedido.Free;
  inherited;
end;

function TPedido.GetDta_Pedido: TDateTime;
begin
  Result := FDataPedido.Valor;
end;

function TPedido.GetCod_Cliente: Integer;
begin
  Result := FClientePedido.Valor;
end;

function TPedido.GetVal_Pedido: Double;
begin
  Result := FValorPedido.Valor;
end;

procedure TPedido.SetDta_Pedido(const Value: TDateTime);
begin
  FDataPedido.Valor := Value;
end;

procedure TPedido.SetCod_Cliente(const Value: Integer);
begin
  FClientePedido.Valor := Value;
end;

procedure TPedido.SetVal_Pedido(const Value: Double);
begin
  FValorPedido.Valor := Value;
end;

procedure TPedido.Validar;
var
  Erros: TArray<string>;
begin
  Erros := ObterErrosValidacao;
  if Length(Erros) > 0 then
    raise EPedidoException.Create(string.Join(sLineBreak, Erros));
end;

function TPedido.ObterErrosValidacao: TArray<string>;
begin
  Result := [];

  // Valida Data do Pedido
  try
    FDataPedido.Validar;
  except
    on E: EDataPedidoException do
      Result := Result + [E.Message];
  end;

  // Valida Código do Cliente
  try
    FClientePedido.Validar;
  except
    on E: EClientePedidoException do
      Result := Result + [E.Message];
  end;

  // Valida Valor do Pedido
  try
    FValorPedido.Validar;
  except
    on E: EValorPedidoException do
      Result := Result + [E.Message];
  end;
end;

end.

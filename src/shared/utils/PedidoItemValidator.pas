unit PedidoItemValidator;

interface

uses
  System.SysUtils, PedidoItemValueObject;

type
  TPedidoItemValidator = class
  public
    class function ValidarItem(ACodProduto: Integer; AQuantidade: Integer; APrecoUnitario, APrecoTotal: Double): TArray<string>;
  end;

implementation

{ TPedidoItemValidator }

class function TPedidoItemValidator.ValidarItem(ACodProduto: Integer; AQuantidade: Integer; APrecoUnitario, APrecoTotal: Double): TArray<string>;
var
  Produto: TProdutoPedido;
  Quantidade: TQuantidadePedido;
  PrecoUnitario: TPrecoUnitarioPedido;
  PrecoTotalItem: TPrecoTotalItem;
begin
  Result := [];

  // Valida Produto
  Produto := TProdutoPedido.Create;
  try
    try
      Produto.Valor := ACodProduto;
      Produto.Validar;
    except
      on E: EProdutoPedidoException do
        Result := Result + [E.Message];
    end;
  finally
    Produto.Free;
  end;

  // Valida Quantidade
  Quantidade := TQuantidadePedido.Create;
  try
    try
      Quantidade.Valor := AQuantidade;
      Quantidade.Validar;
    except
      on E: EQuantidadePedidoException do
        Result := Result + [E.Message];
    end;
  finally
    Quantidade.Free;
  end;

  // Valida Preço Unitário
  PrecoUnitario := TPrecoUnitarioPedido.Create;
  try
    try
      PrecoUnitario.Valor := APrecoUnitario;
      PrecoUnitario.Validar;
    except
      on E: EPrecoUnitarioPedidoException do
        Result := Result + [E.Message];
    end;
  finally
    PrecoUnitario.Free;
  end;

  // Valida Preço Total
  PrecoTotalItem := TPrecoTotalItem.Create;
  try
    try
      PrecoTotalItem.Valor := APrecoTotal;
      PrecoTotalItem.Validar;
    except
      on E: EPrecoTotalItemException do
        Result := Result + [E.Message];
    end;
  finally
    PrecoTotalItem.Free;
  end;
end;

end.

unit PedidoExceptions;

interface

uses
  System.SysUtils;

type
  EPedidoException = class(Exception);

  EPedidoNaoEncontradoException = class(EPedidoException)
  public
    constructor Create(APedidoId: Integer);
  end;

implementation

{ EPedidoNaoEncontradoException }

constructor EPedidoNaoEncontradoException.Create(APedidoId: Integer);
begin
  inherited CreateFmt('Pedido com ID %d n�o encontrado!', [APedidoId]);
end;

end.

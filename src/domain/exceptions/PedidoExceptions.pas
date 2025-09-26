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

  EPedidoSemItensException = class(EPedidoException)
  public
    constructor Create;
  end;

  EPedidoValidacaoException = class(EPedidoException)
  private
    FErros: TArray<string>;
  public
    constructor Create(const AErros: TArray<string>);
    property Erros: TArray<string> read FErros;
  end;

implementation

{ EPedidoNaoEncontradoException }

constructor EPedidoNaoEncontradoException.Create(APedidoId: Integer);
begin
  inherited CreateFmt('Pedido com ID %d não encontrado!', [APedidoId]);
end;

{ EPedidoSemItensException }

constructor EPedidoSemItensException.Create;
begin
  inherited Create('Pedido deve conter pelo menos um item.');
end;

{ EPedidoValidacaoException }

constructor EPedidoValidacaoException.Create(const AErros: TArray<string>);
begin
  inherited Create('Erros de validação no pedido:' + sLineBreak + string.Join(sLineBreak, AErros));
  FErros := AErros;
end;

end.

unit ProdutoExceptions;

interface

uses
  System.SysUtils;

type
  EProdutoException = class(Exception);

  EDescricaoDuplicadaException = class(EProdutoException)
  public
    constructor Create(const ADescricao: string);
  end;

  EProdutoNaoEncontradoException = class(EProdutoException)
  public
    constructor Create(AProdutoId: Integer);
  end;

  EProdutoNaoPodeSerExcluidoException = class(EProdutoException)
  public
    constructor Create(AProdutoId: Integer);
  end;

implementation

{ EDescricaoDuplicadaException }

constructor EDescricaoDuplicadaException.Create(const ADescricao: string);
begin
  inherited CreateFmt('Produto com descrição "%s" já está cadastrado!', [ADescricao]);
end;

{ EProdutoNaoEncontradoException }

constructor EProdutoNaoEncontradoException.Create(AProdutoId: Integer);
begin
  inherited CreateFmt('Produto com ID %d não encontrado!', [AProdutoId]);
end;

{ EProdutoNaoPodeSerExcluidoException }

constructor EProdutoNaoPodeSerExcluidoException.Create(AProdutoId: Integer);
begin
  inherited CreateFmt('Produto ID %d não pode ser excluído pois possui pedidos associados.', [AProdutoId]);
end;


end.

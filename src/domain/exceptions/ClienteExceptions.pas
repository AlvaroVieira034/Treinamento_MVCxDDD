unit ClienteExceptions;

interface

uses
  System.SysUtils;

type
  EClienteException = class(Exception);

  ECNPJDuplicadoException = class(EClienteException)
  public
    constructor Create(const ACNPJ: string);
  end;

  EClienteNaoEncontradoException = class(EClienteException)
  public
    constructor Create(AClienteId: Integer);
  end;

  EClienteNaoPodeSerExcluidoException = class(EClienteException)
  public
    constructor Create(AClienteId: Integer);
  end;

implementation

{ ECNPJDuplicadoException }
constructor ECNPJDuplicadoException.Create(const ACNPJ: string);
begin
  inherited CreateFmt('CNPJ %s já está cadastrado para outro cliente!', [ACNPJ]);
end;

{ EClienteNaoEncontradoException }
constructor EClienteNaoEncontradoException.Create(AClienteId: Integer);
begin
  inherited CreateFmt('Cliente com ID %d não encontrado!', [AClienteId]);
end;

{ EClienteNaoPodeSerExcluidoException }
constructor EClienteNaoPodeSerExcluidoException.Create(AClienteId: Integer);
begin
  inherited CreateFmt(
    'Cliente ID %d não pode ser excluído pois possui pedidos associados. ' +
    'Considere desativar o cliente ao invés de excluí-lo.',
    [AClienteId]
  );
end;

end.

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
  inherited CreateFmt('CNPJ %s j� est� cadastrado para outro cliente!', [ACNPJ]);
end;

{ EClienteNaoEncontradoException }
constructor EClienteNaoEncontradoException.Create(AClienteId: Integer);
begin
  inherited CreateFmt('Cliente com ID %d n�o encontrado!', [AClienteId]);
end;

{ EClienteNaoPodeSerExcluidoException }
constructor EClienteNaoPodeSerExcluidoException.Create(AClienteId: Integer);
begin
  inherited CreateFmt(
    'Cliente ID %d n�o pode ser exclu�do pois possui pedidos associados. ' +
    'Considere desativar o cliente ao inv�s de exclu�-lo.',
    [AClienteId]
  );
end;

end.

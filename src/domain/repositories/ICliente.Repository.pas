unit ICliente.Repository;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Classes, ClienteModel,
  Data.DB, FireDAC.Comp.Client;

type
  IClienteRepository = interface
    ['{E4079FDB-BAA0-4346-B472-15760A95B496}']

    function Inserir(ACliente: TCliente): Boolean;
    function Alterar(ACliente: TCliente; AId: Integer): Boolean;
    function Excluir(AId: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;

  end;

implementation


end.

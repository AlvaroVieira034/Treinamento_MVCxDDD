unit IPedido.Repository;

interface

uses PedidoModel, Data.DB, FireDAC.Comp.Client, System.SysUtils;

type
  IPedidoRepository = interface
    ['{10BD09CC-F2BF-44E3-A663-C747A365F2C3}']
    function Inserir(APedido: TPedido): Boolean;
    function Alterar(APedido: TPedido; AId: Integer): Boolean;
    function Excluir(AId: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;
    procedure CriarTabelas;

  end;

implementation

end.

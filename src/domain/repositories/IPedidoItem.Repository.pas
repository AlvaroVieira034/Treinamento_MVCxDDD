unit IPedidoItem.Repository;

interface

uses PedidoItemModel, Data.DB, FireDAC.Comp.Client, System.SysUtils, System.Classes,
     System.Generics.Collections;

type
  IPedidoItemRepository = interface
    ['{C984ABA8-9A93-4239-B0EF-49256221BF7F}']
    function CarregarItensPedido(ACodPedido: Integer): TList<TPedidoItem>;
    function Inserir(APedidoItem: TPedidoItem): Boolean;
    function Excluir(ACodigo: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;
    procedure CriarTabelas;
  end;

implementation

end.

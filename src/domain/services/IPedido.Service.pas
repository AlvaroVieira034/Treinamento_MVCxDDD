unit IPedido.Service;

interface

uses PedidoModel, Data.DB, FireDAC.Comp.Client;

type
  IPedidoService = interface
    ['{30AA9E08-E699-42F9-ACE6-C9DC2DBABB79}']
    procedure PreencherGridPedidos(APesquisa, ACampo: string);
    procedure PreencherCamposForm(APedido: TPedido; AId: Integer);
    procedure PreencherGridRelatorio(ADataDe, ADataAte: string; CkRelatorio: Integer);
    procedure ExibirResumoPedido(CodPedido: Integer);
    procedure ValidarPedido(APedido: TPedido);
    procedure CriarTabelas;
    function GetDataSource: TDataSource;

  end;

implementation


end.

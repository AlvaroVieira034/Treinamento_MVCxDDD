unit IProduto.Service;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Classes, ProdutoModel, ProdutoDTO,
  Data.DB, FireDAC.Comp.Client;

type
  IProdutoService = interface
    ['{9EFCC396-E956-484A-B5F3-0328A109E66B}']

    // Métodos de Consulta
    procedure PreencheGridProdutos(APesquisa, ACampo: string);
    procedure PreencherComboProdutos(TblProdutos: TFDQuery);
    procedure PreencherCamposForm(AProduto: TProduto; AId: Integer);
    procedure ValidarProduto(AProduto: TProduto);
    function BuscarProdutoPorCodigo(AProduto: TProduto; AId: Integer): TProduto;
    function ProdutoPodeSerExcluido(AProdutoId: Integer): Boolean;

    // Metodos para criação de tabeas
    procedure CriarTabelas;
    function GetDataSource: TDataSource;

  end;

implementation

end.

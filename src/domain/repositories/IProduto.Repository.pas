unit IProduto.Repository;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Classes, ProdutoModel,
  Data.DB, FireDAC.Comp.Client;

type
  IProdutoRepository = interface
    ['{531188BE-441C-4884-99BB-2F9FCDAB71AB}']
    function Inserir(AProduto: TProduto): Boolean;
    function Alterar(AProduto: TProduto; AId: Integer): Boolean;
    function Excluir(AId: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;
    procedure CriarTabelas;

  end;

implementation

end.

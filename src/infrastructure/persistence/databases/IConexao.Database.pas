unit IConexao.Database;

interface

uses
  Data.DB, FireDAC.Comp.Client;

type
  IConexaoDatabase = interface
    ['{D6F231F8-B29A-4F3A-938E-C5CC8A186236}']
    function GetConexao: TFDConnection;
    function TestarConexao: Boolean;
    function CriarQuery: TFDQuery;
    function CriarDataSource: TDataSource;
    function CriarTransaction: TFDTransaction;
    procedure IniciarTransacao;
    procedure CommitTransacao;
    procedure RollbackTransacao;
  end;

implementation

end.

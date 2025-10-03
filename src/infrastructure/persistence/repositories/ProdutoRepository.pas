unit ProdutoRepository;

interface

uses
  ProdutoModel, Conexao, ConexaoSingleton, IProduto.Repository, ProdutoDTO,
  ProdutoExceptions, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TProdutoRepository = class(TInterfacedObject, IProdutoRepository)

  private
    QryProdutos: TFDQuery;
    Transacao: TFDTransaction;
    Conexao: TConexao;

    // Constantes SQL
    const
      SQL_INSERT =
        'insert into tab_produto(' +
        'des_descricao, des_marca, val_preco) ' +
        'values (' +
        ':des_descricao, :des_marca, :val_preco)';

      SQL_UPDATE =
        'update tab_produto set ' +
        'des_descricao = :des_descricao, ' +
        'des_marca = :des_marca, ' +
        'val_preco = :val_preco ' +
        'where cod_produto = :cod_produto';

  public
    constructor Create;
    destructor Destroy; override;

    function Inserir(AProduto: TProduto): Boolean;
    function Alterar(AProduto: TProduto; AId: Integer): Boolean;
    function Excluir(AId: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;
    procedure CriarTabelas;

  end;

implementation

{ TProdutoRepository }

constructor TProdutoRepository.Create;
begin
  inherited Create();
  CriarTabelas();
end;

destructor TProdutoRepository.Destroy;
begin
  QryProdutos.Free;

  inherited;
end;

function TProdutoRepository.Inserir(AProduto: TProduto): Boolean;
var DTO: TProdutoDTO;
begin
  DTO := TProdutoDTO.FromEntity(AProduto);
  try
    Result := ExecutarTransacao(
      procedure
      begin
        with QryProdutos do
        begin
          Close;
          SQL.Clear;
          SQL.Text := SQL_INSERT;
          DTO.MapearParaQuery(QryProdutos);
          ExecSQL;
        end;
      end);
  finally
    DTO.Free
  end;

end;

function TProdutoRepository.Alterar(AProduto: TProduto; AId: Integer): Boolean;
var DTO: TProdutoDTO;
begin
  DTO := TProdutoDTO.FromEntity(AProduto);
  try
    Result := ExecutarTransacao(
      procedure
      begin
        with QryProdutos do
        begin
          Close;
          SQL.Clear;
          SQL.Text := SQL_UPDATE;
          DTO.MapearParaQuery(QryProdutos);
          ParamByName('COD_PRODUTO').AsInteger := AId;
          ExecSQL;
        end;
      end);
  finally
    DTO.Free
  end;

end;

function TProdutoRepository.Excluir(AId: Integer): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryProdutos do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'delete from tab_produto where cod_produto = :cod_produto';
        ParamByName('COD_PRODUTO').AsInteger := AId;

        ExecSQL;
      end;
    end);
end;

function TProdutoRepository.ExecutarTransacao(AOperacao: TProc): Boolean;
begin
  Result := False;
  if not Transacao.Connection.Connected then
    Transacao.Connection.Open();

  Transacao.StartTransaction;
  try
    AOperacao;
    Transacao.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      Transacao.Rollback;
      raise Exception.Create('Ocorreu um erro na transação do produto! Erro: ' + E.Message);
    end;
  end;
end;

procedure TProdutoRepository.CriarTabelas;
begin
  QryProdutos := TConexao.GetInstance.Connection.CriarQuery;
  Transacao := TConexao.GetInstance.Connection.CriarTransaction;
  QryProdutos.Transaction := Transacao;
end;

end.

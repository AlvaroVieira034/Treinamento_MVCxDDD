unit ProdutoService;

interface

uses
  ProdutoModel, ConexaoAdapter, IProduto.Service, ProdutoExceptions, ProdutoDTO, System.SysUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TProdutoService = class(TInterfacedObject, IProdutoService)

  private
    TblProdutos: TFDQuery;
    QryTemp: TFDQuery;
    DsProdutos: TDataSource;
    Conexao: TConexao;
    FConexao: TFDConnection;

  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;

    // Metodos de Acesso a banco de dados -> View
    procedure PreencheGridProdutos(APesquisa, ACampo: string);
    procedure PreencherComboProdutos(TblProdutos: TFDQuery);
    procedure PreencherCamposForm(AProduto: TProduto; AId: Integer);
    function BuscarProdutoPorCodigo(AId: Integer): TProduto;

    // Metódos de Validação
    procedure ValidarProduto(AProduto: TProduto);
    procedure ValidarDescricaoUnica(const ADescricao: string; ACodigoProduto: Integer);
    function VerificarDescricaoExistente(const ADescricao: string; ACodigoProduto: Integer): Boolean;
    function ProdutoPodeSerExcluido(AProdutoId: Integer): Boolean;

    // Metodos de criação de DataSets
    procedure CriarTabelas;
    function GetDataSource: TDataSource;

  end;

implementation

{ TProdutoService }

constructor TProdutoService.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConexao := AConnection;
  CriarTabelas();
end;

destructor TProdutoService.Destroy;
begin
  TblProdutos.Free;
  QryTemp.Free;
  DsProdutos.Free;
  inherited Destroy;
end;

procedure TProdutoService.PreencheGridProdutos(APesquisa, ACampo: string);
begin
  with TblProdutos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select prd.cod_produto, ');
    SQL.Add('prd.des_descricao, ');
    SQL.Add('prd.des_marca, ');
    SQL.Add('prd.val_preco ');
    SQL.Add('from tab_produto prd');
    SQL.Add('where ' + ACampo + ' like :pNOME');
    SQL.Add('order by ' + ACampo);
    ParamByName('PNOME').AsString := APesquisa;
    Open();
  end;
end;

procedure TProdutoService.PreencherComboProdutos(TblProdutos: TFDQuery);
begin
  with TblProdutos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select prd.des_descricao from tab_produto prd order by prd.des_descricao ');
    Open();
  end;
end;

procedure TProdutoService.PreencherCamposForm(AProduto: TProduto; AId: Integer);
var DTO: TProdutoDTO;
begin
  with TblProdutos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select prd.cod_produto,  ');
    SQL.Add('prd.des_descrricao, ');
    SQL.Add('prd.des_marca, ');
    SQL.Add('prd.val_preco ');
    SQL.Add('from tab_produto prd');
    SQL.Add('where cod_produto = :cod_produto');
    ParamByName('cod_produto').AsInteger := AId;
    Open;

    if not IsEmpty then
    begin
      DTO := TProdutoDTO.FromDataset(TblProdutos);
      try
        DTO.ToEntity(AProduto);
      finally
        DTO.Free;
      end;
    end
    else
      raise Exception.Create('Produto não encontrado com ID: ' + IntToStr(AId));

  end;

end;

function TProdutoService.BuscarProdutoPorCodigo(AId: Integer): TProduto;
var Query: TFDQuery;
    DTO: TProdutoDTO;
begin
  Result := TProduto.Create;
  try
    Query := Conexao.CriarQuery();
    try
      with Query do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select prd.cod_produto,  ');
        SQL.Add('prd.des_descricao, ');
        SQL.Add('prd.des_marca, ');
        SQL.Add('prd.val_preco ');
        SQL.Add('from tab_produto prd');
        SQL.Add('where cod_produto = :cod_produto');
        ParamByName('cod_produto').AsInteger := AId;
        Open;

        if not IsEmpty then
        begin
          DTO := TProdutoDTO.FromDataset(Query);
          try
            DTO.ToEntity(Result);
          finally
            DTO.Free;
          end;
        end
        else
          raise Exception.Create('Produto não encontrado!');
      end;
    finally
      Query.Free;
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TProdutoService.ValidarProduto(AProduto: TProduto);
begin
  // Validações básicas da entidade
  AProduto.Validar;

  // Validações de negócio (Descrição única)
  if VerificarDescricaoExistente(AProduto.Des_Descricao, AProduto.Cod_Produto) then
    raise EDescricaoDuplicadaException.Create(AProduto.Des_Descricao);
end;

procedure TProdutoService.ValidarDescricaoUnica(const ADescricao: string; ACodigoProduto: Integer);
begin
  if VerificarDescricaoExistente(ADescricao, ACodigoProduto) then
    raise EDescricaoDuplicadaException.Create(ADescricao);
end;

function TProdutoService.VerificarDescricaoExistente(const ADescricao: string; ACodigoProduto: Integer): Boolean;
begin
  Result := False;
  QryTemp.Close;
  QryTemp.SQL.Add('select count(*) as quant from tab_produto where des_descricao = :des_descricao');
  if ACodigoProduto > 0 then
  begin
    QryTemp.SQL.Text := QryTemp.SQL.Text + ' and cod_produto <> :cod_produto';
    QryTemp.ParamByName('COD_PRODUTO').AsInteger := ACodigoProduto;
  end;

  QryTemp.ParamByName('DES_DESCRICAO').AsString := ADescricao;
  QryTemp.Open();

  Result := QryTemp.FieldByName('QUANT').AsInteger > 0;
end;

function TProdutoService.ProdutoPodeSerExcluido(AProdutoId: Integer): Boolean;
begin
  Result := False;
  if AProdutoId <= 0 then
    Exit(False);

  QryTemp.Close;
  QryTemp.SQL.Text := ('select count(*) as quant from tab_pedido where cod_produto = :cod_produto');
  QryTemp.ParamByName('COD_PRODUTO').AsInteger := AProdutoId;
  QryTemp.Open;

  Result := QryTemp.FieldByName('QUANT').AsInteger = 0;
end;

procedure TProdutoService.CriarTabelas;
begin
  TblProdutos := Conexao.CriarQuery;
  QryTemp := Conexao.CriarQuery;
  DsProdutos := Conexao.CriarDataSource;
  DsProdutos.DataSet := TblProdutos;
end;

function TProdutoService.GetDataSource: TDataSource;
begin
  Result := DsProdutos;
end;


end.

unit ProdutoAppSevice;

interface

uses
  ProdutoModel, IProduto.Repository, IProduto.Service, ProdutoRepository, ProdutoService,
  ProdutoDTO, ProdutoExceptions, System.SysUtils, System.Generics.Collections, System.Classes,
  Data.DB, FireDAC.Comp.Client;

type
  TProdutoAppService = class

  private
    FProdutoRepository: TProdutoRepository;
    FProdutoService: TProdutoService;

    function EntityToDTO(AProduto: TProduto): TProdutoDTO;
    function DTOToEntity(AProdutoDTO: TProdutoDTO): TProduto;

  public
    constructor Create(AProdutoRepository: IProdutoRepository; AProdutoService: IProdutoService);
    destructor Destroy;

    procedure PreencheGridProdutos(APesquisa, ACampo: string);
    procedure PreencherComboProdutos(TblComboProdutos: TFDQuery);
    function BuscarProdutoPorCodigo(AProduto: TProduto; AId: Integer): TProduto;
    function Inserir(AProduto: TProduto): Boolean;
    function Alterar(AProduto: TProduto; ACodigo: Integer): Boolean;
    function Excluir(ACodigo: Integer): Boolean;
    function GetValorUnitario(ACodigo: Integer): Double;
    function ValidarProduto(AProduto: TProduto): Boolean;
    function GetDataSource: TDataSource;
  end;

implementation

{ TProdutoAppService }


constructor TProdutoAppService.Create(AProdutoRepository: IProdutoRepository; AProdutoService: IProdutoService);
begin
  FProdutoRepository := TProdutoRepository.Create;
  FProdutoService := TProdutoService.Create;
end;

destructor TProdutoAppService.Destroy;
begin
  FProdutoRepository.Free;
  FProdutoService.Free;
end;

procedure TProdutoAppService.PreencheGridProdutos(APesquisa, ACampo: string);
begin
  FProdutoService.PreencheGridProdutos(APesquisa, ACampo);
end;

procedure TProdutoAppService.PreencherComboProdutos(TblComboProdutos: TFDQuery);
begin
  FProdutoService.PreencherComboProdutos(TblComboProdutos);
end;

function TProdutoAppService.BuscarProdutoPorCodigo(AProduto: TProduto; AId: Integer): TProduto;
begin
  Result := FProdutoService.BuscarProdutoPorCodigo(AProduto, AId);
  if not Assigned(Result) then
    raise EProdutoNaoEncontradoException.Create(AId);
end;

function TProdutoAppService.Inserir(AProduto: TProduto): Boolean;
begin
  ValidarProduto(AProduto);
  Result := FProdutoRepository.Inserir(AProduto);
end;

function TProdutoAppService.Alterar(AProduto: TProduto; ACodigo: Integer): Boolean;
begin
  ValidarProduto(AProduto);
  Result := FProdutoRepository.Alterar(AProduto, ACodigo);
end;

function TProdutoAppService.Excluir(ACodigo: Integer): Boolean;
begin
  if not FProdutoService.ProdutoPodeSerExcluido(ACodigo) then
    raise EProdutoNaoPodeSerExcluidoException.Create(ACodigo);

  Result := FProdutoRepository.Excluir(ACodigo);
end;

function TProdutoAppService.ValidarProduto(AProduto: TProduto): Boolean;
begin
    try
    // Delega a validação para o Domain Service
    FProdutoService.ValidarProduto(AProduto);
    Result := True;
  except
    on E: EProdutoException do
      raise; // Re-lança exceções de validação
    on E: EDescricaoDuplicadaException do
      raise; // Re-lança exceções de negócio
    on E: Exception do
      raise EProdutoException.Create('Erro inesperado na validação: ' + E.Message);
  end;
end;

function TProdutoAppService.GetDataSource: TDataSource;
begin
  Result := FProdutoService.GetDataSource();
end;

function TProdutoAppService.GetValorUnitario(ACodigo: Integer): Double;
begin
  Result := (FProdutoService as TProdutoService).GetValorUnitario(ACodigo);
end;

function TProdutoAppService.EntityToDTO(AProduto: TProduto): TProdutoDTO;
begin
  Result := TProdutoDTO.Create;
  try
    Result.Cod_Produto := AProduto.Cod_Produto;
    Result.Des_Descricao := AProduto.Des_Descricao;
    Result.Des_Marca := AProduto.Des_Marca;
    Result.Val_Preco := AProduto.Val_Preco;
  except
    Result.Free;
    raise;
  end;
end;

function TProdutoAppService.DTOToEntity(AProdutoDTO: TProdutoDTO): TProduto;
begin
  Result := TProduto.Create;
  Result.Cod_Produto := AProdutoDTO.Cod_Produto;
  Result.Des_Descricao := AProdutoDTO.Des_Descricao;
  Result.Des_Marca := AProdutoDTO.Des_Marca;
  Result.Val_Preco := AProdutoDTO.Val_Preco;
end;

end.

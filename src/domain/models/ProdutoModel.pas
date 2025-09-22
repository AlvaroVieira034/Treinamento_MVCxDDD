unit ProdutoModel;

interface

uses
  System.SysUtils,
  ProdutoValueObject,
  ProdutoExceptions;

type
  EProdutoException = class(Exception);

  TProduto = class
  private
    FCod_Produto: Integer;
    FDescricao: TDescricaoProduto;
    FMarca: TMarcaProduto;
    FPreco: TPrecoProduto;

    // Getters
    function GetDes_Descricao: string;
    function GetDes_Marca: string;
    function GetVal_Preco: Double;

    // Setters
    procedure SetDes_Descricao(const Value: string);
    procedure SetDes_Marca(const Value: string);
    procedure SetVal_Preco(const Value: Double);

  public
    constructor Create;
    destructor Destroy; override;

    // Comportamentos
    procedure Validar;
    function ObterErrosValidacao: TArray<string>;

    // Properties
    property Cod_Produto: Integer read FCod_Produto write FCod_Produto;
    property Des_Descricao: string read GetDes_Descricao write SetDes_Descricao;
    property Des_Marca: string read GetDes_Marca write SetDes_Marca;
    property Val_Preco: Double read GetVal_Preco write SetVal_Preco;

    // Value Objects
    property DescricaoVO: TDescricaoProduto read FDescricao;
    property MarcaVO: TMarcaProduto read FMarca;
    property PrecoVO: TPrecoProduto read FPreco;
  end;

implementation

{ TProduto }

constructor TProduto.Create;
begin
  inherited Create;
  FDescricao := TDescricaoProduto.Create;
  FMarca := TMarcaProduto.Create;
  FPreco := TPrecoProduto.Create;
end;

destructor TProduto.Destroy;
begin
  FDescricao.Free;
  FMarca.Free;
  FPreco.Free;
  inherited Destroy;
end;

function TProduto.GetDes_Descricao: string;
begin
  Result := FDescricao.Valor;
end;

function TProduto.GetDes_Marca: string;
begin
  Result := FMarca.Valor;
end;

function TProduto.GetVal_Preco: Double;
begin
  Result := FPreco.Valor;
end;

procedure TProduto.SetDes_Descricao(const Value: string);
begin
  FDescricao.Valor := Value;
end;

procedure TProduto.SetDes_Marca(const Value: string);
begin
  FMarca.Valor := Value;
end;

procedure TProduto.SetVal_Preco(const Value: Double);
begin
  FPreco.Valor := Value;
end;

procedure TProduto.Validar;
var
  Erros: TArray<string>;
begin
  Erros := ObterErrosValidacao;
  if Length(Erros) > 0 then
    raise EProdutoException.Create(string.Join(sLineBreak, Erros));
end;

function TProduto.ObterErrosValidacao: TArray<string>;
begin
  Result := [];

  // Valida Descrição
  try
    FDescricao.Validar;
  except
    on E: EDescricaoProdutoException do
      Result := Result + [E.Message];
  end;

  // Valida Marca
  try
    FMarca.Validar;
  except
    on E: EMarcaProdutoException do
      Result := Result + [E.Message];
  end;

  // Valida Preço
  try
    FPreco.Validar;
  except
    on E: EPrecoProdutoException do
      Result := Result + [E.Message];
  end;
end;

end.

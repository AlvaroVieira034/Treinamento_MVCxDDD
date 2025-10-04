unit ProdutoDTO;

interface

uses
  System.SysUtils, ProdutoModel, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TProdutoDTO = class

  private
    FCod_Produto: Integer;
    FDes_Descricao: string;
    FDes_Marca: string;
    FVal_Preco: Double;

  public
    constructor Create; overload;
    constructor Create(ACod_Produto: Integer; ADes_Descricao, ADes_Marca: string; AVal_Preco: Double); overload;

    // Métodos de conversão
    class function FromEntity(AProduto: TProduto): TProdutoDTO;
    class function FromDataset(ADataset: TDataSet): TProdutoDTO;
    procedure ToEntity(var AProduto: TProduto);
    procedure MapearParaQuery(AQuery: TFDQuery);

    // Properties
    property Cod_Produto: Integer read FCod_Produto write FCod_Produto;
    property Des_Descricao: string read FDes_Descricao write FDes_Descricao;
    property Des_Marca: string read FDes_Marca write FDes_Marca;
    property Val_Preco: Double read FVal_Preco write FVal_Preco;

  end;

implementation

{ TProdutoDTO }

constructor TProdutoDTO.Create;
begin
  inherited Create;
  // Construtor vazio
end;

constructor TProdutoDTO.Create(ACod_Produto: Integer; ADes_Descricao, ADes_Marca: string; AVal_Preco: Double);
begin
  inherited Create;
  FCod_Produto := ACod_Produto;
  FDes_Descricao := ADes_Descricao;
  FDes_Marca := ADes_Marca;
  FVal_Preco := AVal_Preco;
end;

class function TProdutoDTO.FromEntity(AProduto: TProduto): TProdutoDTO;
begin
  Result := TProdutoDTO.Create;
  Result.Cod_Produto := AProduto.Cod_Produto;
  Result.Des_Descricao := AProduto.Des_Descricao;
  Result.Des_Marca := AProduto.Des_Marca;
  Result.Val_Preco := AProduto.Val_Preco;
end;

class function TProdutoDTO.FromDataset(ADataset: TDataSet): TProdutoDTO;
begin
  Result := TProdutoDTO.Create;
  with ADataset do
  begin
    Result.Cod_Produto := FieldByName('COD_PRODUTO').AsInteger;
    Result.Des_Descricao := FieldByName('DES_DESCRICAO').AsString;
    Result.Des_Marca := FieldByName('DES_MARCA').AsString;
    Result.Val_Preco := FieldByName('VAL_PRECO').AsFloat;
  end;
end;

procedure TProdutoDTO.ToEntity(var AProduto: TProduto);
begin
  AProduto.Cod_Produto := FCod_Produto;
  AProduto.Des_Descricao := FDes_Descricao;
  AProduto.Des_Marca := FDes_Marca;
  AProduto.Val_Preco := FVal_Preco;
end;

procedure TProdutoDTO.MapearParaQuery(AQuery: TFDQuery);
begin
  with AQuery do
  begin
    ParamByName('DES_DESCRICAO').AsString := FDes_Descricao;
    ParamByName('DES_MARCA').AsString := FDes_Marca;
    ParamByName('VAL_PRECO').AsFloat := FVal_Preco;
  end;
end;

end.

unit PedidoItemDTO;

interface

uses
  PedidoItemModel, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param, System.Classes, System.Generics.Collections,
  Data.DB;

type
  TPedidoItemDTO = class

  private
    FId_Pedido: Integer;
    FCod_Pedido: Integer;
    FCod_Produto: Integer;
    FDes_Descricao: string;
    FVal_Quantidade: Integer;
    FVal_PrecoUnitario: Double;
    FVal_TotalItem: Double;

  public
    constructor Create; overload;
    constructor Create(AId_Pedido, ACod_Pedido, ACod_Produto, AVal_Quantidade: Integer; ADes_Descricao: string;
                       AVal_PrecoUnitario, AVal_TotalItem: Double); overload;

    // Métodos de conversão
    class function FromEntity(APedidoItem: TPedidoItem): TPedidoItemDTO;
    class function FromDataset(ADataset: TDataSet): TPedidoItemDTO;
    procedure ToEntity(var APedidoItem: TPedidoItem);
    procedure MapearParaQuery(AQuery: TFDQuery);

    // Properties
    property Id_Pedido: Integer read FId_Pedido write FId_Pedido;
    property Cod_Pedido: Integer read FCod_Pedido write FCod_Pedido;
    property Cod_Produto: Integer read FCod_Produto write FCod_Produto;
    property Des_Descricao: string read FDes_Descricao write FDes_Descricao;
    property Val_Quantidade: Integer read FVal_Quantidade write FVal_Quantidade;
    property Val_PrecoUnitario: Double read FVal_PrecoUnitario write FVal_PrecoUnitario;
    property Val_TotalItem: Double read FVal_TotalItem write FVal_TotalItem;

  end;

implementation

{ TPedidoItemDTO }

constructor TPedidoItemDTO.Create;
begin
  inherited Create;
  // Construtor Vazio
end;

constructor TPedidoItemDTO.Create(AId_Pedido, ACod_Pedido, ACod_Produto, AVal_Quantidade: Integer; ADes_Descricao: string;
                                  AVal_PrecoUnitario, AVal_TotalItem: Double);
begin
  inherited Create;
  FId_Pedido := AId_Pedido;
  FCod_Pedido := ACod_Pedido;
  FCod_Produto := ACod_Produto;
  FDes_Descricao := ADes_Descricao;
  FVal_Quantidade := AVal_Quantidade;
  FVal_PrecoUnitario := AVal_PrecoUnitario;
  FVal_TotalItem := AVal_TotalItem;
end;

class function TPedidoItemDTO.FromEntity(APedidoItem: TPedidoItem): TPedidoItemDTO;
begin
  Result := TPedidoItemDTO.Create;
  Result.Id_Pedido := APedidoItem.Id_Pedido;
  Result.Cod_Pedido := APedidoItem.Cod_Pedido;
  Result.Cod_Produto := APedidoItem.Cod_Produto;
  Result.Des_Descricao := APedidoItem.Des_Descricao;
  Result.Val_Quantidade := APedidoItem.Val_Quantidade;
  Result.Val_PrecoUnitario := APedidoItem.Val_PrecoUnitario;
  Result.Val_TotalItem := APedidoItem.Val_TotalItem;
end;

class function TPedidoItemDTO.FromDataset(ADataset: TDataSet): TPedidoItemDTO;
begin
  Result := TPedidoItemDTO.Create;
  with ADataset do
  begin
    Result.Id_Pedido := FieldByName('ID_PEDIDO').AsInteger;
    Result.Cod_Pedido := FieldByName('COD_PEDIDO').AsInteger;
    Result.Cod_Produto := FieldByName('COD_PRODUTO').AsInteger;
    Result.Des_Descricao := FieldByName('DES_DESCRICAO').AsString;
    Result.Val_Quantidade := FieldByName('VAL_QUANTIDADE').AsInteger;
    Result.Val_PrecoUnitario := FieldByName('VAL_PRECOUNITARIO').AsFloat;
    Result.Val_TotalItem := FieldByName('VAL_TOTALITEM').AsFloat;
  end;
end;

procedure TPedidoItemDTO.ToEntity(var APedidoItem: TPedidoItem);
begin
  APedidoItem.Id_Pedido := FId_Pedido;
  APedidoItem.Cod_Pedido := FCod_Pedido;
  APedidoItem.Cod_Produto := FCod_Produto;
  APedidoItem.Des_Descricao := FDes_Descricao;
  APedidoItem.Val_Quantidade := FVal_Quantidade;
  APedidoItem.Val_PrecoUnitario := FVal_PrecoUnitario;
  APedidoItem.Val_TotalItem := FVal_TotalItem;
end;

procedure TPedidoItemDTO.MapearParaQuery(AQuery: TFDQuery);
begin
  with AQuery do
  begin
    ParamByName('COD_PEDIDO').AsInteger := FCod_Pedido;
    ParamByName('COD_PRODUTO').AsInteger := FCod_Produto;
    ParamByName('VAl_QUANTIDADE').AsFloat := FVal_Quantidade;
    ParamByName('VAL_PRECOUNITARIO').AsFloat := FVal_PrecoUnitario;
    ParamByName('VAL_TOTALITEM').AsFloat := FVal_TotalItem;
  end;
end;


end.

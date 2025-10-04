unit PedidoDTO;

interface

uses
  System.SysUtils, PedidoModel, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TPedidoDTO = class

  private
    FCod_Pedido: Integer;
    FDta_Pedido: TDateTime;
    FCod_Cliente: Integer;
    FVal_Pedido: Double;

  public
    constructor Create; overload;
    constructor Create(ACod_Pedido, ACod_Cliente: Integer; ADta_Pedido: TDateTime; AVal_Pedido: Double); overload;

    // Métodos de conversão
    class function FromEntity(APedido: TPedido): TPedidoDTO;
    class function FromDataset(ADataset: TDataSet): TPedidoDTO;
    procedure ToEntity(var APedido: TPedido);
    procedure MapearParaQuery(AQuery: TFDQuery);

    // Properties
    property Cod_Pedido: Integer read FCod_Pedido write FCod_Pedido;
    property Dta_Pedido: TDateTime read FDta_Pedido write FDta_Pedido;
    property Cod_Cliente: Integer read FCod_Cliente write FCod_Cliente;
    property Val_Pedido: Double read FVal_Pedido write FVal_Pedido;

  end;

implementation

{ TPedidoDTO }

constructor TPedidoDTO.Create;
begin
  inherited Create;
  // Construtor Vazio
end;

constructor TPedidoDTO.Create(ACod_Pedido, ACod_Cliente: Integer; ADta_Pedido: TDateTime; AVal_Pedido: Double);
begin
  inherited Create;
  FCod_Pedido := ACod_Pedido;
  FDta_Pedido := ADta_Pedido;
  FCod_Cliente := ACod_Cliente;
  FVal_Pedido := AVal_Pedido;
end;

class function TPedidoDTO.FromEntity(APedido: TPedido): TPedidoDTO;
begin
  Result := TPedidoDTO.Create;
  Result.Cod_Pedido := APedido.Cod_Pedido;
  Result.Dta_Pedido := APedido.Dta_Pedido;
  Result.Cod_Cliente := APedido.Cod_Cliente;
  Result.Val_Pedido := APedido.Val_Pedido;
end;

class function TPedidoDTO.FromDataset(ADataset: TDataSet): TPedidoDTO;
begin
  Result := TPedidoDTO.Create;
  with ADataset do
  begin
    Result.Cod_Pedido := FieldByName('COD_PEDIDO').AsInteger;
    Result.Dta_Pedido := FieldByName('DTA_PEDIDO').AsDateTime;
    Result.Cod_Cliente := FieldByName('COD_CLIENTE').AsInteger;
    Result.Val_Pedido := FieldByName('VAL_PEDIDO').AsFloat;
  end;
end;

procedure TPedidoDTO.ToEntity(var APedido: TPedido);
begin
  APedido.Cod_Pedido := FCod_Pedido;
  APedido.Dta_Pedido := FDta_Pedido;
  APedido.Cod_Cliente := FCod_Cliente;
  APedido.Val_Pedido := FVal_Pedido;
end;

procedure TPedidoDTO.MapearParaQuery(AQuery: TFDQuery);
begin
  with AQuery do
  begin
    ParamByName('DTA_PEDIDO').AsDateTime := FDta_Pedido;
    ParamByName('COD_CLIENTE').AsInteger := FCod_Cliente;
    ParamByName('VAL_PEDIDO').AsFloat := FVal_Pedido;
  end;
end;

end.

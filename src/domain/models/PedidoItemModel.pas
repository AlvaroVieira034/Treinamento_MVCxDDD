unit PedidoItemModel;

interface

uses System.SysUtils, FireDAC.Comp.Client, System.Classes, System.Generics.Collections;

type
  TPedidoItem = class

  private
    FId_Pedido: Integer;
    FCod_Pedido: Integer;
    FCod_Produto: Integer;
    FDes_Descricao: string;
    FVal_Quantidade: Integer;
    FVal_PrecoUnitario: Double;
    FVal_TotalItem: Double;

  public
    property Id_Pedido: Integer read FId_Pedido write FId_Pedido;
    property Cod_Pedido: Integer read FCod_Pedido write FCod_Pedido;
    property Cod_Produto: Integer read FCod_Produto write FCod_Produto;
    property Des_Descricao: string read FDes_Descricao write FDes_Descricao;
    property Val_Quantidade: Integer read FVal_Quantidade write FVal_Quantidade;
    property Val_PrecoUnitario: Double read FVal_PrecoUnitario write FVal_PrecoUnitario;
    property Val_TotalItem: Double read FVal_TotalItem write FVal_TotalItem;

  end;

implementation

end.

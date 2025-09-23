unit ucadpedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ucadastropadrao, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TFrmCadPedido = class(TFrmCadastroPadrao)
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    EdtQuantidade: TEdit;
    EdtPrecoUnit: TEdit;
    EdtPrecoTotal: TEdit;
    LCbxProdutos: TDBLookupComboBox;
    BtnAddItemGrid: TButton;
    BtnDelItemGrid: TButton;
    DbGridItensPedido: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    BtnPesquisar: TSpeedButton;
    BtnLimpaCampos: TSpeedButton;
    EdtCodPedido: TEdit;
    EdtDataPedido: TEdit;
    EdtTotalPedido: TEdit;
    EdtCodCliente: TEdit;
    LcbxNomeCliente: TDBLookupComboBox;
    BtnInserirItens: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPedido: TFrmCadPedido;

implementation

{$R *.dfm}

end.

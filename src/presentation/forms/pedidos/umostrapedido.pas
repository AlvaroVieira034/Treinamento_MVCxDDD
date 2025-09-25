unit umostrapedido;

interface

{$REGION 'Uses'}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.Controls, ConexaoAdapter, ConexaoSingleton, ProdutoModel, ProdutoAppSevice, ProdutoRepository,
  ProdutoService, ClienteModel, ClienteAppService, PedidoModel, PedidoItemModel, PedidoAppService, PedidoRepository,
  IPedido.Repository, PedidoService, IPedido.Service, PedidoItemAppService, ClienteRepository, ClienteService,
  ICliente.Repository, ICliente.Service, FormatUtil, upesqpedidos, System.Generics.Collections;

{$ENDREGION}

type
  TFrmMostraPedido = class(TForm)
    PnlDados: TPanel;
    MTblPedidoItem: TFDMemTable;
    MTblPedidoItemID_PEDIDO: TIntegerField;
    MTblPedidoItemCOD_PEDIDO: TIntegerField;
    MTblPedidoItemCOD_PRODUTO: TIntegerField;
    MTblPedidoItemDES_DESCRICAO: TStringField;
    MTblPedidoItemVAL_QUANTIDADE: TIntegerField;
    MTblPedidoItemVAL_PRECOUNITARIO: TFloatField;
    MTblPedidoItemVAL_TOTALITEM: TFloatField;
    DsPedidoItem: TDataSource;
    LblPedido: TLabel;
    LblDataPedido: TLabel;
    LblCliente: TLabel;
    LblDescricao: TLabel;
    LblNroPedido: TLabel;
    LblEndCompleto: TLabel;
    LblCidade: TLabel;
    LblEndereco: TLabel;
    LblNomeCidade: TLabel;
    LblUF: TLabel;
    LblNomeUF: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    LblCNPJ: TLabel;
    LblNroCNPJ: TLabel;
    DbGridItensPedido: TDBGrid;
    LblVlrTotal: TLabel;
    LblTotal: TLabel;
    BtnFechar: TBitBtn;
    LblFone: TLabel;
    LblNroFone: TLabel;
    LblNomeCliente: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);

  private
    FProdutoAppService: TProdutoAppService;
    FClienteAppService: TClienteAppService;
    FPedido: TPedido;
    FPedidoAppService: TPedidoAppService;
    FPedidoItem: TPedidoItem;
    FPedidoItemAppService: TPedidoItemAppService;
    TransacaoPedidos : TFDTransaction;

  public
    codigoPedido: Integer;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

var
  FrmMostraPedido: TFrmMostraPedido;

implementation

{$R *.dfm}

procedure TFrmMostraPedido.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

constructor TFrmMostraPedido.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFrmMostraPedido.Destroy;
begin

  inherited Destroy;
end;

procedure TFrmMostraPedido.FormCreate(Sender: TObject);
var sCampo: string;
    ClienteRepository: IClienteRepository;
    ClienteService: IClienteService;
    PedidoRepository: IPedidoRepository;
    PedidoService: IPedidoService;
    Connection: TFDConnection;
begin
  inherited;
  if TConexaoSingleton.GetInstance.DatabaseConnection.TestarConexao then
  begin
    //Instancias Classes
    Connection := TFDConnection.Create(nil);
    ClienteRepository := TClienteRepository.Create(Connection);
    ClienteService    := TClienteService.Create(Connection);
    PedidoRepository := TPedidoRepository.Create(Connection);
    PedidoService    := TPedidoService.Create(Connection);
    FPedido := TPedido.Create;
    FPedidoItem := TPedidoItem.Create;
    FClienteAppService := TClienteAppService.Create(ClienteRepository, ClienteService);
    FPedidoAppService := TPedidoAppService.Create(PedidoRepository, PedidoService);
    FPedidoItemAppService := TPedidoItemAppService.Create;
    MTblPedidoItem.CreateDataSet;
  end
  else
  begin
    ShowMessage('Não foi possível conectar ao banco de dados!');
    Close;
  end;
end;

procedure TFrmMostraPedido.FormShow(Sender: TObject);
begin
  DbGridItensPedido.Columns[0].Width := 340;
  DbGridItensPedido.Columns[1].Width := 150;
  DbGridItensPedido.Columns[2].Width := 190;
  DbGridItensPedido.Columns[3].Width := 180;
end;

end.

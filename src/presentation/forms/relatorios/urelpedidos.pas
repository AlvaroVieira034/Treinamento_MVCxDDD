unit urelpedidos;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.Controls, ConexaoSingleton, ConexaoAdapter, ProdutoModel, ProdutoAppSevice, ProdutoRepository,
  ProdutoService, ClienteModel, ClienteAppService, PedidoModel, PedidoItemModel, PedidoAppService, PedidoRepository,
  IPedido.Repository, PedidoService, IPedido.Service, PedidoItemAppService, ClienteRepository, ICliente.Repository,
  ClienteService, ICliente.Service, FormatUtil, upesqpedidos, umostrapedido, System.Generics.Collections;

{$ENDREGION}

type
  TFrmRelPedidos = class(TForm)

{$REGION 'Componentes'}
    DbGridRelatorio: TDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    EdtDataDe: TEdit;
    Label2: TLabel;
    BtnPesquisar: TSpeedButton;
    EdtDataAte: TEdit;
    BtnSair: TSpeedButton;
    ChkRelatorio: TCheckBox;

{$ENDREGION}

    procedure EdtDataDeChange(Sender: TObject);
    procedure EdtDataAteChange(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChkRelatorioClick(Sender: TObject);
    procedure EdtDataDeExit(Sender: TObject);

  private
    TblPedidos: TFDQuery;
    DsRelatorio: TDataSource;
    FPedido: TPedido;
    FPedidoAppService: TPedidoAppService;
    FPedidoItem: TPedidoItem;

    procedure PreencherGridRelatorio;
    procedure CriarCamposTabelas;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

var
  FrmRelPedidos: TFrmRelPedidos;

implementation

{$R *.dfm}

constructor TFrmRelPedidos.Create(AOwner: TComponent);
begin
  inherited;
  TblPedidos := TFDQuery.Create(nil);
  DsRelatorio := TDataSource.Create(nil);
end;

procedure TFrmRelPedidos.CriarCamposTabelas;
var FloatField: TFloatField;
    SingleField: TSingleField;
    StringField: TStringField;
    DateField: TDateField;
    IntegerField: TIntegerField;
begin
  // Criando o campo COD_Pedido
  IntegerField := TIntegerField.Create(TblPedidos);
  IntegerField.FieldName := 'COD_PRODUTO';
  IntegerField.DataSet := TblPedidos;
  IntegerField.Name := 'TblPedidosCOD_PEDIDO';

  // Criando o campo DES_DESCRICAO
  StringField := TStringField.Create(TblPedidos);
  StringField.FieldName := 'DES_DESCRICAO';
  StringField.Size := 100;
  StringField.DataSet := TblPedidos;
  StringField.Name := 'TblPedidosDES_DESCRICAO';

  // Criando o campo DES_MARCA
  StringField := TStringField.Create(TblPedidos);
  StringField.FieldName := 'DES_MARCA';
  StringField.Size := 500;
  StringField.DataSet := TblPedidos;
  StringField.Name := 'TblPedidosDES_MARCA';

  // Criando o campo QUANTIDADEVENDIDA
  IntegerField := TIntegerField.Create(TblPedidos);
  IntegerField.FieldName := 'QUANTIDADEVENDIDA';
  IntegerField.DataSet := TblPedidos;
  IntegerField.Name := 'TblPedidosVAL_PEDIDO';

  // Criando o campo VALORTOTALVENDIDO
  FloatField := TFloatField.Create(TblPedidos);
  FloatField.FieldName := 'VALORTOTALVENDIDO';
  FloatField.DataSet := TblPedidos;
  FloatField.Name := 'TblPedidosVALORTOTALVENDIDO';
  FloatField.DisplayFormat := '#,###,##0.00';

end;

destructor TFrmRelPedidos.Destroy;
begin
  TblPedidos.Free;
  DsRelatorio.Free;
  inherited Destroy;
end;

procedure TFrmRelPedidos.FormCreate(Sender: TObject);
var sCampo: string;
    PedidoRepository: TPedidoRepository;
    PedidoService: TPedidoService;
    Connection: TFDConnection;
begin
  inherited;
  if TConexaoSingleton.GetInstance.DatabaseConnection.TestarConexao then
  begin
     // Cria Tabelas
    TblPedidos := TConexaoSingleton.GetInstance.DatabaseConnection.CriarQuery;

    // Cria DataSource
    DsRelatorio := TConexaoSingleton.GetInstance.DatabaseConnection.CriarDataSource;
    DbGridRelatorio.DataSource := DsRelatorio;

    // Atribui DataSet às tabelas
    DsRelatorio.DataSet := TblPedidos;

    //Instancias Classes
    PedidoRepository := TPedidoRepository.Create(Connection);
    PedidoService := TPedidoService.Create(Connection);
    FPedido := TPedido.Create;
    FPedidoAppService := TPedidoAppService.Create(PedidoRepository, PedidoService);

    CriarCamposTabelas();
  end
  else
  begin
    ShowMessage('Não foi possível conectar ao banco de dados!');
    Close;
  end;

end;

procedure TFrmRelPedidos.FormShow(Sender: TObject);
begin
  PreencherGridRelatorio();
end;

procedure TFrmRelPedidos.PreencherGridRelatorio;
var CkRelatorio: Integer;
begin
  if ChkRelatorio.Checked then
      CkRelatorio := 0
    else
      CkRelatorio := 1;

  FPedidoAppService.PreencherGridRelatorio(TblPedidos, EdtDataDe.Text, EdtDataAte.Text, CkRelatorio);
end;

procedure TFrmRelPedidos.EdtDataDeChange(Sender: TObject);
begin
  Formatar(EdtDataDe, TFormato.Dt);
end;

procedure TFrmRelPedidos.EdtDataDeExit(Sender: TObject);
begin
  EdtDataAte.Text := DateToStr(Date());
end;

procedure TFrmRelPedidos.EdtDataAteChange(Sender: TObject);
begin
  Formatar(EdtDataAte, TFormato.Dt);
end;

procedure TFrmRelPedidos.ChkRelatorioClick(Sender: TObject);
begin
  PreencherGridRelatorio();
end;

procedure TFrmRelPedidos.BtnPesquisarClick(Sender: TObject);
begin
  PreencherGridRelatorio();
end;

procedure TFrmRelPedidos.BtnSairClick(Sender: TObject);
begin
  Close;
end;

end.

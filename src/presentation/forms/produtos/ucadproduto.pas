unit ucadproduto;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ProdutoModel, IProduto.Service, IProduto.Repository,
  ProdutoService, ProdutoDTO, ProdutoAppSevice, ProdutoRepository, ProdutoExceptions, ConexaoSingleton,
  ucadastropadrao, CEPService, ProdutoValueObject, FormatUtil, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Comp.Client;

{$ENDREGION}

type
  TOperacao = (opInicio, opNovo, opEditar, opNavegar);
  TFrmCadProduto = class(TFrmCadastroPadrao)

{$REGION 'Componentes'}
    PnlPesquisar: TPanel;
    BtnPesquisar: TSpeedButton;
    Label12: TLabel;
    EdtPesquisar: TEdit;
    CbxFiltro: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    EdtPrecoUnitario: TEdit;
    EdtCodProduto: TEdit;
    EdtDescricao: TEdit;
    EdtMarca: TEdit;
    DBGridProdutos: TDBGrid;

{$ENDREGION}

    procedure BtnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridProdutosCellClick(Column: TColumn);
    procedure DBGridProdutosDblClick(Sender: TObject);
    procedure DBGridProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CbxFiltroChange(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisarChange(Sender: TObject);
    procedure EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPrecoUnitarioExit(Sender: TObject);
    procedure EdtPrecoUnitarioKeyPress(Sender: TObject; var Key: Char);

  private
    ValoresOriginais: array of string;
    FProduto: TProduto;
    FProdutoAppService: TProdutoAppService;
    sErro: string;

    procedure PreencherGridProduto;
    procedure PreencherCamposForm;
    procedure LimparCamposForm(Form: TForm);
    procedure VerificarBotoes(AOperacao: TOperacao);
    procedure PreencherCbxFiltro;
    procedure SalvarValoresOriginais;
    procedure RestaurarValoresOriginais;
    function GravarDados: Boolean;
    function ObterDadosFormulario: TProduto;
    function GetCampoFiltro: string;
    function GetDataSource: TDataSource;

  public
    FOperacao: TOperacao;
    DsProdutos: TDataSource;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

var
  FrmCadProduto: TFrmCadProduto;

implementation

{$R *.dfm}


constructor TFrmCadProduto.Create(AOwner: TComponent);
begin
  inherited;
  DsProdutos := TDataSource.Create(nil);
end;

destructor TFrmCadProduto.Destroy;
begin
  if Assigned(DsProdutos) then DsProdutos.Free;
  if Assigned(FProduto) then FProduto.Free;

  inherited;
end;

procedure TFrmCadProduto.FormCreate(Sender: TObject);
var Repository: IProdutoRepository;
    Service: IProdutoService;
    Connection: TFDConnection;
begin
  inherited;
  if TConexaoSingleton.GetInstance.DatabaseConnection.TestarConexao then
  begin
    FProduto := TProduto.Create;
    Connection := TFDConnection.Create(nil);
    Repository := TProdutoRepository.Create(Connection);
    Service    := TProdutoService.Create(Connection);
    FProdutoAppService := TProdutoAppService.Create(Repository, Service);
    GetDataSource();
    FOperacao := opInicio;
  end
  else
  begin
    ShowMessage('Não foi possível conectar ao banco de dados!');
    Close;
  end;

  PreencherCbxFiltro();
end;

procedure TFrmCadProduto.FormShow(Sender: TObject);
begin
  inherited;
  if DBGridProdutos.DataSource = nil then
    GetDataSource();

  PreencherGridProduto();
  VerificarBotoes(FOperacao);
  if EdtPesquisar.CanFocus then
    EdtPesquisar.SetFocus;

end;

procedure TFrmCadProduto.PreencherGridProduto;
var LCampo: string;
begin
  LCampo := GetCampoFiltro;
  FProdutoAppService.PreencheGridProdutos(Trim(EdtPesquisar.Text) + '%', LCampo);
  LblTotRegistros.Caption := 'Produtos: ' + InttoStr(DbGridProdutos.DataSource.DataSet.RecordCount);
  Application.ProcessMessages;
end;

procedure TFrmCadProduto.PreencherCamposForm;
var Produto: TProduto;
    ProdutoDTO: TProdutoDTO;
    CodigoProduto: Integer;
begin
  if not Assigned(DsProdutos.DataSet) or DsProdutos.DataSet.IsEmpty then
    Exit;

  try
    CodigoProduto := DsProdutos.DataSet.FieldByName('COD_PRODUTO').AsInteger;
    Produto := FProdutoAppService.BuscarProdutoPorCodigo(CodigoProduto);
    try
      ProdutoDTO := TProdutoDTO.FromEntity(Produto);
      try
        EdtCodProduto.Text := IntToStr(ProdutoDTO.Cod_Produto);
        EdtDescricao.Text := ProdutoDTO.Des_Descricao;
        EdtMarca.Text := ProdutoDTO.Des_Marca;
        EdtPrecoUnitario.Text := FloatToStr(ProdutoDTO.Val_Preco);

        SalvarValoresOriginais();
      finally
        ProdutoDTO.Free;
      end;
    finally
      Produto.Free;
    end;

  except
    on E: Exception do
    begin
      ShowMessage('Erro ao carregar dados do produto: ' + E.Message);
      LimparCamposForm(Self);
    end;
  end;

end;

procedure TFrmCadProduto.LimparCamposForm(Form: TForm);
var i: Integer;
begin
  for i := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[i] is TEdit then
    begin
      TEdit(Form.Components[i]).Text := '';
    end;
  end;
  GrbDados.Enabled := FOperacao in [opNovo, opEditar];
  DBGridProdutos.Enabled := FOperacao in [opInicio, opNavegar];
end;

procedure TFrmCadProduto.VerificarBotoes(AOperacao: TOperacao);
begin
  BtnInserir.Enabled := AOperacao in [opInicio, opNavegar];
  BtnAlterar.Enabled := AOperacao = opNavegar;
  BtnExcluir.Enabled := AOperacao = opNavegar;
  BtnSair.Enabled := AOperacao in [opInicio, opNavegar];
  BtnGravar.Enabled := AOperacao in [opNovo, opEditar];
  BtnCancelar.Enabled := AOperacao in [opNovo, opEditar];
  GrbDados.Enabled := AOperacao in [opNovo, opEditar];
  DbGridProdutos.Enabled := AOperacao in [opInicio, opNavegar];
  PnlPesquisar.Enabled := AOperacao in [opInicio, opNavegar];
end;

procedure TFrmCadProduto.PreencherCbxFiltro;
begin
  CbxFiltro.Items.AddObject('Todos', TObject(0));
  CbxFiltro.Items.AddObject('Código', TObject(1));
  CbxFiltro.Items.AddObject('Descrição', TObject(2));
  CbxFiltro.Items.AddObject('Marca', TObject(3));

  CbxFiltro.ItemIndex := 0;
end;

procedure TFrmCadProduto.SalvarValoresOriginais;
begin
  SetLength(ValoresOriginais, 5);
  ValoresOriginais[0] := EdtCodProduto.Text;
  ValoresOriginais[1] := EdtDescricao.Text;
  ValoresOriginais[2] := EdtMarca.Text;
  ValoresOriginais[3] := EdtPrecoUnitario.Text;
end;

procedure TFrmCadProduto.RestaurarValoresOriginais;
begin
  EdtCodProduto.Text := ValoresOriginais[0];
  EdtDescricao.Text := ValoresOriginais[1];
  EdtMarca.Text := ValoresOriginais[2];
  EdtPrecoUnitario.Text := ValoresOriginais[3];
end;

function TFrmCadProduto.GravarDados: Boolean;
var Produto: TProduto;
    Erros: TArray<string>;
begin
  Result := False;
  Produto := ObterDadosFormulario;
  try
    try
      Erros := Produto.ObterErrosValidacao;
      if Length(Erros) > 0 then
      begin
        MessageDlg('Erros encontrados:' + sLineBreak + string.Join(sLineBreak, Erros), mtError, [mbOK], 0);
        Exit;
      end;

      case FOperacao of
        opNovo:
        begin
          Produto.Cod_Produto := 0;
          FProdutoAppService.Inserir(Produto);
          MessageDlg('Produto incluído com sucesso!', mtInformation, [mbOk], 0);
        end;

        opEditar:
        begin
          FProdutoAppService.Alterar(Produto, StrToInt(EdtCodProduto.Text));
          MessageDlg('Produto alterado com sucesso!', mtInformation, [mbOk], 0);
        end;
      end;

      Result := True;
      FOperacao := opNavegar;
      VerificarBotoes(FOperacao);
      PreencherGridProduto();
    except
      on E: EProdutoException do
        MessageDlg('Erro de validação: ' + E.Message, mtError, [mbOK], 0);

      on E: EDescricaoDuplicadaException do
        MessageDlg('Erro de negócio: ' + E.Message, mtError, [mbOK], 0);

      on E: Exception do
        MessageDlg('Erro inesperado: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Produto.Free;
  end;
end;

function TFrmCadProduto.ObterDadosFormulario: TProduto;
var ProdutoDTO: TProdutoDTO;
begin
  ProdutoDTO := TProdutoDTO.Create;
  try
    with ProdutoDTO do
    begin
      Cod_Produto := StrToIntDef(EdtCodProduto.Text, 0);
      Des_Descricao := EdtDescricao.Text;
      Des_Marca := EdtMarca.Text;
      Val_Preco := StrToFloatDef(EdtPrecoUnitario.Text, 0);
    end;
    Result := TProduto.Create;
    ProdutoDTO.ToEntity(Result);
  finally
    ProdutoDTO.Free;
  end;

end;

function TFrmCadProduto.GetCampoFiltro: string;
begin
  case Integer(CbxFiltro.Items.Objects[CbxFiltro.ItemIndex]) of
    0: Result := 'prd.des_descricao';
    1: Result := 'prd.cod_produto';
    2: Result := 'prd.des_descricao';
    3: Result := 'prd.des_Marca';
  else
    Result := 'cli.des_descricao';
  end;
end;

function TFrmCadProduto.GetDataSource: TDataSource;
begin
  DBGridProdutos.DataSource := FProdutoAppService.GetDataSource();
  DsProdutos := FProdutoAppService.GetDataSource();
end;

procedure TFrmCadProduto.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0)
end;

procedure TFrmCadProduto.DBGridProdutosCellClick(Column: TColumn);
begin
  inherited;
  FOperacao := opNavegar;
  PreencherCamposForm();
  EdtPrecoUnitarioExit(Self);
  VerificarBotoes(FOperacao);
end;

procedure TFrmCadProduto.DBGridProdutosDblClick(Sender: TObject);
begin
  inherited;
  FOperacao := opEditar;
  PreencherCamposForm();
  VerificarBotoes(FOperacao);
end;

procedure TFrmCadProduto.DBGridProdutosKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    PreencherCamposForm();
    VerificarBotoes(FOperacao);
    FOperacao := opEditar;
    BtnAlterar.Click;
    EdtDescricao.SetFocus;
    Key := 0;
  end;

  if Key = VK_DELETE then
  begin
    BtnExcluirClick(Sender);
  end;
end;

procedure TFrmCadProduto.CbxFiltroChange(Sender: TObject);
begin
  inherited;
  if CbxFiltro.Text = 'Todos' then
    EdtPesquisar.Text := EmptyStr;

  BtnPesquisar.Click;
  EdtPesquisar.SetFocus;
end;

procedure TFrmCadProduto.BtnInserirClick(Sender: TObject);
begin
  inherited;
  FOperacao := opNovo;
  VerificarBotoes(FOperacao);
  LimparCamposForm(Self);
  EdtDescricao.SetFocus;
end;

procedure TFrmCadProduto.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  FOperacao := opEditar;
  PreencherCamposForm();
  VerificarBotoes(FOperacao);
  EdtDescricao.SetFocus;
end;

procedure TFrmCadProduto.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja realmente excluir o produto selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
  begin
    try
      FProdutoAppService.Excluir(StrToInt(EdtCodProduto.Text));
      MessageDlg('Produto excluído com sucesso!', mtInformation, [mbOk], 0);
      LimparCamposForm(Self);
    except
      on E: Exception do
        MessageDlg('Erro ao excluir o produto: ' + E.Message, mtError, [mbOk], 0);
    end;

    PreencherGridProduto();
  end;
end;

procedure TFrmCadProduto.BtnGravarClick(Sender: TObject);
begin
  inherited;
  if GravarDados() then
  begin
    FOperacao := opNavegar;
    VerificarBotoes(FOperacao);
    LimparCamposForm(Self);
    BtnPesquisar.Click;
  end;
end;

procedure TFrmCadProduto.BtnCancelarClick(Sender: TObject);
begin
  inherited;
   if FOperacao = opNovo then
  begin
    FOperacao := opInicio;
    LimparCamposForm(Self);
    EdtPesquisar.Text := EmptyStr;
  end;

  if FOperacao = opEditar then
  begin
    FOperacao := opNavegar;
    RestaurarValoresOriginais();
  end;

  VerificarBotoes(FOperacao);
  PreencherGridProduto;
  EdtPesquisar.SetFocus;
end;

procedure TFrmCadProduto.EdtPesquisarChange(Sender: TObject);
begin
  inherited;
  PreencherGridProduto();
end;

procedure TFrmCadProduto.EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    PreencherCamposForm();
    BtnAlterar.Click;
    Key := #0;
  end;
end;

procedure TFrmCadProduto.BtnPesquisarClick(Sender: TObject);
begin
  inherited;
  PreencherGridProduto();
end;

procedure TFrmCadProduto.EdtPrecoUnitarioExit(Sender: TObject);
var LValor: Double;
begin
  inherited;
  if TryStrToFloat(EdtPrecoUnitario.Text, LValor) then
    EdtPrecoUnitario.Text := FormatFloat('#,###,##0.00', LValor)

end;

procedure TFrmCadProduto.EdtPrecoUnitarioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0'..'9', ',', #08]) then
    key := #0;
end;

procedure TFrmCadProduto.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.

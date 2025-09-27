unit ucadpedido;

interface

{$REGION 'Uses'}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, Vcl.DBCtrls, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.Controls,
  ProdutoModel, ProdutoAppSevice, IProduto.Repository, ProdutoRepository, IProduto.Service, ProdutoService,
  ClienteModel, ClienteAppService, PedidoModel, PedidoDTO, PedidoItemModel, PedidoAppService, IPedido.Repository,
  PedidoRepository, IPedido.Service, PedidoService, PedidoItemAppService, ICliente.Repository, ClienteRepository,
  PedidoValueObject, ICliente.Service, ClienteService, PedidoItemValidator, PedidoExceptions, FormatUtil, upesqpedidos,
  System.Generics.Collections, conexao; //,ConexaoSingleton, ConexaoAdapter;

{$ENDREGION}

type
  TOperacao = (opInicio, opNovo, opEditar, opNavegar, opErro);
  TFrmCadPedido = class(TFrmCadastroPadrao)

{$REGION 'Componentes'}
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
    MTblPedidoItem: TFDMemTable;
    MTblPedidoItemID_PEDIDO: TIntegerField;
    MTblPedidoItemCOD_PEDIDO: TIntegerField;
    MTblPedidoItemCOD_PRODUTO: TIntegerField;
    MTblPedidoItemDES_DESCRICAO: TStringField;
    MTblPedidoItemVAL_QUANTIDADE: TIntegerField;
    MTblPedidoItemVAL_PRECOUNITARIO: TFloatField;
    MTblPedidoItemVAL_TOTALITEM: TFloatField;
    DsPedidoItem: TDataSource;

{$ENDREGION}

    procedure BtnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnInserirItensClick(Sender: TObject);
    procedure BtnLimpaCamposClick(Sender: TObject);
    procedure BtnAddItemGridClick(Sender: TObject);
    procedure BtnDelItemGridClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtDataPedidoChange(Sender: TObject);
    procedure EdtCodClienteExit(Sender: TObject);
    procedure EdtCodClienteChange(Sender: TObject);
    procedure LCbxProdutosClick(Sender: TObject);
    procedure EdtQuantidadeExit(Sender: TObject);
    procedure EdtPrecoUnitExit(Sender: TObject);
    procedure EdtPrecoTotalExit(Sender: TObject);
    procedure EdtCodPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure EdtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPrecoUnitKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPrecoTotalKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DbGridItensPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LcbxNomeClienteClick(Sender: TObject);

  private
    ValoresOriginais: array of string;
    TblProdutos: TFDQuery;
    TblClientes: TFDQuery;
    DsProdutos: TDataSource;
    DsClientes: TDataSource;
    FProdutoAppService: TProdutoAppService;
    FClienteAppService: TClienteAppService;
    FCliente: TCliente;
    FPedido: TPedido;
    FPedidoAppService: TPedidoAppService;
    FPedidoItem: TPedidoItem;
    FPedidoItemAppService: TPedidoItemAppService;
    Conexao: TConexao;
    FConexao: TFDConnection;
    TransacaoPedidos : TFDTransaction;
    totPedido, totPedidoAnt: Double;
    idItem: Integer;
    alterouGrid: Boolean;
    sErro: string;

    procedure CarregarPedidos(ACodPedido: Integer);
    procedure InserirPedidoItens;
    procedure ExcluirPedidos;
    function ValidarDados(ATipoDados: string): Boolean;
    function GravarDados: Boolean;
    function ObterDadosFormulario: TPedido;
    procedure LimparCamposPedido;
    procedure LimparCamposItens;
    procedure PreencheCdsPedidoItem;
    procedure VerificaBotoes(AOperacao: TOperacao);
    procedure HabilitarBotaoIncluirItens;



  public
    FOperacao: TOperacao;
    pesqPedido: Boolean;
    codigoPedido: Integer;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FrmCadPedido: TFrmCadPedido;

implementation

{$R *.dfm}

uses umostrapedido, ProdutoDTO;


constructor TFrmCadPedido.Create(AOwner: TComponent);
begin
  inherited;
  DsProdutos := TDataSource.Create(nil);
  DsClientes := TDataSource.Create(nil);
  TransacaoPedidos := TFDTransaction.Create(nil);
end;

destructor TFrmCadPedido.Destroy;
begin
  if Assigned(MTblPedidoItem) and MTblPedidoItem.Active then
    MTblPedidoItem.Close;

  // DataSources
  if Assigned(DsProdutos) then DsProdutos.Free;
  if Assigned(DsClientes) then DsClientes.Free;
  if Assigned(DsPedidoItem) then DsPedidoItem.Free;

  // Controllers
  if Assigned(FClienteAppService) then FClienteAppService.Free;
  if Assigned(FProdutoAppService) then FProdutoAppService.Free;
  if Assigned(FPedidoAppService) then  FPedidoAppService.Free;

  // Models
  if Assigned(FCliente) then FCliente.Free;
  if Assigned(FPedido) then  FPedido.Free;
  if Assigned(FPedidoItem) then FPedidoItem.Free;

  // Transação
  if Assigned(TransacaoPedidos) then
  begin
    if TransacaoPedidos.Active then
      TransacaoPedidos.Rollback;
  end;

  inherited Destroy;
end;

procedure TFrmCadPedido.FormCreate(Sender: TObject);
var ProdutoRepository: IProdutoRepository;
    ProdutoService: IProdutoService;
    PedidoRepository: IPedidoRepository;
    PedidoService: IPedidoService;
    ClienteRepository: IClienteRepository;
    ClienteService: IClienteService;
    Connection: TFDConnection;
begin
  inherited;
  if TConexao.GetInstance.Connection.TestarConexao then
  begin
    // Define Transacao pra Pedidos
    TConexao.GetInstance.Connection.InciarTransacao;
    TransacaoPedidos := TConexao.GetInstance.Connection.CriarTransaction;

    // Cria Tabelas
    TblProdutos := TConexao.GetInstance.Connection.CriarQuery;
    TblClientes := TConexao.GetInstance.Connection.CriarQuery;

    // Atribui DataSet às tabelas
    DsClientes.DataSet := TblClientes;
    DsProdutos.DataSet := TblProdutos;

    //Instancias Classes
    ProdutoRepository := TProdutoRepository.Create(Connection);
    ProdutoService := TProdutoService.Create(Connection);
    ClienteRepository := TClienteRepository.Create(Connection);
    ClienteService := TClienteService.Create(Connection);
    PedidoRepository := TPedidoRepository.Create(Connection);
    PedidoService := TPedidoService.Create(Connection);
    FProdutoAppService := TProdutoAppService.Create(ProdutoRepository, ProdutoService);
    FClienteAppService := TClienteAppService.Create(ClienteRepository, ClienteService);
    FCliente := TCliente.Create;
    FPedido := TPedido.Create;
    FPedidoAppService := TPedidoAppService.Create(PedidoRepository, PedidoService);
    FPedidoItem := TPedidoItem.Create;
    FPedidoItemAppService := TPedidoItemAppService.Create;

    // Variáveis locais
    totPedido := 0;
    pesqPedido := False;
    SetLength(ValoresOriginais, 4);
    FOperacao := opInicio;
    MTblPedidoItem.CreateDataSet;

    // Define configuração DbLookupComboBox
    LcbxNomeCliente.KeyField := 'cod_cliente';
    LcbxNomeCliente.ListField := 'des_razaosocial';
    LcbxNomeCliente.ListSource := DsClientes;

    LCbxProdutos.KeyField := 'cod_produto';
    LCbxProdutos.ListField := 'des_descricao';
    LCbxProdutos.ListSource := DsProdutos;
  end
  else
  begin
    ShowMessage('Não foi possível conectar ao banco de dados!');
    Close;
  end;
end;

procedure TFrmCadPedido.FormShow(Sender: TObject);
begin
  inherited;
  totPedido := 0;
  FClienteAppService.PreencherComboClientes(TblClientes);
  FProdutoAppService.PreencherComboProdutos(TblProdutos);
  VerificaBotoes(FOperacao);
  GrbDados.Enabled := True;
  GrbGrid.Enabled := False;
end;

procedure TFrmCadPedido.CarregarPedidos(ACodPedido: Integer);
var Item: TPedidoItem;
    ItensPedido: TList<TPedidoItem>;
begin
  MTblPedidoItem.Close;
  MTblPedidoItem.CreateDataSet;

  if ACodPedido > 0 then
    codigoPedido := ACodPedido;

  if not FPedidoAppService.CarregarCampos(FPedido, codigoPedido) then
  begin
    MessageDlg('Pedido não encontado!', mtInformation, [mbOK], 0);
    LimparCamposPedido();
    EdtCodPedido.SetFocus;
    Exit;
  end;

  with FPedido do
  begin
    EdtCodPedido.Text := IntToStr(Cod_Pedido);
    EdtDataPedido.Text := DateToStr(Dta_Pedido);
    EdtCodCliente.Text := IntToStr(Cod_Cliente);
    EdtTotalPedido.Text := FormatFloat('######0.00', Val_Pedido);
  end;

  // Carregar os itens do Pedido usando a AppService
  ItensPedido := FPedidoItemAppService.CarregarItensPedido(codigoPedido);
  try
    for Item in ItensPedido do
    begin
      MTblPedidoItem.Append;
      MTblPedidoItemID_PEDIDO.AsInteger := Item.Id_Pedido;
      MTblPedidoItemCOD_PEDIDO.AsInteger := Item.Cod_Pedido;
      MTblPedidoItemCOD_PRODUTO.AsInteger := Item.Cod_Produto;
      MTblPedidoItemDES_DESCRICAO.AsString := Item.Des_Descricao;
      MTblPedidoItemVAL_QUANTIDADE.AsInteger := Item.Val_Quantidade;
      MTblPedidoItemVAL_PRECOUNITARIO.AsFloat := Item.Val_PrecoUnitario;
      MTblPedidoItemVAL_TOTALITEM.AsFloat := Item.Val_TotalItem;
      MTblPedidoItem.Post;
    end;
  finally
    ItensPedido.Free;
  end;
end;

procedure TFrmCadPedido.InserirPedidoItens;
begin
  MTblPedidoItem.First;
  while not MTblPedidoItem.eof do
  begin
    with FPedidoItem do
    begin
      Cod_Pedido := FPedido.Cod_Pedido;
      Cod_Produto := MTblPedidoItemCOD_PRODUTO.AsInteger;
      Des_Descricao := MTblPedidoItemDES_DESCRICAO.AsString;
      Val_PrecoUnitario := MTblPedidoItemVAL_PRECOUNITARIO.AsFloat;
      Val_Quantidade := MTblPedidoItemVAL_QUANTIDADE.AsInteger;
      Val_TotalItem := MTblPedidoItemVAL_TOTALITEM.AsFloat;

      if FPedidoItemAppService.Inserir(FPedidoItem) = false then
        raise Exception.Create(sErro);
    end;
    MTblPedidoItem.Next;
  end;
end;

procedure TFrmCadPedido.ExcluirPedidos;
var sErro: string;
begin
  if MessageDlg('Deseja realmente excluir o pedido selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
  begin
    if FPedidoAppService.ExecutarTransacao(
      procedure
      begin
        FPedidoItemAppService.Excluir(StrToInt(EdtCodPedido.Text));
        FPedidoAppService.Excluir(StrToInt(EdtCodPedido.Text))
      end) then
      MessageDlg('Pedido excluído com sucesso!', mtInformation, [mbOk], 0)
    else
      raise Exception.Create(sErro);
  end;
end;

function TFrmCadPedido.ValidarDados(ATipoDados: string): Boolean;
var Erros: TArray<string>;
    LPrecoUnitario, LPrecoTotal: Double;
    LCodProduto, LQuantidade: Integer;
    LPedido: TPedido;
begin
  Result := False;
  if ATipoDados = 'Pedido' then
  begin
    try
      // Criar um pedido temporário para validação
      LPedido := TPedido.Create;
      try
        LPedido.Dta_Pedido := StrToDateDef(EdtDataPedido.Text, 0);
        LPedido.Cod_Cliente := StrToIntDef(EdtCodCliente.Text, 0);
        LPedido.Val_Pedido := StrToFloatDef(StringReplace(StringReplace(EdtTotalPedido.Text, '.', '', [rfReplaceAll]),',',
                                            FormatSettings.DecimalSeparator, [rfReplaceAll]), 0);
        LPedido.Validar;
        Result := True;
      finally
        LPedido.Free;
      end;
    except
      on E: EPedidoException do
      begin
        MessageDlg(E.Message, mtError, [mbOK], 0);
        Exit;
      end;
      on E: Exception do
      begin
        MessageDlg('Erro na validação: ' + E.Message, mtError, [mbOK], 0);
        Exit;
      end;
    end;
  end
  else if ATipoDados = 'Item' then
  begin
    // Converter valores
    LCodProduto := 0;
    if LCbxProdutos.KeyValue <> Null then
      LCodProduto := LCbxProdutos.KeyValue;

    LQuantidade := StrToIntDef(EdtQuantidade.Text, 0);
    LPrecoUnitario := StrToFloatDef(StringReplace(StringReplace(EdtPrecoUnit.Text, '.', '', [rfReplaceAll]),',',
                                                  FormatSettings.DecimalSeparator, [rfReplaceAll]), 0);
    LPrecoTotal := StrToFloatDef(StringReplace(StringReplace(EdtPrecoTotal.Text, '.', '', [rfReplaceAll]),',',
                                               FormatSettings.DecimalSeparator, [rfReplaceAll]), 0);
    // Validar usando o validador
    Erros := TPedidoItemValidator.ValidarItem(LCodProduto, LQuantidade, LPrecoUnitario, LPrecoTotal);
    if Length(Erros) > 0 then
    begin
      MessageDlg('Erros no item:' + sLineBreak + string.Join(sLineBreak, Erros), mtError, [mbOK], 0);
      Exit;
    end;

    Result := True;
  end;
end;

function TFrmCadPedido.GravarDados: Boolean;
var Item: TPedidoItem;
    ItemPedido: TList<TPedidoItem>;
    Erros: TArray<string>;
    LPedido: TPedido;
begin
  Result := False;
  LPedido := TPedido.Create;
  try
    try
      LPedido.Dta_Pedido := StrToDateDef(EdtDataPedido.Text, 0);
      LPedido.Cod_Cliente := StrToIntDef(EdtCodCliente.Text, 0);
      LPedido.Val_Pedido := StrToFloatDef(StringReplace(StringReplace(EdtTotalPedido.Text, '.', '', [rfReplaceAll]),',',
                                          FormatSettings.DecimalSeparator, [rfReplaceAll]), 0);
      Erros := LPedido.ObterErrosValidacao;
      if Length(Erros) > 0 then
      begin
        MessageDlg('Erros no pedido:' + sLineBreak + string.Join(sLineBreak, Erros), mtError, [mbOK], 0);
        Exit;
      end;
    except
      on E: Exception do
      begin
        MessageDlg('Erro na validação: ' + E.Message, mtError, [mbOK], 0);
        Exit;
      end;
    end;
  finally
    LPedido.Free;
  end;

  if MTblPedidoItem.RecordCount = 0 then
  begin
    MessageDlg('Não existe itens cadastrados para o pedido!', mtWarning, [mbOK], 0);
    BtnInserirItens.SetFocus;
    Exit;
  end;

  if not TransacaoPedidos.Connection.Connected then
    TransacaoPedidos.Connection.Open();

  FPedido := ObterDadosFormulario;
  case FOperacao of
    opNovo:
    begin
      TransacaoPedidos.StartTransaction;
      try
        FPedidoAppService.Inserir(FPedido);
        InserirPedidoItens();
        TransacaoPedidos.Commit;
        codigoPedido := FPedido.Cod_Pedido;
        EdtCodPedido.Text := IntToStr(codigoPedido);
        MessageDlg('Pedido inserido com sucesso!', mtInformation, [mbOK],0);
        Result := True;
      except
        on E: Exception do
        begin
          TransacaoPedidos.Rollback;
          LimparCamposItens();
          LimparCamposPedido();
          MTblPedidoItem.Close;
          BtnInserirItens.Enabled := False;
          FOperacao := opErro;
          VerificaBotoes(FOperacao);
          raise Exception.Create(sErro + #13 + E.Message);
        end;
      end;
    end;

    opEditar:
    begin
      TransacaoPedidos.StartTransaction;
      try
        // deleta todos os itens do Pedido
        FPedidoItemAppService.Excluir(StrToInt(EdtCodPedido.Text));

        // Insere todos os itens contidos no grid
        InserirPedidoItens();

        // ALtera os dados do Pedido
        FPedidoAppService.Alterar(FPedido, StrToInt(EdtCodPedido.Text));

        MessageDlg('Pedido alterado com sucesso!', mtInformation, [mbOk], 0);
        TransacaoPedidos.Commit;
        EdtCodPedido.Text := IntToStr(codigoPedido);
        Result := True;
      except
        on E: Exception do
        begin
          TransacaoPedidos.Rollback;
          LimparCamposItens();
          LimparCamposPedido();
          MTblPedidoItem.Close;
          BtnInserirItens.Enabled := False;
          FOperacao := opErro;
          VerificaBotoes(FOperacao);
          raise Exception.Create(sErro + #13 + E.Message);
        end;
       end;
    end;
  end;

  if TransacaoPedidos.Connection.Connected then
    TransacaoPedidos.Connection.Close;

  if MessageDlg('Deseja exibir o resumo do pedido ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
  begin
    if not Assigned(FrmMostraPedido) then
    begin
      Application.CreateForm(TFrmMostraPedido, FrmMostraPedido);
      FClienteAppService.PreencherCamposForm(FCliente, StrToInt(EdtCodCliente.Text));
      with FCliente do
      begin
        FrmMostraPedido.LblNomeCliente.Caption := Des_NomeFantasia;
        FrmMostraPedido.LblEndCompleto.Caption := FCliente.Endereco.Logradouro + ' Número: ' + FCliente.Endereco.Numero;
        FrmMostraPedido.LblNomeCidade.Caption := FCliente.Endereco.Cidade;
        FrmMostraPedido.LblNomeUF.Caption := FCliente.Endereco.UF;
        FrmMostraPedido.LblNroCNPJ.Caption := FCliente.Documento.CNPJ;
        FrmMostraPedido.LblNroFone.Caption := FCliente.Contato.Telefone;
      end;

      with FrmMostraPedido,FPedido do
      begin
        LblNroPedido.Caption := IntToStr(Cod_Pedido);
        LblDataPedido.Caption := DateToStr(Dta_Pedido);
        LblVlrTotal.Caption := FormatFloat('########0.00', Val_Pedido);
      end;

       // Chama o método para carregar os itens do pedido
      ItemPedido := FPedidoItemAppService.CarregarItensPedido(FPedido.Cod_Pedido);
      try
        for Item in ItemPedido do
        begin
          with FrmMostraPedido do
          begin
            MTblPedidoItem.Append;
            MTblPedidoItemID_PEDIDO.AsInteger := Item.Id_Pedido;
            MTblPedidoItemCOD_PEDIDO.AsInteger := Item.Cod_Pedido;
            MTblPedidoItemCOD_PRODUTO.AsInteger := Item.Cod_Produto;
            MTblPedidoItemDES_DESCRICAO.AsString := Item.Des_Descricao;
            MTblPedidoItemVAL_QUANTIDADE.AsInteger := Item.Val_Quantidade;
            MTblPedidoItemVAL_PRECOUNITARIO.AsFloat := Item.Val_PrecoUnitario;
            MTblPedidoItemVAL_TOTALITEM.AsFloat := Item.Val_TotalItem;
            MTblPedidoItem.Post;
          end;
        end;
      finally
        ItemPedido.Free;
      end;
      FrmMostraPedido.ShowModal;
    end;
  end;
end;

function TFrmCadPedido.ObterDadosFormulario: TPedido;
var PedidoDTO: TPedidoDTO;
begin
  PedidoDTO := TPedidoDTO.Create;
  try
    with PedidoDTO do
    begin
      Cod_Pedido := StrToIntDef(EdtCodPedido.Text, 0);
      Dta_Pedido := StrToDate(EdtDataPedido.Text);
      Cod_Cliente := StrToInt(EdtCodCliente.Text);
      Val_Pedido := StrToFloat(EdtTotalPedido.Text);
    end;
    Result := TPedido.Create;
    PedidoDTO.ToEntity(Result);
  finally
    PedidoDTO.Free;
  end;
end;

procedure TFrmCadPedido.LimparCamposPedido;
begin
  EdtCodPedido.Text := EmptyStr;
  EdtDataPedido.Text := EmptyStr;
  EdtCodCliente.Text := EmptyStr;
  LcbxNomeCliente.KeyValue := 0;
  EdtTotalPedido.Text := '0.00';
end;

procedure TFrmCadPedido.LimparCamposItens;
begin
  LCbxProdutos.KeyValue := 0;
  EdtQuantidade.Text := EmptyStr;
  EdtPrecoUnit.Text := EmptyStr;
  EdtPrecoTotal.Text := EmptyStr;
end;

procedure TFrmCadPedido.PreencheCdsPedidoItem;
begin
  if not MTblPedidoItem.Active then
    MTblPedidoItem.Open;

  if alterouGrid then
  begin
    with MTblPedidoItem do
    begin
      totPedido := totPedido - totPedidoAnt;
      MTblPedidoItem.Locate('ID_Pedido', idItem, []);
      MTblPedidoItem.Edit;
      try
        MTblPedidoItemCOD_PRODUTO.AsInteger := LCbxProdutos.KeyValue;
        MTblPedidoItemDES_DESCRICAO.AsString := LCbxProdutos.Text;
        MTblPedidoItemVAL_QUANTIDADE.AsInteger := StrToInt(EdtQuantidade.Text);
        MTblPedidoItemVAL_PRECOUNITARIO.AsFloat := StrToFloat(StringReplace(StringReplace(EdtPrecoUnit.Text, '.', '', [rfReplaceAll]), ',', FormatSettings.DecimalSeparator, [rfReplaceAll]));
        MTblPedidoItemVAL_TOTALITEM.AsFloat := StrToFloat(StringReplace(StringReplace(EdtPrecoTotal.Text, '.', '', [rfReplaceAll]), ',', FormatSettings.DecimalSeparator, [rfReplaceAll]));
        MTblPedidoItem.Post;
        totPedido := totPedido + MTblPedidoItemVAL_TOTALITEM.AsFloat;
        EdtTotalPedido.Text := FormatFloat('######0.00', totPedido);
      except
        MTblPedidoItem.Cancel;
        raise;
      end;
    end;
  end
  else
  begin
    with MTblPedidoItem do
    begin
      MTblPedidoItem.Append;
      try
        MTblPedidoItemCOD_PRODUTO.AsInteger := LCbxProdutos.KeyValue;
        MTblPedidoItemDES_DESCRICAO.AsString := LCbxProdutos.Text;
        MTblPedidoItemVAL_QUANTIDADE.AsInteger := StrToInt(EdtQuantidade.Text);
        MTblPedidoItemVAL_PRECOUNITARIO.AsFloat := StrToFloat(StringReplace(StringReplace(EdtPrecoUnit.Text, '.', '', [rfReplaceAll]), ',', FormatSettings.DecimalSeparator, [rfReplaceAll]));
        MTblPedidoItemVAL_TOTALITEM.AsFloat := StrToFloat(StringReplace(StringReplace(EdtPrecoTotal.Text, '.', '', [rfReplaceAll]), ',', FormatSettings.DecimalSeparator, [rfReplaceAll]));
        MTblPedidoItem.Post;
        totPedido := totPedido + MTblPedidoItemVAL_TOTALITEM.AsFloat;
        EdtTotalPedido.Text := FormatFloat('######0.00', totPedido);
      except
        MTblPedidoItem.Cancel;
        raise;
      end;
    end;
  end;
end;

procedure TFrmCadPedido.VerificaBotoes(AOperacao: TOperacao);
begin
  BtnInserir.Enabled := AOperacao in [opInicio, opNavegar];
  BtnAlterar.Enabled := AOperacao = opNavegar;
  BtnExcluir.Enabled := AOperacao = opNavegar;
  BtnSair.Enabled := AOperacao in [opInicio, opNavegar, opErro];

  BtnGravar.Enabled := AOperacao in [opNovo, opEditar];
  BtnCancelar.Enabled := AOperacao in [opNovo, opEditar];

  BtnPesquisar.Enabled := AOperacao in [opInicio, opNavegar];
  BtnLimpaCampos.Enabled := EdtCodPedido.Enabled;

  EdtCodPedido.Enabled := AOperacao in [opInicio, opNavegar];
  EdtDataPedido.Enabled := AOperacao in [opNovo, opEditar];
  EdtCodCliente.Enabled := AOperacao in [opNovo, opEditar];
  LcbxNomeCliente.Enabled := AOperacao in [opNovo, opEditar];
  //GrbGrid.Enabled := AOperacao in [opNovo, opEditar];
end;

procedure TFrmCadPedido.HabilitarBotaoIncluirItens;
begin
  if (FOperacao = opNovo) then
    BtnInserirItens.Enabled := (EdtDataPedido.Text <> '') and (EdtCodCliente.Text <> '');
end;

procedure TFrmCadPedido.BtnInserirClick(Sender: TObject);
begin
  inherited;
  MTblPedidoItem.Active := False;
  GrbDados.Enabled := True;
  FOperacao := opNovo;
  VerificaBotoes(opNovo);
  LimparCamposPedido();
  EdtDataPedido.Text := DateToStr(Date);
  EdtDataPedido.SetFocus;
end;

procedure TFrmCadPedido.BtnAddItemGridClick(Sender: TObject);
var Erros: TArray<string>;
    LPrecoUnitario, LPrecoTotal: Double;
    LCodProduto, LQuantidade: Integer;
begin
  inherited;

  // Converter valores
  LCodProduto := 0;
  if LCbxProdutos.KeyValue <> Null then
    LCodProduto := LCbxProdutos.KeyValue;

  LQuantidade := StrToIntDef(EdtQuantidade.Text, 0);
  LPrecoUnitario := StrToFloatDef(StringReplace(StringReplace(EdtPrecoUnit.Text, '.', '', [rfReplaceAll]),',',
                                  FormatSettings.DecimalSeparator, [rfReplaceAll]), 0);
  LPrecoTotal := StrToFloatDef(StringReplace(StringReplace(EdtPrecoTotal.Text, '.', '', [rfReplaceAll]),',',
                               FormatSettings.DecimalSeparator, [rfReplaceAll]), 0);

  Erros := TPedidoItemValidator.ValidarItem(LCodProduto, LQuantidade, LPrecoUnitario, LPrecoTotal);
  if Length(Erros) > 0 then
  begin
    MessageDlg('Erros no item:' + sLineBreak + string.Join(sLineBreak, Erros),
      mtError, [mbOK], 0);
    Exit;
  end;

  // Se passou na validação, adiciona ao grid
  PreencheCdsPedidoItem();
  LimparCamposItens;
  LCbxProdutos.SetFocus;
end;

procedure TFrmCadPedido.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  FOperacao := opEditar;
  BtnInserirItens.Caption := 'Alterar Itens';
  BtnInserirItens.Enabled := True;
  GrbDados.Enabled := True;
  EdtDataPedido.Enabled := True;
  EdtCodCliente.Enabled := True;
  LcbxNomeCliente.Enabled := True;
  totPedido := StrToFloat(EdtTotalPedido.Text);
  VerificaBotoes(FOperacao);
  EdtDataPedido.SetFocus;
end;

procedure TFrmCadPedido.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  ExcluirPedidos();
  LimparCamposPedido();
  MTblPedidoItem.Close;
  FOperacao := opInicio;
  VerificaBotoes(FOperacao);
end;

procedure TFrmCadPedido.BtnGravarClick(Sender: TObject);
begin
  inherited;
  if GravarDados() then
  begin
    FOperacao := opNavegar;
    VerificaBotoes(FOperacao);
    GrbDados.Enabled := True;
    GrbGrid.Enabled:= False;
    BtnInserirItens.Enabled := False;
    FClienteAppService.PreencherComboClientes(TblClientes);
    FProdutoAppService.PreencherComboProdutos(TblProdutos);
    EdtCodClienteExit(Sender);
  end;
end;

procedure TFrmCadPedido.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  if FOperacao = opNovo then
  begin
    FOperacao := opInicio;
    LimparCamposPedido();
    LimparCamposItens();
    GrbDados.Enabled := True;
    VerificaBotoes(opInicio);
    BtnInserirItens.Enabled := False;
    if MTblPedidoItem.Active then
      MTblPedidoItem.Close;
  end;

  if FOperacao = opEditar then
  begin
    FOperacao := opNavegar;
    GrbDados.Enabled := True;
    EdtDataPedido.Text := ValoresOriginais[1];
    EdtCodCliente.Text := ValoresOriginais[2];
    EdtTotalPedido.Text := ValoresOriginais[3];
    EdtCodClienteExit(Sender);
    CarregarPedidos(0);
  end;

  VerificaBotoes(FOperacao);
  BtnInserirItens.Enabled := False;
end;

procedure TFrmCadPedido.BtnSairClick(Sender: TObject);
begin
  inherited;
  if Assigned(MTblPedidoItem) and MTblPedidoItem.Active then
    MTblPedidoItem.Close;

  if Assigned(TransacaoPedidos) and TransacaoPedidos.Active then
    TransacaoPedidos.Rollback;

  Close;
end;

procedure TFrmCadPedido.BtnInserirItensClick(Sender: TObject);
var Erros: TArray<string>;
    LPedido: TPedido;
begin
  inherited;
  // Validar dados básicos do pedido antes de permitir incluir itens
  LPedido := TPedido.Create;
  try
    try
      LPedido.Dta_Pedido := StrToDateDef(EdtDataPedido.Text, 0);
      LPedido.Cod_Cliente := StrToIntDef(EdtCodCliente.Text, 0);
      LPedido.Val_Pedido := 0; // Valor pode ser zero inicialmente

      Erros := LPedido.ObterErrosValidacao;

      if Length(Erros) > 0 then
      begin
        MessageDlg('Corrija os erros antes de incluir itens:' + sLineBreak + string.Join(sLineBreak, Erros), mtError, [mbOK], 0);
        Exit;
      end;
    except
      on E: Exception do
      begin
        MessageDlg('Erro na validação: ' + E.Message, mtError, [mbOK], 0);
        Exit;
      end;
    end;
  finally
    LPedido.Free;
  end;

  GrbDados.Enabled := False;
  GrbGrid.Enabled := True;
  BtnCancelar.Enabled := True;
  LCbxProdutos.SetFocus;
end;

procedure TFrmCadPedido.BtnLimpaCamposClick(Sender: TObject);
begin
  inherited;
  LimparCamposPedido();
  MTblPedidoItem.Close;
end;

procedure TFrmCadPedido.BtnDelItemGridClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja excluir o registro selecionado?', mtConfirmation, [mbYes, mbNo], mrNo) = mrNo then
    Exit
  else
  begin
    totPedido := totPedido - MTblPedidoItemVAL_TOTALITEM.AsFloat;
    MTblPedidoItem.Locate('ID_PEDIDO', MTblPedidoItemID_Pedido.AsInteger, []);
    MTblPedidoItem.Delete;
    MTblPedidoItem.ApplyUpdates(0);
    if totPedido < 0 then
      totPedido := 0;

    EdtTotalPedido.Text := FormatFloat('######0.00', totPedido);
  end;
end;

procedure TFrmCadPedido.BtnPesquisarClick(Sender: TObject);
var LCodPedido: Integer;
begin
  inherited;
  pesqPedido := False;

  if TryStrToInt(EdtCodPedido.Text, LCodPedido) then
    LCodPedido := StrToInt(EdtCodPedido.Text)
  else
    LCodPedido := 0;

  if EdtCodPedido.Text = EmptyStr then // Pesquisa através da janela de pesquisa.
  begin
    if not Assigned(FrmPesquisaPedidos) then
      FrmPesquisaPedidos := TFrmPesquisaPedidos.Create(Self);

    FrmPesquisaPedidos.ShowModal;
    FrmPesquisaPedidos.Free;
    FrmPesquisaPedidos := nil;

    if pesqPedido then
    begin
      CarregarPedidos(codigoPedido);
      ValoresOriginais[0] := EdtCodPedido.Text;
      ValoresOriginais[1] := EdtDataPedido.Text;
      ValoresOriginais[2] := EdtCodCliente.Text;
      ValoresOriginais[3] := EdtTotalPedido.Text;
      EdtCodClienteExit(Sender);

      if FOperacao = opEditar then
        BtnAlterar.Click;

      VerificaBotoes(FOperacao);
    end;
  end;

  if LCodPedido > 0 then  // Pesquisa informando o codigo da Pedido.
  begin
    CarregarPedidos(LCodPedido);
    EdtCodClienteExit(Sender);
    FOperacao := opNavegar;
    VerificaBotoes(FOperacao);
  end;
end;

procedure TFrmCadPedido.EdtCodPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadPedido.EdtDataPedidoChange(Sender: TObject);
begin
  inherited;
  Formatar(EdtDataPedido, TFormato.Dt);
  HabilitarBotaoIncluirItens();
end;

procedure TFrmCadPedido.EdtCodClienteChange(Sender: TObject);
begin
  inherited;
  HabilitarBotaoIncluirItens();
end;

procedure TFrmCadPedido.EdtCodClienteExit(Sender: TObject);
begin
  inherited;
  if EdtCodCliente.Text <> '' then
    LCbxNomeCliente.KeyValue := StrToInt(EdtCodCliente.Text);
end;

procedure TFrmCadPedido.EdtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadPedido.LcbxNomeClienteClick(Sender: TObject);
begin
  inherited;
  if LCbxNomeCliente.KeyValue > 0 then
    EdtCodCliente.Text := IntToStr(LcbxNomeCliente.KeyValue)
end;

procedure TFrmCadPedido.LCbxProdutosClick(Sender: TObject);
var LPrecoUnitario: Double;
begin
  inherited;
  LPrecoUnitario := FProdutoAppService.GetValorUnitario(LCbxProdutos.KeyValue);
  EdtPrecoUnit.Text := FormatFloat('######0.00', LPrecoUnitario);
  EdtQuantidade.Text := '1';
  EdtQuantidade.SetFocus;
end;

procedure TFrmCadPedido.EdtQuantidadeExit(Sender: TObject);
var LValorItem, LPrecoUnit: Double;
    LQuantidade: Integer;
begin
  inherited;
  if (EdtQuantidade.Text = EmptyStr) or (StrToInt(EdtQuantidade.Text) = 0) then
  begin
    MessageDlg('Informe um valor válido para Quantidade!', mtInformation, [mbOK], 0);
    if EdtQuantidade.CanFocus then
      EdtQuantidade.SetFocus;

    Exit;
  end;

  if not TryStrToFloat(EdtPrecoUnit.Text, LPrecoUnit) then
    LPrecoUnit := 0;

  EdtPrecoUnit.Text := FormatFloat('######0.00', LPrecoUnit);

  if not TryStrToInt(EdtQuantidade.Text, LQuantidade) then
  begin
    LQuantidade := 1;
    EdtQuantidade.Text := '1';
  end;

  LValorItem := (StrToInt(EdtQuantidade.Text) * StrToFloat(EdtPrecoUnit.Text));
  EdtPrecoTotal.Text := FormatFloat('#0.00', LValorItem);
end;

procedure TFrmCadPedido.EdtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadPedido.EdtPrecoUnitExit(Sender: TObject);
var LValor, LValorItem: Double;
begin
  inherited;
  if TryStrToFloat(EdtPrecoUnit.Text, LValor) then
  begin
    EdtPrecoUnit.Text := FormatFloat('######0.00', LValor);
    LValorItem := (StrToInt(EdtQuantidade.Text) * StrToFloat(EdtPrecoUnit.Text));
    EdtPrecoTotal.Text := FormatFloat('#0.00', LValorItem);
  end;
end;

procedure TFrmCadPedido.EdtPrecoUnitKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadPedido.EdtPrecoTotalExit(Sender: TObject);
var LValor: Double;
begin
  inherited;
  if TryStrToFloat(EdtPrecoTotal.Text, LValor) then
    EdtPrecoTotal.Text := FormatFloat('######0.00', LValor)

end;

procedure TFrmCadPedido.EdtPrecoTotalKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  {if Assigned(MTblPedidoItem) and MTblPedidoItem.Active then
    MTblPedidoItem.Close;

  if Assigned(TransacaoPedidos) and TransacaoPedidos.Active then
    TransacaoPedidos.Rollback;}

  Action := caFree;
end;

procedure TFrmCadPedido.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0)
end;

procedure TFrmCadPedido.DbGridItensPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    LCbxProdutos.KeyValue := MTblPedidoItemCOD_PRODUTO.AsInteger;
    EdtQuantidade.Text := IntToStr(MTblPedidoItemVAL_QUANTIDADE.AsInteger);
    EdtPrecoUnit.Text := FloatToStr(MTblPedidoItemVAL_PRECOUNITARIO.AsFloat);
    EdtPrecoTotal.Text := FloatToStr(MTblPedidoItemVAL_TOTALITEM.AsFloat);
    alterouGrid := True;
    idItem := MTblPedidoItemID_Pedido.AsInteger;
    totPedidoAnt := MTblPedidoItemVAL_TOTALITEM.AsFloat;
    Key := 0;
  end;

  if Key = VK_DELETE then
  begin
   BtnDelItemGridClick(Sender);
  end;
end;

end.

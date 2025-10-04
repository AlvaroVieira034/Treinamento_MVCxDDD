unit ucadcliente;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ClienteModel, ICliente.Service,
  ICliente.Repository, ClienteService, ClienteDTO, ClienteAppService, ClienteRepository,
  ClienteExceptions, Conexao, ucadastropadrao, CEPService, EnderecoValueObject,
  ContatoValueObject, DocumentoValueObject,  FormatUtil, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Comp.Client, System.UITypes;

{$ENDREGION}

type
  TOperacao = (opInicio, opNovo, opEditar, opNavegar);
  TFrmCadCliente = class(TFrmCadastroPadrao)

{$REGION 'Componentes'}

    PnlPesquisar: TPanel;
    BtnPesquisar: TSpeedButton;
    Label12: TLabel;
    EdtPesquisar: TEdit;
    CbxFiltro: TComboBox;
    DbGridClientes: TDBGrid;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    BtnPesquisarCep: TSpeedButton;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    LblDocumento: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    EdtCep: TEdit;
    EdtCidade: TEdit;
    EdtUF: TEdit;
    EdtCodigoCliente: TEdit;
    EdtRazaoSocial: TEdit;
    EdtLogradouro: TEdit;
    EdtComplemento: TEdit;
    EdtTelefone: TEdit;
    EdtCnpj: TEdit;
    EdtNomeFantasia: TEdit;
    EdtContato: TEdit;
    EdtNumero: TEdit;
    EdtEmail: TEdit;
    RdgSituacao: TRadioGroup;
    RdgTipoPessoa: TRadioGroup;


{$ENDREGION}

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DbGridClientesCellClick(Column: TColumn);
    procedure DbGridClientesDblClick(Sender: TObject);
    procedure DbGridClientesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnPesquisarCepClick(Sender: TObject);
    procedure EdtCepExit(Sender: TObject);
    procedure EdtCnpjExit(Sender: TObject);
    procedure EdtCnpjKeyPress(Sender: TObject; var Key: Char);
    procedure CbxFiltroChange(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPesquisarChange(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure RdgTipoPessoaClick(Sender: TObject);

  private
    ValoresOriginais: array of string;
    FCliente: TCliente;
    FClienteAppService: TClienteAppService;

    procedure PreencherGridClientes;
    procedure PreencherCamposForm;
    procedure LimparCamposForm(Form: TForm);
    procedure VerificarBotoes(AOperacao: TOperacao);
    procedure PreencherCbxFiltro;
    procedure SalvarValoresOriginais;
    procedure RestaurarValoresOriginais;
    function GravarDados: Boolean;
    function ObterDadosFormulario: TCliente;
    function GetCampoFiltro: string;
    function GetDataSource: TDataSource;

  public
    FOperacao: TOperacao;
    DsClientes: TDataSource;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FrmCadCliente: TFrmCadCliente;

implementation

uses System.JSON;

{$R *.dfm}

constructor TFrmCadCliente.Create(AOwner: TComponent);
begin
  inherited;
  DsClientes := TDataSource.Create(nil);
end;

destructor TFrmCadCliente.Destroy;
begin
  if Assigned(DsClientes) then DsClientes.Free;
  if Assigned(FCliente) then FCliente.Free;

  inherited Destroy;
end;

procedure TFrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  if TConexao.GetInstance.Connection.TestarConexao then
  begin
    FCliente := TCliente.Create;
    FClienteAppService := TClienteAppService.Create(TClienteRepository.Create, TClienteService.Create);
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

procedure TFrmCadCliente.FormShow(Sender: TObject);
begin
  inherited;
  if DbGridClientes.DataSource = nil then
    GetDataSource();

  PreencherGridClientes();
  VerificarBotoes(FOperacao);
  if EdtPesquisar.CanFocus then
    EdtPesquisar.SetFocus;
end;

procedure TFrmCadCliente.PreencherGridClientes;
var LCampo: string;
begin
  LCampo := GetCampoFiltro;
  FClienteAppService.PreencheGridClientes(Trim(EdtPesquisar.Text) + '%', LCampo);
  LblTotRegistros.Caption := 'Clientes: ' + InttoStr(DbGridClientes.DataSource.DataSet.RecordCount);
  Application.ProcessMessages;
end;

procedure TFrmCadCliente.PreencherCamposForm;
var Cliente: TCliente;
    ClienteDTO: TClienteDTO;
    CodigoCliente: Integer;
begin
  if not Assigned(DsClientes.DataSet) or DsClientes.DataSet.IsEmpty then
    Exit;

  try
    CodigoCliente := DsClientes.DataSet.FieldByName('COD_CLIENTE').AsInteger;
    Cliente := FClienteAppService.BuscarClientePorCodigo(FCliente, CodigoCliente);
    try
      ClienteDTO := TClienteDTO.FromEntity(Cliente);
      try
        EdtCodigoCliente.Text := IntToStr(ClienteDTO.Cod_Cliente);
        RdgTipoPessoa.ItemIndex := ClienteDTO.Cod_Tipo;
        RdgSituacao.ItemIndex := ClienteDTO.Cod_Ativo;
        EdtNomeFantasia.Text := ClienteDTO.Des_NomeFantasia;
        EdtRazaoSocial.Text := ClienteDTO.Des_RazaoSocial;
        EdtContato.Text := ClienteDTO.Des_Contato;
        EdtCep.Text := ClienteDTO.Des_Cep;
        EdtLogradouro.Text := ClienteDTO.Des_Logradouro;
        EdtNumero.Text := ClienteDTO.Des_Numero;
        EdtComplemento.Text := ClienteDTO.Des_Complemento;
        EdtCidade.Text := ClienteDTO.Des_Cidade;
        EdtUF.Text := ClienteDTO.Des_UF;
        EdtTelefone.Text := ClienteDTO.Des_Telefone;
        EdtCnpj.Text := ClienteDTO.Des_Documento;
        EdtEmail.Text := ClienteDTO.Des_Email;

        SalvarValoresOriginais();
      finally
        ClienteDTO.Free;
      end;
    finally
      Cliente.Free;
    end;

  except
    on E: Exception do
    begin
      ShowMessage('Erro ao carregar dados do cliente: ' + E.Message);
      LimparCamposForm(Self);
    end;
  end;
end;

procedure TFrmCadCliente.LimparCamposForm(Form: TForm);
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
  DBGridClientes.Enabled := FOperacao in [opInicio, opNavegar];
end;

procedure TFrmCadCliente.VerificarBotoes(AOperacao: TOperacao);
begin
  BtnInserir.Enabled := AOperacao in [opInicio, opNavegar];
  BtnAlterar.Enabled := AOperacao = opNavegar;
  BtnExcluir.Enabled := AOperacao = opNavegar;
  BtnSair.Enabled := AOperacao in [opInicio, opNavegar];
  BtnGravar.Enabled := AOperacao in [opNovo, opEditar];
  BtnCancelar.Enabled := AOperacao in [opNovo, opEditar];
  GrbDados.Enabled := AOperacao in [opNovo, opEditar];
  DbGridClientes.Enabled := AOperacao in [opInicio, opNavegar];
  PnlPesquisar.Enabled := AOperacao in [opInicio, opNavegar];
end;

procedure TFrmCadCliente.PreencherCbxFiltro;
begin
  CbxFiltro.Items.AddObject('Todos', TObject(0));
  CbxFiltro.Items.AddObject('Código', TObject(1));
  CbxFiltro.Items.AddObject('Nome Fantasia', TObject(2));
  CbxFiltro.Items.AddObject('Razão Social', TObject(3));
  CbxFiltro.Items.AddObject('Cidade', TObject(4));
  CbxFiltro.ItemIndex := 0; // default = "Todos"
end;

procedure TFrmCadCliente.SalvarValoresOriginais;
begin
  SetLength(ValoresOriginais, 16);
  ValoresOriginais[0] := EdtCodigoCliente.Text;
  ValoresOriginais[1] := IntToStr(RdgTipoPessoa.ItemIndex);
  ValoresOriginais[2] := IntToStr(RdgSituacao.ItemIndex);
  ValoresOriginais[3] := EdtNomeFantasia.Text;
  ValoresOriginais[4] := EdtRazaoSocial.Text;
  ValoresOriginais[5] := EdtContato.Text;
  ValoresOriginais[6] := EdtCep.Text;
  ValoresOriginais[7] := EdtLogradouro.Text;
  ValoresOriginais[8] := EdtNumero.Text;
  ValoresOriginais[9] := EdtComplemento.Text;
  ValoresOriginais[10] := EdtCidade.Text;
  ValoresOriginais[11] := EdtUF.Text;
  ValoresOriginais[12] := EdtTelefone.Text;
  ValoresOriginais[13] := EdtCnpj.Text;
  ValoresOriginais[14] := EdtEmail.Text;
end;

procedure TFrmCadCliente.RestaurarValoresOriginais;
begin
  EdtCodigoCliente.Text := ValoresOriginais[0];
  RdgTipoPessoa.ItemIndex := StrToInt(ValoresOriginais[1]);
  RdgSituacao.ItemIndex := StrToInt(ValoresOriginais[2]);
  EdtNomeFantasia.Text := ValoresOriginais[3];
  EdtRazaoSocial.Text := ValoresOriginais[4];
  EdtContato.Text := ValoresOriginais[5];
  EdtCep.Text := ValoresOriginais[6];
  EdtLogradouro.Text := ValoresOriginais[7];
  EdtNumero.Text := ValoresOriginais[8];
  EdtComplemento.Text := ValoresOriginais[9];
  EdtCidade.Text := ValoresOriginais[10];
  EdtUF.Text := ValoresOriginais[11];
  EdtTelefone.Text := ValoresOriginais[12];
  EdtCnpj.Text := ValoresOriginais[13];
  EdtEmail.Text := ValoresOriginais[14];
end;

function TFrmCadCliente.GravarDados: Boolean;
var Cliente: TCliente;
    Erros: TArray<string>;
begin
  Result := False;
  Cliente := ObterDadosFormulario;
  try
    try
      Erros := Cliente.ObterErrosValidacao;
      if Length(Erros) > 0 then
      begin
        MessageDlg('Erros encontrados:' + sLineBreak + string.Join(sLineBreak, Erros), mtError, [mbOK], 0);
        Exit;
      end;

      case FOperacao of
        opNovo:
        begin
          Cliente.Cod_Cliente := 0;
          FClienteAppService.Inserir(Cliente);
          MessageDlg('Cliente incluído com sucesso!', mtInformation, [mbOk], 0);
        end;

        opEditar:
        begin
          FClienteAppService.Alterar(Cliente, StrToInt(EdtCodigoCliente.Text));
          MessageDlg('Cliente alterado com sucesso!', mtInformation, [mbOk], 0);
        end;
      end;

      Result := True;
      FOperacao := opNavegar;
      VerificarBotoes(FOperacao);
      PreencherGridClientes();
    except
      on E: EClienteException do
        MessageDlg('Erro de validação: ' + E.Message, mtError, [mbOK], 0);

      on E: EEnderecoInvalidoException do
        MessageDlg('Erro de endereço: ' + E.Message, mtError, [mbOK], 0);

      on E: EContatoInvalidoException do
        MessageDlg('Erro de contato: ' + E.Message, mtError, [mbOK], 0);

      on E: EDocumentoInvalidoException do
        MessageDlg('Erro de documento: ' + E.Message, mtError, [mbOK], 0);

      on E: EDocumentoDuplicadoException do
        MessageDlg('Erro de negócio: ' + E.Message, mtError, [mbOK], 0);

      on E: Exception do
        MessageDlg('Erro inesperado: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Cliente.Free;
  end;
end;

function TFrmCadCliente.ObterDadosFormulario: TCliente;
var ClienteDTO: TClienteDTO;
begin
  ClienteDTO := TClienteDTO.Create;
  try
    with ClienteDTO do
    begin
      Cod_Cliente := StrToIntDef(EdtCodigoCliente.Text, 0);
      Cod_Tipo := RdgTipoPessoa.ItemIndex;
      Cod_Ativo := RdgSituacao.ItemIndex;
      Des_NomeFantasia := EdtNomeFantasia.Text;
      Des_RazaoSocial := EdtRazaoSocial.Text;
      Des_Contato := EdtContato.Text;
      Des_Cep := EdtCep.Text;
      Des_Logradouro := EdtLogradouro.Text;
      Des_Numero := EdtNumero.Text;
      Des_Complemento := EdtComplemento.Text;
      Des_Cidade := EdtCidade.Text;
      Des_UF := EdtUF.Text;
      Des_Telefone := EdtTelefone.Text;
      Des_Documento := EdtCnpj.Text;
      Des_Email := EdtEmail.Text;
    end;

    Result := TCliente.Create;
    ClienteDTO.ToEntity(Result);
  finally
    ClienteDTO.Free;
  end;
end;

procedure TFrmCadCliente.RdgTipoPessoaClick(Sender: TObject);
begin
  inherited;
  if RdgTipoPessoa.ItemIndex = 0 then
  begin
    LblDocumento.Caption := ' *CPF:';
    EdtCnpj.MaxLength := 14;
  end;

  if RdgTipoPessoa.ItemIndex = 1 then
  begin
    LblDocumento.Caption := '*CNPJ:';
    EdtCnpj.MaxLength := 18;
  end;

end;

function TFrmCadCliente.GetCampoFiltro: string;
begin
  case Integer(CbxFiltro.Items.Objects[CbxFiltro.ItemIndex]) of
    0: Result := 'cli.des_nomefantasia';
    1: Result := 'cli.cod_cliente';
    2: Result := 'cli.des_nomefantasia';
    3: Result := 'cli.des_razaosocial';
    4: Result := 'cli.des_cidade';
  else
    Result := 'cli.des_nomefantasia';
  end;
end;

function TFrmCadCliente.GetDataSource: TDataSource;
begin
  DbGridClientes.DataSource := FClienteAppService.GetDataSource();
  DsClientes := FClienteAppService.GetDataSource();
end;

procedure TFrmCadCliente.DbGridClientesCellClick(Column: TColumn);
begin
  inherited;
  FOperacao := opNavegar;
  PreencherCamposForm();
  VerificarBotoes(FOperacao);
end;

procedure TFrmCadCliente.DbGridClientesDblClick(Sender: TObject);
begin
  inherited;
  FOperacao := opEditar;
  PreencherCamposForm();
  VerificarBotoes(FOperacao);
end;

procedure TFrmCadCliente.DbGridClientesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    PreencherCamposForm();
    VerificarBotoes(FOperacao);
    FOperacao := opEditar;
    BtnAlterarClick(Sender);
    EdtNomeFantasia.SetFocus;
    Key := 0;
  end;

  if Key = VK_DELETE then
  begin
    BtnExcluirClick(Sender);
  end;
end;

procedure TFrmCadCliente.CbxFiltroChange(Sender: TObject);
begin
  inherited;
  if CbxFiltro.Text = 'Todos' then
    EdtPesquisar.Text := EmptyStr;

  BtnPesquisar.Click;
  EdtPesquisar.SetFocus;
end;

procedure TFrmCadCliente.BtnInserirClick(Sender: TObject);
begin
  inherited;
  FOperacao := opNovo;
  VerificarBotoes(FOperacao);
  LimparCamposForm(Self);
  EdtNomeFantasia.SetFocus;
end;

procedure TFrmCadCliente.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  FOperacao := opEditar;
  PreencherCamposForm();
  VerificarBotoes(FOperacao);
  EdtNomeFantasia.SetFocus;
end;

procedure TFrmCadCliente.BtnGravarClick(Sender: TObject);
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

procedure TFrmCadCliente.BtnCancelarClick(Sender: TObject);
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
  PreencherGridClientes;
  EdtPesquisar.SetFocus;
end;

procedure TFrmCadCliente.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja realmente excluir o cliente selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
  begin
    try
      FClienteAppService.Excluir(StrToInt(EdtCodigoCliente.Text));
      MessageDlg('Cliente excluído com sucesso!', mtInformation, [mbOk], 0);
      LimparCamposForm(Self);
    except
      on E: Exception do
        MessageDlg('Erro ao excluir o cliente: ' + E.Message, mtError, [mbOk], 0);
    end;

    PreencherGridClientes();
  end;
end;

procedure TFrmCadCliente.BtnPesquisarCepClick(Sender: TObject);
var FCepService: TCEPService;
    JSONValue: TJSONValue;
    JSONObject: TJSONObject;
    Response: string;
begin
  inherited;
  FCepService := TCEPService.Create;
  try
    if EdtCep.Text = EmptyStr then
    begin
      MessageDlg('O CEP a pesquisar deve ser preenchido!', mtInformation, [mbOK], 0);
      Exit;
    end;

    Response := FCepService.ConsultarCep(EdtCep.Text, True);
    JSONValue := TJSONObject.ParseJSONValue(Response);
    if Assigned(JSONValue) and (JSONValue is TJSONObject) then
    begin
      JSONObject := JSONValue as TJSONObject;
      if JSONObject.GetValue('erro') <> nil then
      begin
        ShowMessage('CEP não encontrado!');
        Exit;
      end;

      EdtLogradouro.Text := JSONObject.GetValue<string>('logradouro', '');
      EdtCidade.Text := JSONObject.GetValue<string>('localidade', '');
      EdtUf.Text := JSONObject.GetValue<string>('uf', '');
      VerificarBotoes(FOperacao);
    end
    else
      ShowMessage('Erro ao processar a resposta do serviço de pesquisa do CEP');

  finally
    FreeAndNil(FCepService);
  end;
end;

procedure TFrmCadCliente.BtnPesquisarClick(Sender: TObject);
begin
  inherited;
  PreencherGridClientes();
end;

procedure TFrmCadCliente.EdtCepExit(Sender: TObject);
begin
  inherited;
  Formatar(EdtCep, TFormato.CEP);
end;

procedure TFrmCadCliente.EdtPesquisarChange(Sender: TObject);
begin
  inherited;
  PreencherGridClientes();
end;

procedure TFrmCadCliente.EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    PreencherCamposForm();
    BtnAlterarClick(Sender);
    Key := #0;
  end;
end;

procedure TFrmCadCliente.EdtCnpjExit(Sender: TObject);
begin
  inherited;
  if RdgTipoPessoa.ItemIndex = 0 then
    Formatar(EdtCnpj, TFormato.CPF);

  if RdgTipoPessoa.ItemIndex = 1 then
    Formatar(EdtCnpj, TFormato.CNPJ);
end;

procedure TFrmCadCliente.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0)
end;

procedure TFrmCadCliente.EdtCnpjKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0'..'9', #08]) then
    key := #0;
end;

procedure TFrmCadCliente.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.

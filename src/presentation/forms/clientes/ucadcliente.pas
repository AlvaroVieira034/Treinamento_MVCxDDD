unit ucadcliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ucadastropadrao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrmCadCliente = class(TFrmCadastroPadrao)
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
    Label5: TLabel;
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
    procedure BtnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadCliente: TFrmCadCliente;

implementation

{$R *.dfm}

procedure TFrmCadCliente.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.

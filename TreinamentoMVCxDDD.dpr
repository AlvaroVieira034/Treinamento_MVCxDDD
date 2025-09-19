program TreinamentoMVCxDDD;

uses
  Vcl.Forms,
  umain in 'src\presentation\forms\main\umain.pas' {FrmMain},
  ucadastropadrao in 'src\presentation\forms\base\ucadastropadrao.pas' {FrmCadastroPadrao},
  ucadcliente in 'src\presentation\forms\clientes\ucadcliente.pas' {FrmCadCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

program TreinamentoMVCxDDD;

uses
  Vcl.Forms,
  umain in 'src\presentation\forms\main\umain.pas' {FrmMain},
  ucadastropadrao in 'src\presentation\forms\base\ucadastropadrao.pas' {FrmCadastroPadrao},
  ucadcliente in 'src\presentation\forms\clientes\ucadcliente.pas' {FrmCadCliente},
  ClienteRepository in 'src\infrastructure\persistence\repositories\ClienteRepository.pas',
  ConexaoAdapter in 'src\infrastructure\persistence\databases\ConexaoAdapter.pas',
  ConexaoSingleton in 'src\infrastructure\persistence\databases\ConexaoSingleton.pas',
  DatabaseConnection in 'src\infrastructure\persistence\databases\DatabaseConnection.pas',
  IConexao.Database in 'src\infrastructure\persistence\databases\IConexao.Database.pas',
  ClienteModel in 'src\domain\models\cliente\ClienteModel.pas',
  EnderecoValueObject in 'src\domain\valueobjects\EnderecoValueObject.pas',
  ContatoValueObject in 'src\domain\valueobjects\ContatoValueObject.pas',
  DocumentoValueObject in 'src\domain\valueobjects\DocumentoValueObject.pas',
  Validadores in 'src\shared\utils\Validadores.pas',
  ClienteAppService in 'src\application\services\ClienteAppService.pas',
  FormatUtil in 'src\shared\utils\FormatUtil.pas',
  ClienteDTO in 'src\application\dtos\ClienteDTO.pas',
  CEPService in 'src\infrastructure\services\CEPService.pas',
  ICliente.Service in 'src\domain\services\ICliente.Service.pas',
  ICliente.Repository in 'src\domain\repositories\ICliente.Repository.pas',
  ClienteExceptions in 'src\domain\exceptions\ClienteExceptions.pas',
  ClienteService in 'src\infrastructure\persistence\services\ClienteService.pas',
  ProdutoModel in 'src\domain\models\produto\ProdutoModel.pas',
  ProdutoDTO in 'src\application\dtos\ProdutoDTO.pas',
  ProdutoRepository in 'src\infrastructure\persistence\repositories\ProdutoRepository.pas',
  ProdutoService in 'src\infrastructure\persistence\services\ProdutoService.pas',
  ProdutoAppSevice in 'src\application\services\ProdutoAppSevice.pas',
  IProdutoService in 'src\domain\services\IProdutoService.pas',
  IProdutoRepository in 'src\domain\repositories\IProdutoRepository.pas',
  ProdutoExceptions in 'src\domain\exceptions\ProdutoExceptions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

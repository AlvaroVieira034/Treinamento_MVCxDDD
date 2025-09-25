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
  ProdutoDTO in 'src\application\dtos\ProdutoDTO.pas',
  ProdutoRepository in 'src\infrastructure\persistence\repositories\ProdutoRepository.pas',
  ProdutoService in 'src\infrastructure\persistence\services\ProdutoService.pas',
  ProdutoAppSevice in 'src\application\services\ProdutoAppSevice.pas',
  ProdutoExceptions in 'src\domain\exceptions\ProdutoExceptions.pas',
  ClienteModel in 'src\domain\models\ClienteModel.pas',
  ProdutoModel in 'src\domain\models\ProdutoModel.pas',
  ProdutoValueObject in 'src\domain\valueobjects\ProdutoValueObject.pas',
  IProduto.Repository in 'src\domain\repositories\IProduto.Repository.pas',
  IProduto.Service in 'src\domain\services\IProduto.Service.pas',
  ucadproduto in 'src\presentation\forms\produtos\ucadproduto.pas' {FrmCadProduto},
  PedidoModel in 'src\domain\models\PedidoModel.pas',
  PedidoItemRepository in 'src\infrastructure\persistence\repositories\PedidoItemRepository.pas',
  IPedidoItem.Repository in 'src\domain\repositories\IPedidoItem.Repository.pas',
  PedidoItemAppService in 'src\application\services\PedidoItemAppService.pas',
  PedidoItemModel in 'src\domain\models\PedidoItemModel.pas',
  PedidoItemDTO in 'src\application\dtos\PedidoItemDTO.pas',
  PedidoItemValueObject in 'src\domain\valueobjects\PedidoItemValueObject.pas',
  PedidoItemExceptions in 'src\domain\exceptions\PedidoItemExceptions.pas',
  PedidoService in 'src\infrastructure\persistence\services\PedidoService.pas',
  IPedido.Service in 'src\domain\services\IPedido.Service.pas',
  PedidoRepository in 'src\infrastructure\persistence\repositories\PedidoRepository.pas',
  IPedido.Repository in 'src\domain\repositories\IPedido.Repository.pas',
  PedidoAppService in 'src\application\services\PedidoAppService.pas',
  PedidoDTO in 'src\application\dtos\PedidoDTO.pas',
  PedidoValueObject in 'src\domain\valueobjects\PedidoValueObject.pas',
  PedidoExceptions in 'src\domain\exceptions\PedidoExceptions.pas',
  upesqpedidos in 'src\presentation\forms\pedidos\upesqpedidos.pas' {FrmPesquisaPedidos},
  ucadpedido in 'src\presentation\forms\pedidos\ucadpedido.pas' {FrmCadPedido},
  umostrapedido in 'src\presentation\forms\pedidos\umostrapedido.pas' {FrmMostraPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

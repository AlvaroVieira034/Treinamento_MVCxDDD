unit PedidoAppService;

interface

uses PedidoModel, PedidoService, IPedido.Service, PedidoRepository, IPedido.Repository,
     system.SysUtils, Vcl.Forms, FireDAC.Comp.Client;

type
  TPedidoAppService = class

  private
    FPedido: TPedido;
    FPedidoRepository: TPedidoRepository;
    FPedidoService: TPedidoService;

  public
    constructor Create(APedidoRepository: IPedidoRepository; APedidoService: IPedidoService);
    destructor Destroy;

    procedure PreencherGridPedidos(TblPedidos: TFDQuery; APesquisa, ACampo: string);
    procedure PreencherGridRelatorio(TblPedidos: TFDQuery; ADataDe, ADataAte: string; AQuantidadeTop: Integer);
    function CarregarCampos(FPedido: TPedido; ACodigo: Integer): Boolean;
    function Inserir(APedido: TPedido): Boolean;
    function Alterar(APedido: TPedido; AId: Integer): Boolean;
    function Excluir(AId: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;

  end;

implementation

{ TPedidoController }

constructor TPedidoAppService.Create(APedidoRepository: IPedidoRepository; APedidoService: IPedidoService);
begin
  FPedido := TPedido.Create();
  FPedidoRepository := TPedidoRepository.Create();
  FPedidoService := TPedidoService.Create();
end;

destructor TPedidoAppService.Destroy;
begin
  FPedido.Free;
  FPedidoRepository.Free;
  FPedidoService.Free;

  inherited;
end;

procedure TPedidoAppService.PreencherGridPedidos(TblPedidos: TFDQuery; APesquisa, ACampo: string);
var LCampo, sErro: string;
begin
  try
    if ACampo = 'Data' then
      LCampo := 'ped.dta_pedido';

    if ACampo = 'Cliente' then
      LCampo := 'cli.des_razaosocial';

    if ACampo = '' then
      LCampo := 'ped.dta_pedido';

    FPedidoService.PreencherGridPedidos(TblPedidos, APesquisa, LCampo);
  except on E: Exception do
    begin
      sErro := 'Ocorreu um erro ao pesquisar o pedido!' + sLineBreak + E.Message;
      raise;
    end;
  end;
end;

procedure TPedidoAppService.PreencherGridRelatorio(TblPedidos: TFDQuery; ADataDe, ADataAte: string; AQuantidadeTop: Integer);
var LCampo, sErro: string;
begin
  try
    FPedidoService.PreencherGridRelatorio(TblPedidos, ADataDe, ADataAte, AQuantidadeTop);
  except on E: Exception do
    begin
      sErro := 'Ocorreu um erro ao pesquisar o pedido!' + sLineBreak + E.Message;
      raise;
    end;
  end;
end;

function TPedidoAppService.CarregarCampos(FPedido: TPedido; ACodigo: Integer): Boolean;
var sErro: string;
begin
  try
    FPedidoService.PreencherCamposForm(FPedido, ACodigo);
    Result := True;
  except on E: Exception do
    begin
      sErro := 'Ocorreu um erro ao carregar o pedido!' + sLineBreak + E.Message;
      Result := False;
      raise;
    end;
  end;
end;

function TPedidoAppService.Inserir(APedido: TPedido): Boolean;
begin
  Result := FPedidoRepository.Inserir(APedido);
end;

function TPedidoAppService.Alterar(APedido: TPedido; AId: Integer): Boolean;
begin
  Result := FPedidoRepository.Alterar(APedido, AId);
end;

function TPedidoAppService.Excluir(AId: Integer): Boolean;
begin
  Result := FPedidoRepository.Excluir(AId);
end;

function TPedidoAppService.ExecutarTransacao(AOperacao: TProc): Boolean;
begin
  Result := FPedidoRepository.ExecutarTransacao(AOperacao);
end;

end.

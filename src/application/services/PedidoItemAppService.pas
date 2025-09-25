unit PedidoItemAppService;

interface

uses PedidoItemModel, PedidoItemRepository, system.SysUtils, Vcl.Forms, FireDAC.Comp.Client,
     System.Generics.Collections;

type
  TCampoInvalido = (ciData, ciDescricao, ciCliente, ciValor, ciValorZero);
  TPedidoItemAppService = class

  private
    FPedidoItem: TPedidoItem;
    FPedidoItemRepository: TPedidoItemRepository;
    AConnection: TFDConnection;

  public
    constructor Create();
    destructor Destroy; override;

    function CarregarItensPedido(ACodPedido: Integer): TList<TPedidoItem>;
    function Inserir(APedidoItem: TPedidoItem): Boolean;
    function Excluir(ACodigo: Integer): Boolean;

  end;

implementation

{ TPedidoItensController }

constructor TPedidoItemAppService.Create;
begin
  FPedidoItem := TPedidoItem.Create;
  FPedidoItemRepository := TPedidoItemRepository.Create(AConnection);
end;

destructor TPedidoItemAppService.Destroy;
begin
  FPedidoItem.Free;
  FPedidoItemRepository.Free;
  inherited;
end;

function TPedidoItemAppService.CarregarItensPedido(ACodPedido: Integer): TList<TPedidoItem>;
begin
  Result := FPedidoItemRepository.CarregarItensPedido(ACodPedido);
end;

function TPedidoItemAppService.Inserir(APedidoItem: TPedidoItem): Boolean;
begin
  Result := FPedidoItemRepository.Inserir(APedidoItem);
end;

function TPedidoItemAppService.Excluir(ACodigo: Integer): Boolean;
begin
  Result := FPedidoItemRepository.Excluir(ACodigo);
end;

end.

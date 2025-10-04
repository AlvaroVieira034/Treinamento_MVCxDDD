unit PedidoRepository;

interface

uses
  PedidoModel, Conexao, IPedido.Repository, PedidoDTO, PedidoExceptions, System.SysUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)

  private
    QryPedidos: TFDQuery;
    Transacao: TFDTransaction;

    // Constantes SQL
    const
      SQL_INSERT =
        'insert into tab_pedido(dta_pedido, cod_cliente, val_pedido) ' +
        'values (:dta_pedido, :cod_cliente, :val_pedido)';

      SQL_UPDATE =
        'update tab_pedido set ' +
        'dta_pedido = :dta_pedido, ' +
        'cod_cliente = :cod_cliente, ' +
        'val_pedido = :val_pedido ' +
        'where cod_pedido = :cod_pedido';

  public
    constructor Create;
    destructor Destroy; override;

    function Inserir(FPedido: TPedido): Boolean;
    function Alterar(APedido: TPedido; AId: Integer): Boolean;
    function Excluir(AId: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;
    procedure CriarTabelas;

  end;

implementation

constructor TPedidoRepository.Create;
begin
  inherited Create;
  CriarTabelas();
end;

destructor TPedidoRepository.Destroy;
begin
  QryPedidos.Free;

  inherited Destroy;
end;

function TPedidoRepository.Inserir(FPedido: TPedido): Boolean;
var DTO: TPedidoDTO;
begin
  DTO := TPedidoDTO.FromEntity(FPedido);
  try
    Result := ExecutarTransacao(
      procedure
      begin
        with QryPedidos do
        begin
          Close;
          SQL.Clear;
          SQL.Text := SQL_INSERT;
          DTO.MapearParaQuery(QryPedidos);
          ExecSQL;

          QryPedidos.Close;
          QryPedidos.SQL.Text := 'select max(cod_pedido) as ultimoid from tab_pedido ';
          QryPedidos.Open;
          FPedido.Cod_Pedido := QryPedidos.FieldByName('ULTIMOID').AsInteger;
        end;
      end);
  finally
    DTO.Free;
  end;
end;

function TPedidoRepository.Alterar(APedido: TPedido; AId: Integer): Boolean;
var DTO: TPedidoDTO;
begin
  DTO := TPedidoDTO.FromEntity(APedido);
  try
    Result := ExecutarTransacao(
      procedure
      begin
        with QryPedidos do
        begin
          Close;
          SQL.Clear;
          SQL.Text := SQL_UPDATE;
          DTO.MapearParaQuery(QryPedidos);
          ParamByName('COD_PEDIDO').AsInteger := AId;
          ExecSQL;
        end;
      end);
  finally
    DTO.Free;
  end;
end;

function TPedidoRepository.Excluir(AId: Integer): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryPedidos do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'delete from tab_pedido where cod_pedido = :cod_pedido';
        ParamByName('COD_PEDIDO').AsInteger := AId;
        ExecSQL;
      end;
    end);
end;

function TPedidoRepository.ExecutarTransacao(AOperacao: TProc): Boolean;
begin
  Result := False;
  if not Transacao.Connection.Connected then
    Transacao.Connection.Open();

  Transacao.StartTransaction;
  try
    AOperacao;
    Transacao.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      Transacao.Rollback;
      raise Exception.Create('Ocorreu um erro na transação do pedido! Erro: ' + E.Message);
    end;
  end;
end;

procedure TPedidoRepository.CriarTabelas;
begin
  QryPedidos := TConexao.GetInstance.Connection.CriarQuery;
  Transacao := TConexao.GetInstance.Connection.CriarTransaction;
  QryPedidos.Transaction := Transacao;
end;

end.

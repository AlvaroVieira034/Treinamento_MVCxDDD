unit PedidoItemRepository;

interface

uses
  PedidoItemModel, PedidoItemDTO, IPedidoItem.Repository, Conexao, System.SysUtils, FireDAC.Comp.Client,
  FireDAC.Stan.Param, System.Classes, System.Generics.Collections, Data.DB;

type
  TPedidoItemRepository = class(TInterfacedObject, IPedidoItemRepository)

  private
    QryPedidoItem: TFDQuery;
    TransacaoItens: TFDTransaction;
    //Conexao: TConexao;
    //FConexao: TFDConnection;

    // Constantes SQL
    const
      SQL_INSERT =
        'insert into tab_pedido_item(' +
        'cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) ' +
        'values (' +
        ':cod_pedido, :cod_produto, :val_quantidade, :val_precounitario, :val_totalitem) ';

      SQL_SELECT =
        'select vdi.id_pedido, vdi.cod_pedido, vdi.cod_produto, prd.des_descricao as descricao, ' +
        'vdi.val_quantidade, vdi.val_precounitario, vdi.val_totalitem from tab_pedido_item vdi ' +
        'join tab_produto prd on vdi.cod_produto = prd.cod_produto ' +
        'where vdi.cod_pedido = :cod_pedido order by vdi.id_pedido ';

  public
    constructor Create;
    destructor Destroy; override;
    function CarregarItensPedido(ACodPedido: Integer): TList<TPedidoItem>;
    function Inserir(APedidoItem: TPedidoItem): Boolean;
    function Excluir(ACodigo: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;
    procedure CriarTabelas;

  end;

implementation

{ TPedidosItensRepository }

constructor TPedidoItemRepository.Create;
begin
  CriarTabelas()
end;

destructor TPedidoItemRepository.Destroy;
begin

  inherited;
end;

function TPedidoItemRepository.CarregarItensPedido(ACodPedido: Integer): TList<TPedidoItem>;
var Item: TPedidoItem;
begin
  Result := TList<TPedidoItem>.Create;
  with QryPedidoItem do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select vdi.id_Pedido, ');
    SQL.Add('vdi.cod_Pedido, ');
    SQL.Add('vdi.cod_produto, ');
    SQL.Add('prd.des_descricao as descricao, ');
    SQL.Add('vdi.val_quantidade,');
    SQL.Add('vdi.val_precounitario, ');
    SQL.Add('vdi.val_totalitem');
    SQL.Add('from tab_pedido_item vdi');
    SQL.Add('join tab_produto prd on vdi.cod_produto = prd.cod_produto');
    SQL.Add('where vdi.cod_pedido = :cod_pedido');
    SQL.Add('order by vdi.id_Pedido');
    ParamByName('COD_PEDIDO').AsInteger := ACodPedido;
    Open;
  end;

  while not QryPedidoItem.Eof do
  begin
    Item := TPedidoItem.Create;
    Item.Id_Pedido := QryPedidoItem.FieldByName('ID_Pedido').AsInteger;
    Item.Cod_Pedido := QryPedidoItem.FieldByName('COD_Pedido').AsInteger;
    Item.Cod_Produto := QryPedidoItem.FieldByName('COD_PRODUTO').AsInteger;
    Item.Des_Descricao := QryPedidoItem.FieldByName('DESCRICAO').AsString;
    Item.Val_Quantidade := QryPedidoItem.FieldByName('VAL_QUANTIDADE').AsInteger;
    Item.Val_PrecoUnitario := QryPedidoItem.FieldByName('VAL_PRECOUNITARIO').AsFloat;
    Item.Val_TotalItem := QryPedidoItem.FieldByName('VAL_TOTALITEM').AsFloat;
    Result.Add(Item);
    QryPedidoItem.Next;
  end;
  QryPedidoItem.Close;
end;

function TPedidoItemRepository.Inserir(APedidoItem: TPedidoItem): Boolean;
var DTO: TPedidoItemDTO;
begin
  DTO := TPedidoItemDTO.FromEntity(APedidoItem);
  try
    Result := ExecutarTransacao(
      procedure
      begin
        with QryPedidoItem do
        begin
          Close;
          SQL.Clear;
          SQL.Text := SQL_INSERT;
          DTO.MapearParaQuery(QryPedidoItem);
          ExecSQL;
        end;
      end);
  finally
    DTO.Free
  end;
end;

function TPedidoItemRepository.Excluir(ACodigo: Integer): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryPedidoItem do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'delete from tab_pedido_item where cod_pedido = :cod_pedido';
        ParamByName('COD_Pedido').AsInteger := ACodigo;

        ExecSQL;
      end;
    end);
end;

function TPedidoItemRepository.ExecutarTransacao(AOperacao: TProc): Boolean;
begin
  Result := False;
  if not TransacaoItens.Connection.Connected then
    TransacaoItens.Connection.Open();

  TransacaoItens.StartTransaction;
  try
    AOperacao;
    TransacaoItens.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      TransacaoItens.Rollback;
      raise Exception.Create('Ocorreu um erro na transação do item do pedido! Erro: ' + E.Message);
    end;
  end;
end;

procedure TPedidoItemRepository.CriarTabelas;
begin
  QryPedidoItem := TConexao.GetInstance.Connection.CriarQuery();
  TransacaoItens := TConexao.GetInstance.Connection.CriarTransaction();
  QryPedidoItem.Transaction := TransacaoItens;
end;

end.

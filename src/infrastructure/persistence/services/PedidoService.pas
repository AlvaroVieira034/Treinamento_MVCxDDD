unit PedidoService;

interface

uses
  PedidoModel, Conexao, IPedido.Service, PedidoExceptions, PedidoDTO, System.SysUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TPedidoService = class(TInterfacedObject, IPedidoService)

  private
    TblPedidos: TFDQuery;
    QryTemp: TFDQuery;
    DsPedidos: TDataSource;
    //Conexao: TConexao;
    //FConexao: TFDConnection;

    const
      SQL_SELECT =
        'select ped.cod_pedido, ped.dta_pedido, ped.cod_cliente, cli.des_nomefantasia as nomecliente, ped.val_pedido ' + #13 +
        'from tab_pedido ped ' + #13 +
        'join tab_cliente cli on ped.cod_cliente = cli.cod_cliente';

  public
    constructor Create;
    destructor Destroy; override;

    // Metodos de Acesso a banco de dados -> View
    procedure PreencherGridPedidos(TblPedidos: TFDQuery; APesquisa, ACampo: string);
    procedure PreencherCamposForm(APedido: TPedido; AId: Integer);
    procedure PreencherGridRelatorio(TblPedidos: TFDQuery; ADataDe, ADataAte: string; AQuantidadeTop: Integer);
    procedure ExibirResumoPedido(CodPedido: Integer);
    procedure SetParamDateOrNull(const ParamName, DateValue: string);
    function BuscarPedidoPorCodigo(AId: Integer): TPedido;

    // Metódos de Validação
    procedure ValidarPedido(APedido: TPedido);

    // Metodos de criação de DataSets
    procedure CriarTabelas;
    function GetDataSource: TDataSource;

  end;

implementation

{ TPedidoService }

constructor TPedidoService.Create;
begin
  CriarTabelas();
end;

destructor TPedidoService.Destroy;
begin
  TblPedidos.Free;
  QryTemp.Free;
  DsPedidos.Free;

  inherited;
end;

procedure TPedidoService.PreencherGridPedidos(TblPedidos: TFDQuery; APesquisa, ACampo: string);
begin
  with TblPedidos do
  begin
    Close;
    SQL.Clear;
    SQL.Text := SQL_SELECT;
    SQL.Add('where ' + ACampo + ' like :pNOME');
    if ACampo = 'cli.des_nomefantasia' then
      SQL.Add('order by ' + ACampo )
    else
      SQL.Add('order by ' + ACampo + ' desc');

    ParamByName('PNOME').AsString := APesquisa;
    Prepared := True;
    Open();
  end;
end;

procedure TPedidoService.PreencherCamposForm(APedido: TPedido; AId: Integer);
var DTO: TPedidoDTO;
begin
  with TblPedidos do
  begin
    Close;
    SQL.Clear;
    SQL.Text := SQL_SELECT;
    SQL.Add('where cod_pedido = :cod_pedido');
    ParamByName('cod_pedido').AsInteger := AId;
    Open;

    if not IsEmpty then
    begin
      DTO := TPedidoDTO.FromDataset(TblPedidos);
      try
        DTO.ToEntity(APedido);
      finally
        DTO.Free;
      end;
    end
    else
      raise Exception.Create('Pedido não encontrado com ID: ' + IntToStr(AId));

  end;
end;

procedure TPedidoService.PreencherGridRelatorio(TblPedidos: TFDQuery; ADataDe, ADataAte: string; AQuantidadeTop: Integer);
var DataDe, DataAte: TDate;
begin
  with TblPedidos do
  begin
    if ADataDe = '' then
      DataDe := StrToDate('30/12/1899')
    else
      DataDe := StrToDate(ADataDe);

    if ADataAte = '' then
      DataAte := StrToDate('30/12/2599')
    else
      DataAte := StrToDate(ADataAte);

    Close;
    SQL.Clear;
    SQL.Add('SELECT TOP (');
    SQL.Add(':QuantidadeTop) ');
    SQL.Add('p.cod_produto, ');
    SQL.Add('pr.des_descricao, ');
    SQL.Add('pr.des_marca, ');
    SQL.Add('SUM(p.val_quantidade) AS QuantidadeVendida, ');
    SQL.Add('SUM(p.val_totalitem)  AS ValorTotalVendido ' );
    SQL.Add('FROM tab_pedido_item p ');
    SQL.Add('JOIN tab_pedido ped ON p.cod_pedido = ped.cod_pedido ');
    SQL.Add('JOIN tab_produto pr ON p.cod_produto = pr.cod_produto ');
    SQL.Add('WHERE (:DataInicio IS NULL OR ped.dta_pedido >= :DataInicio) ');
    SQL.Add('AND (:DataFim IS NULL OR ped.dta_pedido <= :DataFim) ');
    SQL.Add('GROUP BY p.cod_produto, pr.des_descricao, pr.des_marca ');
    SQL.Add('ORDER BY SUM(p.val_quantidade) DESC');

    ParamByName('DATAINICIO').AsDate := DataDe;
    ParamByName('DATAFIM').AsDate := DataAte;
    ParamByName('QUANTIDADETOP').AsInteger := AQuantidadeTop;

    Prepared := True;
    Open;
  end;
end;

procedure TPedidoService.ExibirResumoPedido(CodPedido: Integer);
begin

end;

procedure TPedidoService.SetParamDateOrNull(const ParamName, DateValue: string);
begin
  if Trim(DateValue) = '' then
      TblPedidos.ParamByName(ParamName).Clear   // envia NULL
    else
      TblPedidos.ParamByName(ParamName).AsDate := StrToDate(DateValue);
end;

function TPedidoService.BuscarPedidoPorCodigo(AId: Integer): TPedido;
var Query: TFDQuery;
    DTO: TPedidoDTO;
begin
  Result := TPedido.Create;
  try
    Query := TConexao.GetInstance.Connection.CriarQuery();
    try
      with Query do
      begin
        Close;
        SQL.Clear;
        SQL.Text := SQL_SELECT;
        SQL.Add('where cod_pedido = :cod_pedido');
        ParamByName('COD_PEDIDO').AsInteger := AId;
        Open;

        if not IsEmpty then
        begin
          DTO := TPedidoDTO.FromDataset(Query);
          try
            DTO.ToEntity(Result);
          finally
            DTO.Free;
          end;
        end
        else
          raise Exception.Create('Pedido não encontrado!');
      end;
    finally
      Query.Free;
    end;
  except
    Result.Free;
    raise;
  end;

end;

procedure TPedidoService.ValidarPedido(APedido: TPedido);
begin
  APedido.Validar;
end;

procedure TPedidoService.CriarTabelas;
begin
  TblPedidos := TConexao.GetInstance.Connection.CriarQuery;
  QryTemp := TConexao.GetInstance.Connection.CriarQuery;
  DsPedidos := TConexao.GetInstance.Connection.CriarDataSource;
  DsPedidos.DataSet := TblPedidos;
end;

function TPedidoService.GetDataSource: TDataSource;
begin
  Result := DsPedidos;
end;


end.

unit PedidoService;

interface

uses
  PedidoModel, ConexaoAdapter, IPedido.Service, PedidoExceptions, PedidoDTO, System.SysUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TPedidoService = class(TInterfacedObject, IPedidoService)

  private
    TblPedidos: TFDQuery;
    QryTemp: TFDQuery;
    DsPedidos: TDataSource;
    Conexao: TConexao;
    FConexao: TFDConnection;

  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;

    // Metodos de Acesso a banco de dados -> View
    procedure PreencherGridPedidos(TblPedidos: TFDQuery; APesquisa, ACampo: string);
    procedure PreencherCamposForm(APedido: TPedido; AId: Integer);
    procedure PreencherGridRelatorio(ADataDe, ADataAte: string; CkRelatorio: Integer);
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

constructor TPedidoService.Create(AConnection: TFDConnection);
begin
  FConexao := AConnection;
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
    SQL.Add('select ped.cod_pedido, ');
    SQL.Add('ped.dta_pedido, ');
    SQL.Add('ped.cod_cliente, ');
    SQL.Add('cli.des_nomefantasia as nomecliente, ');
    SQL.Add('ped.val_pedido');
    SQL.Add('from tab_pedido ped');
    SQL.Add('join tab_cliente cli on ped.cod_cliente = cli.cod_cliente ');
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
    SQL.Add('select ped.cod_pedido,  ');
    SQL.Add('ped.dta_pedido, ');
    SQL.Add('ped.cod_cliente, ');
    SQL.Add('ped.val_pedido ');
    SQL.Add('from tab_pedido_ped');
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

procedure TPedidoService.PreencherGridRelatorio(ADataDe, ADataAte: string; CkRelatorio: Integer);
var DataDe, DataAte: TDate;
begin
  {with TblPedidos do
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
    SQL.Add('SELECT * FROM SP_PRODUTOSMAISVENDIDOS(:DataInicio, :DataFim, :MostrarTodos)');

    ParamByName('DataInicio').AsDate := DataDe;
    ParamByName('DataFim').AsDate := DataAte;
    ParamByName('MostrarTodos').AsInteger := CkRelatorio;

    Prepared := True;
    Open;
  end;}
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
    Query := Conexao.CriarQuery();
    try
      with Query do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select ped.cod_pedido,  ');
        SQL.Add('ped.dta_pedido, ');
        SQL.Add('ped.cod_cliente, ');
        SQL.Add('ped.val_pedido ');
        SQL.Add('from tab_pedido ped');
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
    // Validações básicas da entidade
  APedido.Validar;
end;

procedure TPedidoService.CriarTabelas;
begin
  TblPedidos := Conexao.CriarQuery;
  QryTemp := Conexao.CriarQuery;
  DsPedidos := Conexao.CriarDataSource;
  DsPedidos.DataSet := TblPedidos;
end;

function TPedidoService.GetDataSource: TDataSource;
begin
  Result := DsPedidos;
end;


end.

unit ICliente.Service;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Classes, ClienteModel, ClienteDTO,
  Data.DB, FireDAC.Comp.Client;

type
  IClienteService = interface
    ['{9EFCC396-E956-484A-B5F3-0328A109E66B}']

    // Métodos de Consulta
    procedure PreencheGridClientes(APesquisa, ACampo: string);
    procedure PreencherComboClientes(TblClientes: TFDQuery);
    procedure PreencherCamposForm(ACliente: TCliente; AId: Integer);
    procedure ValidarCliente(ACliente: TCliente);
    function BuscarClientePorCodigo(FCliente: TCliente; AId: Integer): TCliente;
    function ClientePodeSerExcluido(AClienteId: Integer): Boolean;

    // Metodos para criação de tabeas
    procedure CriarTabelas;
    function GetDataSource: TDataSource;

  end;

implementation


end.

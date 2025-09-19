unit ConexaoSingleton;

interface

uses
  DatabaseConnection, System.SysUtils;

type
  TConexaoSingleton = class

  private
    FDatabaseConnection: TDatabaseConnection;
    constructor Create;
    destructor Destroy; override;

  public
    property DatabaseConnection: TDatabaseConnection read FDatabaseConnection;
    class function GetInstance: TConexaoSingleton;

  end;

implementation

var
  InstanciaBD: TConexaoSingleton;

constructor TConexaoSingleton.Create;
begin
  inherited Create;
  FDatabaseConnection := TDatabaseConnection.Create;
end;

destructor TConexaoSingleton.Destroy;
begin
  FDatabaseConnection.Free;
  inherited;
end;

class function TConexaoSingleton.GetInstance: TConexaoSingleton;
begin
  if InstanciaBD = nil then
    InstanciaBD := TConexaoSingleton.Create;

  Result := InstanciaBD;
end;

initialization
  InstanciaBD := nil;

finalization
  if InstanciaBD <> nil then
    InstanciaBD.Free;

end.

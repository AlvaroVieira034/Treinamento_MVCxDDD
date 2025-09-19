unit ClienteAppService;

interface

uses
  ClienteModel, ICliente.Repository, ICliente.Service, ClienteRepository, ClienteService,
  ClienteDTO, ClienteExceptions, System.SysUtils, System.Generics.Collections, System.Classes,
  Data.DB, FireDAC.Comp.Client;

type
  IClienteAppService = interface
    ['{BCFF5BF5-B916-48EB-A803-007F2AF482C9}']
    procedure PreencheGridClientes(APesquisa, ACampo: string);
    procedure PreencherComboClientes(TblComboClientes: TFDQuery);
    function BuscarClientePorCodigo(AId: Integer): TCliente;
    function Inserir(ACliente: TCliente): Boolean;
    function Alterar(ACliente: TCliente; ACodigo: Integer): Boolean;
    function Excluir(ACodigo: Integer): Boolean;
    function ValidarCliente(ACliente: TCliente): Boolean;
    function GetDataSource: TDataSource;

  end;

  TClienteAppService = class(TInterfacedObject, IClienteAppService)
  private
    FClienteRepository: IClienteRepository;
    FClienteService: IClienteService;

    function EntityToDTO(ACliente: TCliente): TClienteDTO;
    function DTOToEntity(AClienteDTO: TClienteDTO): TCliente;

  public
    constructor Create(AClienteRepository: IClienteRepository; AClienteService: IClienteService);

    procedure PreencheGridClientes(APesquisa, ACampo: string);
    procedure PreencherComboClientes(TblComboClientes: TFDQuery);
    function BuscarClientePorCodigo(AId: Integer): TCliente;
    function Inserir(ACliente: TCliente): Boolean;
    function Alterar(ACliente: TCliente; ACodigo: Integer): Boolean;
    function Excluir(ACodigo: Integer): Boolean;
    function ValidarCliente(ACliente: TCliente): Boolean;
    function GetDataSource: TDataSource;
  end;

implementation

{ TClienteAppService }

constructor TClienteAppService.Create(AClienteRepository: IClienteRepository; AClienteService: IClienteService);
begin
  inherited Create;
  FClienteRepository := AClienteRepository;
  FClienteService := AClienteService;
end;

procedure TClienteAppService.PreencheGridClientes(APesquisa, ACampo: string);
begin
  // Implementação específica para preencher grid
  // Este método deveria ser movido para a camada de apresentação,
  // mas mantendo conforme solicitado
  FClienteService.PreencheGridClientes(APesquisa, ACampo);
end;

procedure TClienteAppService.PreencherComboClientes(TblComboClientes: TFDQuery);
begin
  // Implementação específica para preencher combo
  // Este método deveria ser movido para a camada de apresentação,
  // mas mantendo conforme solicitado
  FClienteService.PreencherComboClientes(TblComboClientes);
end;

function TClienteAppService.BuscarClientePorCodigo(AId: Integer): TCliente;
begin
  Result := FClienteService.BuscarClientePorCodigo(AId);
  if not Assigned(Result) then
    raise EClienteNaoEncontradoException.Create(AId);
end;

function TClienteAppService.Inserir(ACliente: TCliente): Boolean;
begin
  // Valida o cliente antes de inserir
  ValidarCliente(ACliente);

  // Insere no repositório
  Result := FClienteRepository.Inserir(ACliente);
end;

function TClienteAppService.Alterar(ACliente: TCliente; ACodigo: Integer): Boolean;
begin
  // Valida o cliente antes de alterar
  ValidarCliente(ACliente);

  // Atualiza no repositório
  Result := FClienteRepository.Alterar(ACliente, ACodigo);
end;

function TClienteAppService.Excluir(ACodigo: Integer): Boolean;
begin
  // Verifica se pode excluir (regras de negócio)
  if not FClienteService.ClientePodeSerExcluido(ACodigo) then
    raise EClienteNaoPodeSerExcluidoException.Create(ACodigo);

  Result := FClienteRepository.Excluir(ACodigo);
end;

function TClienteAppService.ValidarCliente(ACliente: TCliente): Boolean;
begin
  try
    // Delega a validação para o Domain Service
    FClienteService.ValidarCliente(ACliente);
    Result := True;
  except
    on E: EClienteException do
      raise; // Re-lança exceções de validação
    on E: ECNPJDuplicadoException do
      raise; // Re-lança exceções de negócio
    on E: Exception do
      raise EClienteException.Create('Erro inesperado na validação: ' + E.Message);
  end;
end;

function TClienteAppService.GetDataSource: TDataSource;
begin
  // Retorna o DataSource do serviço (para compatibilidade)
  // NOTA: Idealmente a UI trabalharia com DTOs, não diretamente com DataSource
  Result := FClienteService.GetDataSource();
end;

function TClienteAppService.EntityToDTO(ACliente: TCliente): TClienteDTO;
begin
  Result := TClienteDTO.Create;
  try
    Result.Cod_Ativo := ACliente.Cod_Ativo;
    Result.Cod_Cliente := ACliente.Cod_Cliente;
    Result.Des_RazaoSocial := ACliente.Des_RazaoSocial;
    Result.Des_NomeFantasia := ACliente.Des_NomeFantasia;
    Result.Des_Contato := ACliente.Des_Contato;
    Result.Des_Cep := ACliente.Des_Cep;
    Result.Des_Logradouro := ACliente.Des_Logradouro;
    Result.Des_Numero := ACliente.Des_Numero;
    Result.Des_Complemento := ACliente.Des_Complemento;
    Result.Des_Cidade := ACliente.Des_Cidade;
    Result.Des_UF := ACliente.Des_UF;
    Result.Des_Cnpj := ACliente.Des_Cnpj;
    Result.Des_Telefone := ACliente.Des_Telefone;
    Result.Des_Email := ACliente.Des_Email;
  except
    Result.Free;
    raise;
  end;
end;

function TClienteAppService.DTOToEntity(AClienteDTO: TClienteDTO): TCliente;
begin
  Result := TCliente.Create;
  Result.Cod_Ativo := AClienteDTO.Cod_Ativo;
  Result.Cod_Cliente := AClienteDTO.Cod_Cliente;
  Result.Des_RazaoSocial := AClienteDTO.Des_RazaoSocial;
  Result.Des_NomeFantasia := AClienteDTO.Des_NomeFantasia;
  Result.Des_Contato := AClienteDTO.Des_Contato;
  Result.Des_Cep := AClienteDTO.Des_Cep;
  Result.Des_Logradouro := AClienteDTO.Des_Logradouro;
  Result.Des_Numero := AClienteDTO.Des_Numero;
  Result.Des_Complemento := AClienteDTO.Des_Complemento;
  Result.Des_Cidade := AClienteDTO.Des_Cidade;
  Result.Des_UF := AClienteDTO.Des_UF;
  Result.Des_Cnpj := AClienteDTO.Des_Cnpj;
  Result.Des_Telefone := AClienteDTO.Des_Telefone;
  Result.Des_Email := AClienteDTO.Des_Email;
end;

end.

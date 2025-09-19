unit ClienteMapper;

interface

uses
  ClienteModel, ClienteDTO, Data.DB, System.SysUtils;

type
  TClienteMapper = class

  public
    class function EntityToDTO(ACliente: TCliente): TClienteDTO;
    class procedure DTOToEntity(AClienteDTO: TClienteDTO; var ACliente: TCliente);
    class function DatasetToDTO(ADataset: TDataSet): TClienteDTO;
    class function DatasetToEntity(ADataset: TDataSet): TCliente;

  end;

implementation

{ TClienteMapper }

class function TClienteMapper.EntityToDTO(ACliente: TCliente): TClienteDTO;
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

class procedure TClienteMapper.DTOToEntity(AClienteDTO: TClienteDTO; var ACliente: TCliente);
begin
  ACliente.Cod_Ativo := AClienteDTO.Cod_Ativo;
  ACliente.Cod_Cliente := AClienteDTO.Cod_Cliente;
  ACliente.Des_RazaoSocial := AClienteDTO.Des_RazaoSocial;
  ACliente.Des_NomeFantasia := AClienteDTO.Des_NomeFantasia;
  ACliente.Des_Contato := AClienteDTO.Des_Contato;
  ACliente.Des_Cep := AClienteDTO.Des_Cep;
  ACliente.Des_Logradouro := AClienteDTO.Des_Logradouro;
  ACliente.Des_Numero := AClienteDTO.Des_Numero;
  ACliente.Des_Complemento := AClienteDTO.Des_Complemento;
  ACliente.Des_Cidade := AClienteDTO.Des_Cidade;
  ACliente.Des_UF := AClienteDTO.Des_UF;
  ACliente.Des_Cnpj := AClienteDTO.Des_Cnpj;
  ACliente.Des_Telefone := AClienteDTO.Des_Telefone;
  ACliente.Des_Email := AClienteDTO.Des_Email;
end;

class function TClienteMapper.DatasetToDTO(ADataset: TDataSet): TClienteDTO;
begin
  Result := TClienteDTO.Create;
  try
    with ADataset do
    begin
      Result.Cod_Ativo := FieldByName('cod_ativo').AsInteger;
      Result.Cod_Cliente := FieldByName('cod_cliente').AsInteger;
      Result.Des_RazaoSocial := FieldByName('des_razaosocial').AsString;
      Result.Des_NomeFantasia := FieldByName('des_nomefantasia').AsString;
      Result.Des_Contato := FieldByName('des_contato').AsString;
      Result.Des_Cep := FieldByName('des_cep').AsString;
      Result.Des_Logradouro := FieldByName('des_logradouro').AsString;
      Result.Des_Numero := FieldByName('des_numero').AsString;
      Result.Des_Complemento := FieldByName('des_complemento').AsString;
      Result.Des_Cidade := FieldByName('des_cidade').AsString;
      Result.Des_UF := FieldByName('des_uf').AsString;
      Result.Des_Cnpj := FieldByName('des_cnpj').AsString;
      Result.Des_Telefone := FieldByName('des_telefone').AsString;
      Result.Des_Email := FieldByName('des_email').AsString;
    end;
  except
    Result.Free;
    raise;
  end;
end;

class function TClienteMapper.DatasetToEntity(ADataset: TDataSet): TCliente;
begin
  Result := TCliente.Create;
  try
    with ADataset do
    begin
      Result.Cod_Ativo := FieldByName('cod_ativo').AsInteger;
      Result.Cod_Cliente := FieldByName('cod_cliente').AsInteger;
      Result.Des_RazaoSocial := FieldByName('des_razaosocial').AsString;
      Result.Des_NomeFantasia := FieldByName('des_nomefantasia').AsString;
      Result.Des_Contato := FieldByName('des_contato').AsString;
      Result.Des_Cep := FieldByName('des_cep').AsString;
      Result.Des_Logradouro := FieldByName('des_logradouro').AsString;
      Result.Des_Numero := FieldByName('des_numero').AsString;
      Result.Des_Complemento := FieldByName('des_complemento').AsString;
      Result.Des_Cidade := FieldByName('des_cidade').AsString;
      Result.Des_UF := FieldByName('des_uf').AsString;
      Result.Des_Cnpj := FieldByName('des_cnpj').AsString;
      Result.Des_Telefone := FieldByName('des_telefone').AsString;
      Result.Des_Email := FieldByName('des_email').AsString;
    end;
  except
    Result.Free;
    raise;
  end;
end;


end.


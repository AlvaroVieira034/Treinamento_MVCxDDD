unit ClienteValidacoes;

interface

uses
  System.SysUtils, System.Generics.Collections, EnderecoValueObject, ContatoValueObject, DocumentoValueObject;
type
  EClienteValidationException = class(Exception);
  TClienteValidacoes = class

  public
     class procedure ValidarCliente(ADes_NomeFantasia, ADes_Cidade, ADes_UF, ADes_Cnpj,
      ADes_Telefone, ADes_Logradouro, ADes_Cep, ADes_Email: string; ADocumento: TDocumento;
      AContato: TContato; AEndereco: TEndereco);

    class function ObterErrosValidacao(ADes_NomeFantasia, ADes_Cidade, ADes_UF, ADes_Cnpj,
      ADes_Telefone, ADes_Logradouro, ADes_Cep, ADes_Email: string; ADocumento: TDocumento; AContato:
      TContato; AEndereco: TEndereco): TArray<string>;

  end;

implementation

{ TClienteValidacoes }

class procedure TClienteValidacoes.ValidarCliente(ADes_NomeFantasia, ADes_Cidade, ADes_UF,
  ADes_Cnpj, ADes_Telefone, ADes_Logradouro, ADes_Cep, ADes_Email: string; ADocumento: TDocumento;
  AContato: TContato; AEndereco: TEndereco);
var Erros: TArray<string>;
begin
  Erros := ObterErrosValidacao(ADes_NomeFantasia, ADes_Cidade, ADes_UF, ADes_Cnpj,
    ADes_Telefone, ADes_Logradouro, ADes_Cep, ADes_Email, ADocumento, AContato, AEndereco);

  if Length(Erros) > 0 then
    raise EClienteValidationException.Create('Dados inv�lidos: ' + string.Join('; ', Erros));
end;

class function TClienteValidacoes.ObterErrosValidacao(ADes_NomeFantasia, ADes_Cidade,
  ADes_UF, ADes_Cnpj, ADes_Telefone, ADes_Logradouro, ADes_Cep, ADes_Email: string;
  ADocumento: TDocumento; AContato: TContato; AEndereco: TEndereco): TArray<string>;
var Erros: TList<string>;
begin
  Erros := TList<string>.Create;
  try
    // Valida��es obrigat�rias
    if ADes_NomeFantasia.Trim = '' then
      Erros.Add('* Nome do cliente � obrigat�rio');

    if ADes_Cidade.Trim = '' then
      Erros.Add('* Cidade � obrigat�ria');

    if ADes_UF.Trim = '' then
      Erros.Add('* UF � obrigat�ria');

    if ADes_Cnpj.Trim = '' then
      Erros.Add('* CNPJ � obrigat�rio');

    // Valida��es de formato usando Value Objects
    if (ADes_Cnpj <> '') and not ADocumento.ValidarCNPJ then
      Erros.Add('* CNPJ inv�lido');

    if (ADes_Telefone <> '') and not AContato.ValidarTelefone then
      Erros.Add('* Telefone inv�lido');

    if (ADes_Email <> '') and not AContato.ValidarEmail then
      Erros.Add('* Email inv�lido');

    if (ADes_Cep <> '') and not AEndereco.ValidarCEP then
      Erros.Add('* CEP inv�lido');

    if (ADes_UF <> '') and not AEndereco.ValidarUF then
      Erros.Add('* UF inv�lida');

    // Valida��es de tamanho
    if (ADes_NomeFantasia <> '') and (Length(ADes_NomeFantasia) < 3) then
      Erros.Add('* Nome do cliente deve ter pelo menos 3 caracteres!');

    Result := Erros.ToArray;
  finally
    Erros.Free;
  end;
end;

end.

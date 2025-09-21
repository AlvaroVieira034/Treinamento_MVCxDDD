# Cadastro de Clientes, Produtos, Pedidos e Itens de Pedido

## Treinamento técnico Delphi DDD 

# 🚀 TreinamentoDDD

![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)
![License](https://img.shields.io/badge/license-MIT-green)
![Delphi](https://img.shields.io/badge/delphi-✓-blue)
![Conventional Commits](https://img.shields.io/badge/commits-conventional-ff69b4)

> 📝 Cadastro de clientes produtos e pedidos
Permite a inclusao de clientes, produtos e pedidos com seus respectivos itens. Permite a emissão de relatorios por periodo, bem como o agrupamento dos X mais itens vendidos.

---

## 📌 Índice
- [Sobre](#-sobre)
- [Tecnologias](#-tecnologias)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Instalação e Uso](#-instalação-e-uso)
- [Commits e Versionamento](#-commits-e-versionamento)
- [Roadmap](#-roadmap)
- [Screenshots](#-screenshots)
- [Autor](#-autor)
- [Licença](#-licença)

---

## 📖 Sobre
Este projeto é uma migração para DDD de uma aplicação Delphi, desenvolvida como forma de desafio técnico para o processo seletivo para uma vaga de programador Delphi. 
A aplicação permite a criação de cadastros de Clientes e Produtos, registra o movimento de pedidos, possibilitando a inclusão, alteração 
e exclusão de pedidos e seus respectivos itens,  além da pesquisas diversas e interativas, através de uma interface de pequisa, permitindo a navegação entre registros, exibindo ou atualizando os dados armazenados no banco de dados, além de emissão de relatórios de vendas.

---

## 🛠 Tecnologias
As principais ferramentas utilizadas neste projeto são:

- **Delphi 10.1 Berlin / RAD Studio**
- **MSSQL Server** (Banco de dados)
- **Firedac /  ClientDataSet**
- **API para consumo ViaCep** (para consultas de CEP)
- **Git & GitHub** (versionamento e controle de commits)
---


📋 Relatório de Migração para DDD - Módulo de Clientes
📝 Índice
1.	Visão Geral da Migração
2.	Nova Estrutura de Pastas e Classes
3.	Ganhos com a Migração para DDD
4.	Princípios SOLID Aplicados
5.	Clean Code Aplicado
6.	Clean Architecture Implementada
7.	DDD em Ação - Exemplos Práticos
8.	Benefícios das Mudanças
9.	Resultado Final
________________________________________
🎯 Visão Geral da Migração

Migramos de uma arquitetura MVC tradicional para Domain-Driven Design (DDD) com princípios SOLID e Clean Architecture, focando no módulo de clientes como piloto.
Objetivos principais:

- 	Separar claramente as responsabilidades
-   Proteger as regras de negócio
-	Melhorar a testabilidade
-	Facilitar a manutenção e evolução do sistema
________________________________________
🏗️ Nova Estrutura de Pastas e Classes

📁 Estrutura de Pastas:

    |domain/                              # Camada de Domínio
    |   |── exceptions/                   # Excessões da classe
    |   |── models/                       # Objetos de valor
    |   |── repositories/                 # Interfaces dos repósitorios
    |   |── services/                     # Interfaces de serviços
    |   |── valueobjects/                 # Objetos de Valor
    |   └── Exceptions/                   # Excessões de domínio
    │── Infrastructure/                   # Camada de Infraestrutura
    |   |── persistence/                  # Implementação de persistência
    |   |── services/                     # Implementação dos repositórios
    |   └── Mapping/                      # Mapeamento Objeto-Relacional
    |── Application/                      # Camada de aplicação
    |   |── mappers/                      # Casos de uso
    |   |── DTOs/                         # Objetos de transferência de dados
    |   └── Services/                     # Serviços da aplicação
    |── Presentation/                     # Camada de Apresentação
    |   |── forms/                        # Formulários
    |   └── Controllers/                  # Controladores
    |── shared/                           # Camada Compartilhada
    |   |── constants/                    # 
    |   |── types/                        # 
    |   └── Utils/                        # Rotinas de formatações e validações
    └── CrossCutting                      # Concerns Transversais
        |── IoC/                          # Inversão de controle
        └── Logging/                      # Logging



📋 Principais Classes:
| Classe             | Responsabilidade                          | Camada          |
|---------------------|-------------------------------------------|-----------------|
| **TCliente**        | Entidade principal com regras de negócio  | Domain          |
| **TEndereco**       | Value Object para dados de endereço       | Domain          |
| **TContato**        | Value Object para dados de contato        | Domain          |
| **TDocumento**      | Value Object para dados documentais       | Domain          |
| **TClienteDTO**     | Transferência de dados entre camadas      | Application     |
| **TClienteService** | Coordenação e regras de aplicação         | Application     |
| **TClienteRepository** | Persistência e acesso a dados          | Infrastructure  |
| **TValidadores**    | Validações reutilizáveis                  | Application     |
________________________________________
## 🚀 Ganhos com a Migração para DDD

✅ 1. Separação Clara de Responsabilidades  
Antes: Lógica misturada nas Forms  
Depois: Cada classe com responsabilidade única 


✅ 2. Manutenibilidade Melhorada
![alt text](image.png)
✅ 3. Testabilidade
![alt text](image-1.png)
✅ 4. Reusabilidade de Código
pascal
// Validações centralizadas e reutilizáveis
if TValidadores.ValidarCNPJ(CNPJ) then
  // Processa válido
else
  // Trata inválido
________________________________________
🧩 Princípios SOLID Aplicados
1. ✅ Single Responsibility Principle
pascal
// ANTES: Form fazia tudo
// DEPOIS: Cada classe com uma responsabilidade
TClienteValidator.ValidarCNPJ;       // Apenas validação
TClienteRepository.Inserir;          // Apenas persistência  
TClienteService.ProcessarCadastro;   // Apenas coordenação
2. ✅ Open/Closed Principle
pascal
// Fácil extensão para novos Value Objects
type
  TCliente = class
    property Endereco: TEndereco;
    property Contato: TContato;
    property Documento: TDocumento;
    // Pode adicionar novos VOs sem modificar a entity
  end;
3. ✅ Liskov Substitution Principle
pascal
// Value Objects são substituíveis
procedure ProcessarEndereco(Endereco: TEndereco);
begin
  // Funciona com qualquer especialização de TEndereco
end;
4. ✅ Interface Segregation Principle
pascal
type
  IClienteRepository = interface
    ['{GUID}']
    function Inserir(ACliente: TCliente): Boolean;
    function BuscarPorId(AId: Integer): TCliente;
    // Interfaces específicas e lean
  end;
5. ✅ Dependency Inversion Principle
pascal
// Forms dependem de abstrações
type
  TFrmCadCliente = class(TForm)
  private
    FClienteService: IClienteService; // Abstração, não implementação
  end;
________________________________________
🧹 Clean Code Aplicado
✅ Nomenclatura Expressiva
pascal
// ANTES:
procedure Processar;

// DEPOIS:  
procedure ValidarClienteCompleto;
✅ Funções Pequenas e Específicas
pascal
// Métodos com 5-10 linhas máximo
function TCliente.ObterErrosValidacao: TArray<string>;
begin
  Result := [];
  Result := Result + ValidarNome;
  Result := Result + ValidarDocumento;
  Result := Result + FEndereco.Validar;
end;
✅ Prevenção de Duplicação
pascal
// Validações centralizadas
class function TValidadores.ValidarCNPJ(const ACNPJ: string): Boolean;
begin
  // Usado em múltiplas classes
end;
✅ Código Auto-documentado
pascal
// Nomes claros que explicam a intenção
if Cliente.PodeSerExcluido then
  // instead of if CheckDeleteCondition then
________________________________________
🏛️ Clean Architecture Implementada
✅ Independência de Framework
pascal
// Domain não conhece FireDAC ou VCL
TCliente = class
  // Lógica pura de negócio - ZERO dependências de UI ou DB
end;
✅ Camadas Bem Definidas
text
Presentation → Application → Domain ← Infrastructure
✅ Fluxo de Dados Controlado
pascal
// Form → DTO → Entity → Repository
DTO := TClienteDTO.FromEntity(Cliente);
Cliente := TCliente.Create;
DTO.ToEntity(Cliente);
Repository.Inserir(Cliente);
✅ Inversão de Dependências
pascal
// Domain não depende de Infrastructure
type
  IClienteRepository = interface
    function Inserir(ACliente: TCliente): Boolean;
    // Domain define a interface, Infrastructure implementa
  end;
________________________________________
🎯 DDD em Ação - Exemplos Práticos
1. ✅ Linguagem Ubíqua
pascal
// Termos do domínio refletidos no código
Cliente.Ativar;           // instead of SetStatus(1)
Cliente.Validar;          // domain-specific validation
Cliente.Endereco.CEP;     // value object with business meaning
2. ✅ Agregações Claras
pascal
// Cliente como raiz de agregação
TCliente = class
  property Endereco: TEndereco;    // VO composto
  property Documento: TDocumento;  // VO composto  
  property Contato: TContato;      // VO composto
end;
3. ✅ Value Objects com Comportamento
pascal
// VOs não são apenas DTOs - têm comportamento
TEndereco = class
  procedure Validar;
  function EstaVazio: Boolean;
  function ToString: string;
end;
4. ✅ Entidades com Identidade
pascal
// Cliente possui identidade única
if Cliente1.Equals(Cliente2) then
  // Comparação por identidade
5. ✅ Validações no Domínio
pascal
// Validações onde devem estar
procedure TCliente.Validar;
begin
  ValidarCamposObrigatorios;
  FEndereco.Validar;
  FDocumento.Validar;
  FContato.Validar;
end;
________________________________________
🚀 Benefícios das Mudanças
🛠️ Melhorias na Manutenibilidade
•	✅ Mudanças isoladas em uma classe
•	✅ Menor impacto em modificações
•	✅ Fácil localização de código
•	✅ Redução de bugs por acoplamento
🔧 Facilidade para Futuras Implementações
•	✅ Adicionar novo campo: apenas no DTO e Entity
•	✅ Nova validação: apenas no Value Object
•	✅ Novo relatório: usa DTO existente
•	✅ Múltiplos frontends: mesma camada de aplicação
📊 Organização e Clareza
•	✅ Código auto-documentado
•	✅ Estrutura previsível
•	✅ Onboarding mais rápido de novos devs
•	✅ Padrões consistentes em todo o projeto
🧪 Testabilidade Aprimorada
•	✅ Unit testing facilitado
•	✅ Mocking simplificado
•	✅ Testes de integração mais focados
•	✅ Cobertura de testes aumentada
⚡ Performance e Qualidade
•	✅ Menor acoplamento = menos bugs
•	✅ Código mais limpo = melhor performance
•	✅ Arquitetura sólida = menos technical debt
________________________________________
📈 Resultado Final
A migração transformou um código acoplado em uma arquitetura robusta onde:
1.	🔒 Regras de negócio estão protegidas no Domain
2.	🔄 Mudanças são isoladas e controladas
3.	🧪 Testes são viáveis e eficientes
4.	🚀 Novas features são implementadas rapidamente
5.	👥 Trabalho em equipe é facilitado
6.	📊 Qualidade do código é significativamente melhor
7.	🔮 Futuro do projeto é mais seguro e escalável
O DDD não é apenas uma arquitetura - é uma forma de pensar o domínio que resulta em software mais resiliente e adaptável às mudanças de negócio! 🎯
________________________________________
📋 Próximos Passos Recomendados
1.	Estender o padrão para outros módulos do sistema
2.	Implementar testes unitários abrangentes
3.	Documentar padrões para a equipe
4.	Criar templates para novas entidades
5.	Implementar CQRS para consultas complexas
6.	Adicionar logging estruturado
7.	Implementar cache na camada de aplicação


        
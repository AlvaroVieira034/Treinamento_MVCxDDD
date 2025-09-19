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

## 📂 Estrutura do Projeto

    |──Core/                              # Camada de Domínio
    |   |── Entities/                     # Entidades de negócio
    |   |── ValuesObject/                 # Objetos de valor
    |   |── Repositories/                 # Interfaces dos repósitorios
    |   |── Services/                     # Serviços do domínio
    |   |── Specifications/               # Especificações
    |   └── Exceptions/                   # Excessões de domínio
    │── Infrastructure/                   # Camada de Infraestrutura
    |   |── Persistence/                  # Implementação de persistência
    |   |── Repositories/                 # Implementação dos repositórios
    |   └── Mapping/                      # Mapeamento Objeto-Relacional
    |── Application/                      # Camada de aplicação
    |   |── UseCases/                     # Casos de uso
    |   |── DTOs/                         # Objetos de transferência de dados
    |   └── Services/                     # Serviços da aplicação
    |── Presentation/                     # Camada de Apresentação
    |   |── Views/                        # Formulários
    |   |── ViewModels/                   # ViewModels (para MVVM)
    |   └── Controllers/                  # Controladores (para MVC)
    └── CrossCutting                      # Concerns Transversais
        |── IoC/                          # Inversão de controle
        └── Logging/                      # Logging
        
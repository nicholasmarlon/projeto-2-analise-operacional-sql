# 🚛 FleetAnalytics — SQL para Inteligência Operacional e Logística de Frotas

![SQL](https://img.shields.io/badge/SQL-SQLite%20%2F%20PostgreSQL-blue?style=for-the-badge&logo=sqlite)
![Data Analytics](https://img.shields.io/badge/Focus-Data%20Analytics-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Conclu%C3%ADdo-brightgreen?style=for-the-badge)

Uma solução analítica em SQL projetada para transformar dados brutos de logística e transporte urbano em inteligência de negócios. O **FleetAnalytics** simula um ambiente de banco de dados relacional para monitorar a rentabilidade de frotas, comparar o desempenho entre plataformas (Uber, 99 e InDrive), avaliar taxas de cancelamento e calcular o retorno real sobre o investimento (ROI) de veículos após custos operacionais e manutenções.

---

## 📌 Contexto de Negócio & Desafios

No setor de transporte por aplicativo e gestão de frotas operacionais, a receita bruta não reflete o ganho real. Fatores como a oscilação do preço do combustível, custos de manutenção preventiva e corretiva, e cancelamentos não remunerados impactam diretamente a margem líquida.

### Perguntas de Negócio Respondidas:
1. **DRE Operacional por Motorista:** Qual é a margem líquida real de cada motorista após descontar os custos operacionais estimados por quilômetro rodado?
2. **Eficiência de Plataformas:** Qual plataforma de mobilidade apresenta a menor taxa de cancelamento e o melhor ticket médio?
3. **Ranking da Frota:** Quais veículos geram maior retorno financeiro por km utilizando funções de janela (`DENSE_RANK()`)?
4. **Balanço Manutenção vs. Faturamento:** O faturamento de cada veículo é suficiente para cobrir seus custos diretos de manutenção?

---

## 🛢️ Estrutura do Banco de Dados (Modelagem Relacional)

O banco de dados é composto por 4 tabelas principais totalmente relacionadas por chaves estrangeiras:

```text
 ┌────────────────┐          ┌──────────────────┐
 │   motoristas   │ 1      N │ corridas_entregas│
 ├────────────────┤──────────┼──────────────────┤
 │ id_motorista   │          │ id_corrida       │
 │ nome           │          │ id_motorista (FK)│
 │ status         │          │ id_veiculo (FK)  │
 └────────────────┘          │ plataforma       │
                             │ distancia_km     │
 ┌────────────────┐ 1      N │ valor_bruto      │
 │    veiculos    │──────────│ status_corrida   │
 ├────────────────┤          └──────────────────┘
 │ id_veiculo     │
 │ modelo / placa │          ┌────────────────────┐
 │ custo_est_km   │ 1      N │ manutencoes_custos │
 └────────────────┘──────────┼────────────────────┤
                             │ id_custo           │
                             │ id_veiculo (FK)    │
                             │ tipo_custo / valor │
                             └────────────────────┘
```

---

## 🛠️ Tecnologias & Conceitos Aplicados em SQL

* **DDL (Data Definition Language):** Criação de tabelas, chaves primárias (`PRIMARY KEY`), chaves estrangeiras (`FOREIGN KEY`) e restrições (`UNIQUE`, `NOT NULL`).
* **DML (Data Manipulation Language):** Povoamento e manipulação de registros operacionais.
* **CTEs (Common Table Expressions):** Modularização de cálculos intermediários para demonstrativos financeiros.
* **Window Functions:** Agregações avançadas com `DENSE_RANK() OVER (...)` para ranqueamento de veículos.
* **Agregações Condicionais:** Cálculo dinâmico de indicadores e percentuais utilizando `CASE WHEN`.
* **Junções Relacionais:** Combinação precisa entre tabelas usando `INNER JOIN` e `LEFT JOIN` com tratamento de nulos (`COALESCE`).

---

## 📂 Estrutura do Repositório

```text
├── schema.sql              # Estrutura DDL (Criação de tabelas e relacionamentos)
├── insert_dados.sql        # Carga DML (Massa de dados operacionais para testes)
├── queries_analytics.sql   # Consultas analíticas avançadas para tomada de decisão
└── README.md               # Documentação técnica e de negócio do projeto
```

---

## 🚀 Como Executar o Projeto

Este projeto foi desenvolvido de forma nativa e compatível com **SQLite** e **PostgreSQL**.

### Opção 1: Diretamente no VS Code (SQLite)
1. Instale a extensão **SQLite Viewer** ou **SQLite** no VS Code.
2. Abra o terminal e crie o banco de dados local:
   ```bash
   sqlite3 fleet_analytics.db < schema.sql
   sqlite3 fleet_analytics.db < insert_dados.sql
   ```
3. Execute as consultas contidas em `queries_analytics.sql`.

### Opção 2: Em qualquer SGDB (DBeaver, pgAdmin, MySQL Workbench)
1. Abra a sua ferramenta de escolha e conecte-se ao seu servidor de banco de dados.
2. Execute o conteúdo de `schema.sql` para construir as tabelas.
3. Execute `insert_dados.sql` para realizar a carga dos dados.
4. Rode os blocos de código em `queries_analytics.sql` para visualizar os relatórios e indicadores de negócio.

---

## 👨‍💻 Autor

Desenvolvido por **Nicholas Marlon**  
* [LinkedIn](https://www.linkedin.com/) | [GitHub](https://github.com/nicholasmarlon)
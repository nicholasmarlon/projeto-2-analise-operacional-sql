-- ============================================================
-- PROJETO: FleetAnalytics - Análise Operacional e Logística
-- ARQUIVO: schema.sql (Criação da Estrutura Relacional)
-- ============================================================

-- Remover tabelas antigas para reexecução limpa do script
DROP TABLE IF EXISTS manutencoes_custos;
DROP TABLE IF EXISTS corridas_entregas;
DROP TABLE IF EXISTS veiculos;
DROP TABLE IF EXISTS motoristas;

-- 1. Tabela de Motoristas
CREATE TABLE motoristas (
    id_motorista INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'Ativo', -- Ativo, Inativo, Suspenso
    data_cadastro DATE NOT NULL
);

-- 2. Tabela de Veículos
CREATE TABLE veiculos (
    id_veiculo INTEGER PRIMARY KEY AUTOINCREMENT,
    modelo VARCHAR(50) NOT NULL,
    ano INTEGER NOT NULL,
    placa VARCHAR(10) UNIQUE NOT NULL,
    custo_estimado_km DECIMAL(5,2) NOT NULL -- Custo estimado de depreciação/combustível por km
);

-- 3. Tabela de Corridas / Entregas
CREATE TABLE corridas_entregas (
    id_corrida INTEGER PRIMARY KEY AUTOINCREMENT,
    id_motorista INTEGER NOT NULL,
    id_veiculo INTEGER NOT NULL,
    plataforma VARCHAR(30) NOT NULL, -- Uber, 99, InDrive
    data_hora_inicio DATETIME NOT NULL,
    data_hora_fim DATETIME,
    distancia_km DECIMAL(6,2) NOT NULL,
    valor_bruto DECIMAL(8,2) NOT NULL,
    status_corrida VARCHAR(20) NOT NULL, -- Concluída, Cancelada_Motorista, Cancelada_Passageiro
    FOREIGN KEY (id_motorista) REFERENCES motoristas(id_motorista),
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo)
);

-- 4. Tabela de Manutenções e Custos Operacionais
CREATE TABLE manutencoes_custos (
    id_custo INTEGER PRIMARY KEY AUTOINCREMENT,
    id_veiculo INTEGER NOT NULL,
    tipo_custo VARCHAR(50) NOT NULL, -- Combustível, Óleo, Peças, Pneus, Seguro
    valor DECIMAL(8,2) NOT NULL,
    data_custo DATE NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo)
);
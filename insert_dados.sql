-- ============================================================
-- PROJETO: FleetAnalytics - Análise Operacional e Logística
-- ARQUIVO: insert_dados.sql (Povoamento da Base de Dados)
-- ============================================================

-- 1. Inserir Motoristas
INSERT INTO motoristas (nome, status, data_cadastro) VALUES
('Nicholas Souza', 'Ativo', '2024-01-15'),
('Carlos Eduardo', 'Ativo', '2024-02-01'),
('Mariana Lima', 'Ativo', '2024-03-10'),
('Lucas Mendes', 'Inativo', '2023-11-20');

-- 2. Inserir Veículos da Frota
INSERT INTO veiculos (modelo, ano, placa, custo_estimado_km) VALUES
('Volkswagen Gol G7 1.0', 2018, 'ABC1D23', 0.65),
('Chevrolet Onix 1.0', 2020, 'XYZ9K88', 0.60),
('Hyundai HB20 1.6', 2021, 'KDJ4M11', 0.72),
('Fiat Argo 1.0', 2019, 'JHG8L55', 0.63);

-- 3. Inserir Custos e Manutenções Operacionais
INSERT INTO manutencoes_custos (id_veiculo, tipo_custo, valor, data_custo) VALUES
(1, 'Troca de Óleo e Filtros', 250.00, '2026-03-01'),
(1, 'Manutenção Suspensão e Embreagem', 1200.00, '2026-03-05'),
(2, 'Abastecimento Combustível', 180.00, '2026-03-02'),
(2, 'Troca de Pneus', 800.00, '2026-03-06'),
(3, 'Abastecimento Combustível', 210.00, '2026-03-03'),
(4, 'Revisão Freios', 350.00, '2026-03-04');

-- 4. Inserir Corridas e Entregas
INSERT INTO corridas_entregas (id_motorista, id_veiculo, plataforma, data_hora_inicio, data_hora_fim, distancia_km, valor_bruto, status_corrida) VALUES
(1, 1, 'Uber', '2026-03-10 07:30:00', '2026-03-10 07:50:00', 12.5, 38.50, 'Concluída'),
(1, 1, '99', '2026-03-10 08:05:00', '2026-03-10 08:20:00', 8.0, 24.00, 'Concluída'),
(1, 1, 'Uber', '2026-03-10 08:30:00', NULL, 5.0, 15.00, 'Cancelada_Passageiro'),
(1, 1, 'InDrive', '2026-03-10 09:00:00', '2026-03-10 09:45:00', 25.0, 65.00, 'Concluída'),
(2, 2, 'Uber', '2026-03-10 07:15:00', '2026-03-10 07:35:00', 10.0, 30.00, 'Concluída'),
(2, 2, '99', '2026-03-10 07:50:00', NULL, 15.0, 42.00, 'Cancelada_Motorista'),
(2, 2, 'Uber', '2026-03-10 08:15:00', '2026-03-10 08:40:00', 14.2, 41.50, 'Concluída'),
(3, 3, 'InDrive', '2026-03-10 10:00:00', '2026-03-10 10:30:00', 18.0, 52.00, 'Concluída'),
(3, 3, 'Uber', '2026-03-10 11:00:00', '2026-03-10 11:15:00', 6.5, 20.00, 'Concluída'),
(3, 3, '99', '2026-03-10 11:30:00', NULL, 11.0, 31.00, 'Cancelada_Passageiro');
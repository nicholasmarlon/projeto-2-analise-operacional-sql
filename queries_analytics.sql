-- ============================================================
-- PROJETO: FleetAnalytics - Análise Operacional e Logística
-- ARQUIVO: queries_analytics.sql (Consultas Analíticas de Negócio)
-- ============================================================

-- ------------------------------------------------------------
-- QUERY 1: DRE Operacional por Motorista
-- Avalia a Receita Bruta, Custos Variáveis Estimados e Margem Líquida
-- ------------------------------------------------------------
WITH CustosCorrida AS (
    SELECT 
        c.id_corrida,
        c.id_motorista,
        m.nome AS motorista,
        c.plataforma,
        c.valor_bruto,
        c.distancia_km,
        (c.distancia_km * v.custo_estimado_km) AS custo_estimado_corrida
    FROM corridas_entregas c
    JOIN motoristas m ON c.id_motorista = m.id_motorista
    JOIN veiculos v ON c.id_veiculo = v.id_veiculo
    WHERE c.status_corrida = 'Concluída'
)
SELECT 
    motorista,
    COUNT(id_corrida) AS total_corridas,
    ROUND(SUM(distancia_km), 2) AS km_total,
    ROUND(SUM(valor_bruto), 2) AS receita_bruta,
    ROUND(SUM(custo_estimado_corrida), 2) AS custo_operacional_total,
    ROUND(SUM(valor_bruto - custo_estimado_corrida), 2) AS lucro_liquido_estimado,
    ROUND(AVG((valor_bruto - custo_estimado_corrida) / distancia_km), 2) AS margem_media_por_km
FROM CustosCorrida
GROUP BY motorista
ORDER BY lucro_liquido_estimado DESC;

-- ------------------------------------------------------------
-- QUERY 2: Análise de Desempenho por Plataforma (Uber, 99, InDrive)
-- Ticket médio, volume e taxa de cancelamento por plataforma
-- ------------------------------------------------------------
SELECT 
    plataforma,
    COUNT(id_corrida) AS total_solicitacoes,
    SUM(CASE WHEN status_corrida = 'Concluída' THEN 1 ELSE 0 END) AS corridas_concluidas,
    SUM(CASE WHEN status_corrida LIKE 'Cancelada%' THEN 1 ELSE 0 END) AS total_cancelamentos,
    ROUND(
        CAST(SUM(CASE WHEN status_corrida LIKE 'Cancelada%' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(id_corrida) * 100, 
        2
    ) AS taxa_cancelamento_pct,
    ROUND(AVG(CASE WHEN status_corrida = 'Concluída' THEN valor_bruto END), 2) AS ticket_medio
FROM corridas_entregas
GROUP BY plataforma
ORDER BY taxa_cancelamento_pct ASC;

-- ------------------------------------------------------------
-- QUERY 3: Ranking de Eficiência Financeira por Veículo (Window Function)
-- Compara o faturamento acumulado de cada carro em relação à frota
-- ------------------------------------------------------------
SELECT 
    v.modelo,
    v.placa,
    SUM(c.valor_bruto) AS faturamento_veiculo,
    ROUND(AVG(c.valor_bruto / c.distancia_km), 2) AS valor_medio_por_km,
    DENSE_RANK() OVER (ORDER BY SUM(c.valor_bruto) DESC) AS rank_faturamento
FROM corridas_entregas c
JOIN veiculos v ON c.id_veiculo = v.id_veiculo
WHERE c.status_corrida = 'Concluída'
GROUP BY v.modelo, v.placa;

-- ------------------------------------------------------------
-- QUERY 4: Balanço de Manutenção vs. Faturamento da Frota
-- Consolidação de custos de oficina/combustível e rentabilidade do veículo
-- ------------------------------------------------------------
SELECT 
    v.modelo,
    COALESCE(ROUND(SUM(DISTINCT c.valor_bruto), 2), 0) AS faturamento_total,
    COALESCE(ROUND(SUM(DISTINCT m.valor), 2), 0) AS custos_manutencao,
    ROUND(
        COALESCE(SUM(DISTINCT c.valor_bruto), 0) - COALESCE(SUM(DISTINCT m.valor), 0), 2
    ) AS resultado_operacional_liquido
FROM veiculos v
LEFT JOIN corridas_entregas c ON v.id_veiculo = c.id_veiculo AND c.status_corrida = 'Concluída'
LEFT JOIN manutencoes_custos m ON v.id_veiculo = m.id_veiculo
GROUP BY v.modelo;
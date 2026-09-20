import sqlite3
import pandas as pd

# 1. Criar banco de dados SQLite temporario/local
conn = sqlite3.connect('frota.db')

# 2. Ler e executar o schema.sql
with open('schema.sql', 'r', encoding='utf-8') as f:
    conn.executescript(f.read())

# 3. Ler e executar o insert_dados.sql
with open('insert_dados.sql', 'r', encoding='utf-8') as f:
    conn.executescript(f.read())

# 4. Exportar cada tabela para CSV
tabelas = ['motoristas', 'veiculos', 'corridas_entregas', 'manutencoes_custos']

for tabela in tabelas:
    df = pd.read_sql_query(f"SELECT * FROM {tabela}", conn)
    df.to_csv(f"{tabela}.csv", index=False, encoding='utf-8-sig')
    print(f"✅ Ficheiro {tabela}.csv gerado com sucesso!")

conn.close()
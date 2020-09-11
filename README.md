# gtfsfarroupilha-postgres

Plataforma dedicada à importação de dados GTFS da cidade de Farroupilha-RS no banco de dados POSTGRESQL.

#### Configurações

A única configuração necessária é criar o arqivo 'database.ini' em migration/scripts/database/ no seguinte padrão:

```bash
[postgresql]
host=localhost
database=gtfsfarroupilha
user= < usuario >
password= < senha > 
```

#### Utilização

Navegue até a pasta migration/scrips pela linha de comando e execute o arquivo migration.py


```python
python3 migration.py criar_tabelas

# Realiza a criação das tabelas e índices no banco, executando os comandos do arquivo migration/sql/create_tables (apaga todas e cria do zero)
```

```python
python3 migration.py importar_dados

# Gera os comandos INSERT tendo como base os dados em migration/data e executa no banco
```

```python
python3 migration.py limpar_base

# Exxclui todas as tabelas do banco e seus registros
```

```python
python3 migration.py migrar

# Executa em sequência os comandos 'criar_tabelas' e 'importar_dados'
```
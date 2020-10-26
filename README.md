# gtfs-farroupilha-postgres

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

Configurar a VENV

```python
# Executar na raiz do projeto
python3 -m venv venv

# Após, ativar a VENV
source venv/bin/activate
```

Depois disso, instale os reqiosotps do projeto:

```python
python3 -m pip install -r requirements.txt
```

Caso ocorram erros no Linux, você pode instalar as ferramentas conforme descritas [aqui](https://linuxnetmag.com/x86_64-linux-gnu-gcc-failed/)

#### Utilização

Navegue até a pasta src/scrips pela linha de comando e execute o arquivo migration.py

```python
python3 main.py migrar

# Executa em sequência os comandos 'criar_tabelas' e 'importar_dados'
```

```python
python3 main.py criar_tabelas

# Realiza a criação das tabelas e índices no banco, executando os comandos do arquivo src/sql/create_tables (apaga todas e cria do zero)
```

```python
python3 main.py importar_dados

# Gera os comandos INSERT tendo como base os dados em src/data e executa no banco
```

```python
python3 main.py limpar_base

# Exclui todas as tabelas do banco e seus registros
```

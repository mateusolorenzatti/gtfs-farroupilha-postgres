import sys
from database.database import query
from generators.import_generator import generate_import_file

comandos_validos = [
    'migrar', 
    'criar_tabelas', 
    'importar_dados', 
    'limpar_base'
]
    
def migrate():
    print("Migrando Dados ... ")

    create_tables()
    import_data()

def create_tables():
    print("Criando as Tabelas ... ")

    with open('../sql/create_tables.sql', 'r', encoding='utf-8') as f:
        content = f.read()

        query(content)
        f.close()
    

def import_data():
    print("Importando Dados ... ")

    generate_import_file()

    with open('../sql/import_data.sql', 'r', encoding='utf-8') as f:
        content = f.read()

        query(content)
        f.close()

def clear():
    print("Limpando Dados ... ")

    with open('../sql/clear_database.sql', 'r', encoding='utf-8') as f:
        content = f.read()

        query(content)
        f.close()
    
    

def main():

    try: 
        comando = sys.argv[1]
    except:
        comando = ""

    print("")
    
    if comando in comandos_validos:
        if comando == comandos_validos[0]: migrate()
        if comando == comandos_validos[1]: create_tables()
        if comando == comandos_validos[2]: import_data()
        if comando == comandos_validos[3]: clear()
        
    else:
        print('Comando Inválido! Tente alguns dos abaixo: (migration.py <comando>)')
        print('   > ' + ', \n   > '.join(comandos_validos))
    
    print("")

if __name__ == '__main__':
    main()

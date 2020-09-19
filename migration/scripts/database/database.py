''' 
Script para conexão ao Banco de Dados PostgreSQL

Adaptado de https://www.postgresqltutorial.com/postgresql-python/connect/

'''

import psycopg2
from .config import config

def query(comando_bruto):
    """ Connect to the PostgreSQL database server """
    comandos_lista = []

    conn = None
    try:
        # read connection parameters
        params = config()

        print()
        # connect to the PostgreSQL server
        print('Conectando na base de dados... ')
        conn = psycopg2.connect(**params)
		
        # create a cursor
        cur = conn.cursor()
            
        # execute a statement
        print('Retorno da consulta/operação: ')

        if ';' in comando_bruto:

            #  Analisar se temos o comando insert. Se não, remove os comentaríos (Não há comentários nos códigos gerados)
            if 'INSERT' not in comando_bruto:
                comandos_lista = [(c).replace('\n', '').replace('-', '') for c in comando_bruto.split(';') if c]

            # Nesse caso, não se remove o '-' pois afetará os números negativos de coordenadas
            else:
                comandos_lista = [(c).replace('\n', '') for c in comando_bruto.split(';') if c]

            if comandos_lista[-1] == '': comandos_lista.pop()
        else:    
            comandos_lista.append(comando_bruto)
    

        print("Execuntando {} comando(s)".format(len(comandos_lista)))

        for comando in comandos_lista:
            print("Rodando: " + comando)
            cur.execute(comando)
            conn.commit()

        # display the PostgreSQL database server version
        response = cur.fetchall()
        print(response)
        print()
       
	    # close the communication with the PostgreSQL
        cur.close()

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

    finally:
        if conn is not None:
            conn.close()
            print('Fechado a conexão com o banco.')

''' 
Script para ler o aquivo database.ini

Adaptado de https://www.postgresqltutorial.com/postgresql-python/connect/

'''

from configparser import ConfigParser
import pathlib

def config(section='postgresql'):

    filename = "{}/database.ini".format(pathlib.Path(__file__).parent.absolute())

    parser = ConfigParser()
    
    parser.read(filename)

    db = {}
    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            db[param[0]] = param[1]
    else:
        raise Exception('Section {0} not found in the {1} file'.format(section, filename))

    return db
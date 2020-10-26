import pathlib

gtfsFiles = [
    'agency.txt',
    'shapes.txt', #***
    'routes.txt', #***
    'stops.txt', #***
    'trips.txt', #***
    'stop_times.txt' #***
]

def fillNumericAttsList():
    numericAttsList = []
    fp = open('../sql/sql_preamble.sql')

    keyWords = [' int', ' decimal', ' tinyint']
    
    for line in fp.readlines():
        numericAtt = False
        for key in keyWords:
            if key in line.lower():
                numericAtt = True
        if numericAtt:
            att = line.split()[0]
            if att == 'direction':
                att = 'direction_id'
            numericAttsList.append(att)

    fp.close()
    return numericAttsList

def generate_import_file():
    gtfsFolder = '{}/../../data/'.format( pathlib.Path(__file__).parent.absolute() )

    dbName = 'gtfsfarroupilha'

    numericAttsList = fillNumericAttsList()

    out_file = open("../sql/import_data.sql","w+") 

    for file in gtfsFiles:
        fp = open(gtfsFolder+file, 'r')
        atts = fp.readline().split(',')

        dbTable = file.split('.')[0]
        attsForQuery = '('


        for i in range(0,len(atts)):
            if atts[i] == 'direction':
                atts[i] = 'direction_id'
            attsForQuery += atts[i] + ','

        attsForQuery = attsForQuery[:-2] + ')'


        for line in fp.readlines():
            values = line.split(',')
            valuesForQuery = '('

            idAtt = 0
            for value in values:
                isNumeric = atts[idAtt] in numericAttsList
                value = value.replace('\'','')
                value = value.replace('ç','c')
                value = value.replace('ó','o')
                value = value.replace('é','e')
                value = value.replace('á','a')
                value = value.replace('ã','a')
                value = value.replace('Ã','A')

                if isNumeric:
                    value = '0' if (value=='') else value
                    valuesForQuery += value + ','
                else:
                    valuesForQuery += '\'' + value + '\','
                idAtt += 1

            valuesForQuery = valuesForQuery[:-1] + ')'

            valuesForQuery = valuesForQuery.replace('\n','')

            sqlQuery = 'INSERT INTO '+ dbTable + ' ' + attsForQuery + ' VALUES ' + valuesForQuery + ';'

            out_file.write(sqlQuery + "\n")

    out_file.close()

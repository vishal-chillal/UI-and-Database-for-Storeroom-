import psycopg2
import ConfigParser
import sys
from itertools import dropwhile

Config = ConfigParser.ConfigParser()
Config.read(sys.argv[1])


# function to get list of tables from database
def getLsTable(dbname,user):
    conn = psycopg2.connect("dbname="+dbname+" user="+user)
    cur = conn.cursor()
    query = "select table_name from information_schema.tables where table_schema = 'public';"
    cur.execute(query)
    ls =  cur.fetchall()
    lsTable = map(lambda tup: tup[0],ls)
    cur.close()
    conn.close()
    return lsTable

def genTableSelection(lsTable,jsFile,tableID):
    fo = open(jsFile,"w+")
#genetating list of table names in js file
    ls = 'lsTable = ['
    for i in lsTable:
        ls = ls + "\'"+i+"\',\n "
    ls = ls + "]"
    fo.write(ls)
    function = "\nfunction genTableOfTableNames(lsTable){\n"
    function = function + "for(i=0;i<lsTable.length;i++){\n"
    function = function + "$('#lsTable').append('<tr><td> <select> <option> '+lsTable[i]+'</option> </select> </td></tr>')\n}\n}"
    fo.write(function)
    fo.close()

name = Config.get('database','db_name')
user = Config.get('database','user')
lsTable = getLsTable(name,user)
#print lsTable
genTableSelection(lsTable,'listTable.js','abc')

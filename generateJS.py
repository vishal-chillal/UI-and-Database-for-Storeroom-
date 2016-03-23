import psycopg2
import ConfigParser
import sys

Config = ConfigParser.ConfigParser()
Config.read(sys.argv[1])

table_tupple = []

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

def getTableTupples(lsTable,dbname,user):
    conn = psycopg2.connect("dbname="+dbname+" user="+user)
    cur = conn.cursor()
    for table in lsTable:
        ps = []
        ps.append(table)
        query = "select column_name from information_schema.columns where table_name='"+table+"';"
        cur.execute(query)
        ps.append(map(lambda tup: tup[0],cur.fetchall()))
        table_tupple.append(ps)
    cur.close()
    conn.close()
    return table_tupple

def genTableSelection(lsTable,jsFile):
    fo = open(jsFile,"a")
    #genetating list of table names in js file
    ls = 'lsTable = ['
    for i in lsTable:
        ls = ls + "\'"+i+"\',\n "
    ls = ls + "]"
    fo.write(ls)
    function = "\nfunction genTableOfTableNames(lsTable){\n"
    function = function + "for(i=0;i<lsTable.length;i++){\n"
    function = function + "$('#lsTable').append('<tr><td> <input type=\"button\" value=\"'+lsTable[i]+'\"></td></tr>')\n}\n}"
    fo.write(function)

    function = "\nfunction genTuppleTable(tuppleLs,tableName){\n"
    function = function + "for(i=0;i<tuppleLs.length;i++){\nif(tuppleLs[i][0] == tableName){\n"
    function = function + "for(j=0;j<tuppleLs[i][1].length;j++){\n"
    function = function + "$('#tupplesTable').append('<tr><td> <input type=\"button\" value=\"'+tuppleLs[i][1][j]+'\"></td></tr>')\n}\n}\n}\n}"
    fo.write(function)
    fo.close()


def writeTuppleLs(jsFile,lsTupple):
    ls = "tuppleLs = ["
    for t in lsTupple:
        ls = ls + "['"+t[0]+"', "
        tmp = "["
        for tup in t[1]:
            tmp = tmp + "'"+tup+"', "
        tmp = tmp + "]"
        ls = ls + tmp + "],\n"
    ls = ls + "]\n"
    fo = open(jsFile,"w+")
    fo.write(ls);
    fo.close();

def createLs(ts):
    ts = map(lambda x:str(x),ts);
    ls = "["
    for i in ts:
        ls = ls + "'"+i+"', "
    ls = ls + "]"
    return ls

def getTuppleValues(lsTupple,jsFile,dbname,user):
    conn = psycopg2.connect("dbname="+dbname+" user="+user)
    cur = conn.cursor()
#"[[table,[[tup1,[val1,val2]]]]]"
    ps = "tupValLs = ["
    for i in lsTupple:
        ps = ps + "['"+i[0]+"',"
        ls = "["
        for j in i[1]:
            query = "select "+j+" from "+i[0]+";"
            cur.execute(query)
            ts = createLs(map(lambda tup: tup[0],cur.fetchall()))
            ls = ls + "['"+j+"',"+ ts +"],"
        ls = ls+"],"
        ps = ps + ls +"],\n"
    ps = ps + "]\n"
    fo = open(jsFile,"a")
    fo.write(ps);
    fo.close();


    cur.close()
    conn.close()


name = Config.get('database','db_name')
user = Config.get('database','user')
lsTable = getLsTable(name,user)
lsTupple = getTableTupples(lsTable,name,user)
writeTuppleLs('js/listTable.js',lsTupple);
getTuppleValues(lsTupple,'js/listTable.js',name,user)
genTableSelection(lsTable,'js/listTable.js')

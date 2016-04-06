#!/usr/bin/python

#here add file which take arguments from file, do insertion according to that, and if failed then return error
import psycopg2
import sys
file = []
fp = open('../sql/insert.sql','r')
for line in fp:
    line = line.split(' ')
    if(line[0]!='\n'):
        file.append(line)
#print file

def fnConnectPsql():
    sDbname = 'vishal'
    sUser = 'vishal'
    sPassword = ''
    try:
        conn = psycopg2.connect("dbname={} user={} password={}".format(sDbname, sUser, sPassword))
        conn.autocommit = True
        cur = conn.cursor()
        return cur
    except Exception as e:
        print e

cur = fnConnectPsql()

def checkDuplicateWalls(file):
    cur.execute("select containerConcreteRoof,containerConcreteFloor,containerConcreteRight,containerConcreteLeft,containerConcreteFront,containerConcreteBack from containerConcreteTypeFaces;")
    getParentDimList = cur.fetchall()
    if getParentDimList == []:
        q = reduce(lambda a,b:a+b+" ",query,"")
        cur.execute(q);
        #print cur.fetchall()
        print "unique"
        return

    existed_wall=getParentDimList[0]

    ln = query[3][7:len(query[3])-3].split(',')[1:]
    print ln
    print existed_wall
    for wall in ln:
        if(len(filter(lambda x:x==wall[1:len(wall)-1],existed_wall))>0):
            print "not unique"
            return;
    if((len(ln))==len(next(iter(set(ln))))):
        print "not_unique"
        return;
    else:
        q = reduce(lambda a,b:a+b+" ",query,"")
        cur.execute(q);
        #print cur.fetchall()
        print "unique"

def checkVolumeParentChild(file):
    ln = query[3][6:]
    ln = ln[:len(ln)-3]
    ln = ln.split('),')
    ln = map(lambda x:x[1:],ln)
    print ln
    for ins in ln:
        #print ins
        inst = ins.split(',')
        ct = inst[1]
        nct = inst[0]
        query1 = "select containerLengthAB,containerLengthAD,containerLengthAE,containerThickness from containerConcreteTypes where containerConcreteTypeId="+ct+";"
        query2 = "select nonContainerLengthAB,nonContainerLengthAD,nonContainerLengthAE from nonContainerConcreteTypes where nonContainerConcreteTypeId="+nct+";"
        cur = fnConnectPsql()
        cur.execute(query1)
        dim1 = cur.fetchall()[0]
        print query2
        cur.execute(query2)
        dim2 = cur.fetchall()[0]
        volumeCont = dim1[0]*dim1[1]*dim1[2]-(dim1[3]**3)
        volumeNonCont = dim2[0]*dim2[1]*dim2[2];
        if(volumeCont <= volumeNonCont):
            print "invalid Volume"
            return
            
    q = " ".join(query)
    cur.execute(q[:-1])

if __name__ == '__main__':
    for query in file:
        if(query[0]=='insert' and (query[2]=="containerConcretetypefaces" or query[2]=="noncontainertypefaces")):
            checkDuplicateWalls(query)
        elif(query[0]=='insert' and query[2]=="directchild_parent"):
            checkVolumeParentChild(query)
        else:
            q = (" ".join(query))[:-1]
            print q
            cur.execute(q)

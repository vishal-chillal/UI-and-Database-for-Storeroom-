#!/usr/bin/python

import psycopg2
import sys
file = []
fp = open('../sql/Final_Total_DB.sql','r')
#fp = open('../sql/insert.sql','r')
for line in fp:
    line = line.split(' ')
    if(line[0]!='\n'):
        file.append(line)

def fnConnectPsql():
    sDbname = 'vishal'
    sUser = 'vishal'
    try:
        conn = psycopg2.connect("dbname={} user={}".format(sDbname, sUser))
        conn.autocommit = True
        cur = conn.cursor()
        return cur
    except Exception as e:
        print e

def checkVolumeParentChild(query):
    ln = query[4]
    parallelToAB = ['AB', 'CD', 'EF', 'GH', 'BA', 'DC', 'FE', 'HG']
    parallelToAD = ['AD', 'CB', 'EH', 'GF', 'DA', 'BC', 'HE', 'FG']
    parallelToAE = ['AE', 'BF', 'CG', 'DH', 'EA', 'FB', 'GC', 'HD']
    ln = ln[:len(ln)-3]# get all the inserting values in  tuples
    ln = ln.split('),')
    ln = map(lambda x:x[1:],ln)

    for ins in ln:
        inst = ins.split(',')
        parrent = inst[1]
        child = inst[0]
        query_cnt = "select containerLengthAB,containerLengthAD,containerLengthAE,containerThickness from containerConcreteTypes where containerConcreteTypeId="
        query_ncnt = "select nonContainerLengthAB,nonContainerLengthAD,nonContainerLengthAE from nonContainerConcreteTypes where nonContainerConcreteTypeId="+child+";"
        cur.execute(query_cnt + "{};".format(parrent))
        parentDims = cur.fetchall()[0]
        #print parentDims
        if(child[1] == 'n'):
            cur.execute(query_ncnt)
            dim_child = cur.fetchall()[0]
            #print dim_child
        else:
            cur.execute(query_cnt + "{};".format(child))
            dim_child = cur.fetchall()[0]
            #print dim_child
        orientation = inst[-1][1:-1]
        if orientation[:2] in parallelToAB:
            childAB = dim_child[0]
            if orientation[0]+orientation[-1] in parallelToAD:
                childAD = dim_child[1]
                childAE = dim_child[2]
            else:
                childAE = dim_child[1]
                childAD = dim_child[2]
        elif orientation[:2] in parallelToAD:
            childAB = dim_child[1]
            if orientation[0]+orientation[-1] in parallelToAB:
                childAD = dim_child[0]
                childAE = dim_child[2]
            else:
                childAE = dim_child[0]
                childAD = dim_child[2]
        else:
            childAB = dim_child[2]
            if orientation[0]+orientation[-1] in parallelToAD:
                childAD = dim_child[1]
                childAE = dim_child[0]
            else:
                childAE = dim_child[1]
                childAD = dim_child[0]
        #print childAB, childAD, childAE
        if childAB <= parentDims[0] - parentDims[-1]:
            if childAD <= parentDims[1] - parentDims[-1]:
                if childAE <= parentDims[2] - parentDims[-1]:
                    q = " ".join(query)
                    try:
                        cur.execute(q)
                        return
                    except psycopg2.Error as e:
                        print "Unable to insert!"
                        print e.pgerror
        print parentDims
        print childAB, childAD, childAE
        print "child cannot fit into parent"
def checkWallFaces(query):
    print query

cur = fnConnectPsql()

if __name__ == '__main__':
    flag = 0
    k = 0
    for query in file:
        k = k+1
        print k
        if(query[0]=='insert' and query[2]=="directchild_parent"):
            checkVolumeParentChild(query)
        if(query[0]=='insert' and query[2]=="containerConcreteTypefaces"):
            checkWallFaces(query)
        else:
            q = (" ".join(query))[:-1]
            if( q != ''):
                try:
                    cur.execute(q)
                except psycopg2.Error as e:
                    print "Unable to connect!"
                    print e.pgerror


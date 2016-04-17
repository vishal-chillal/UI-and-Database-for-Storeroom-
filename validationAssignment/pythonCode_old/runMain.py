#!/usr/bin/python

import psycopg2
import sys
file = []
fileName = sys.argv[1]
#fp = open('Final_Total_DB.sql','r')
fp = open(fileName,'r')
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

def checkWallDoors(query):
    ln = query[4]
    parallelToAB = ['AB', 'CD', 'BA', 'DC']
    parallelToAD = ['AD', 'CB', 'DA', 'BC']
    ln = ln[:len(ln)-3]# get all the inserting values in  tuples
    ln = ln.split('),')
    ln = map(lambda x:x[1:],ln)

    for ins in ln:
        inst = ins.split(',')
        wall = inst[0]
        door = inst[1]
        query_wall = "select WallLengthAB,WallLengthAD from abstractWall where wallID="+wall+";"
        query_door = "select DoorLengthAB,DoorLengthAD from abstractDoor where doorID="+door+";"
        cur.execute(query_wall)
        wallDims = cur.fetchall()[0]
        cur.execute(query_door)
        doorDims = cur.fetchall()[0]
        flag = 0
        line = ins.split(',')
        if(line[4][1:3] in parallelToAB):
            if(wallDims[0]<doorDims[0] or wallDims[1]<doorDims[1]):
                flag=1
        else:
            if(wallDims[0]<doorDims[1] or wallDims[1]<doorDims[0]):
                flag = 1
        if(flag==1):
            print "Door cannot fit on wall,exceeding dimensions"
            return
        else:
            q = " ".join(query)
            try:
                cur.execute(q)
                return
            except psycopg2.Error as e:
                print "Unable to insert!"
                print e.pgerror

def checkVolumeParentChild(query):
    parallelToAB = ['AB', 'CD', 'EF', 'GH', 'BA', 'DC', 'FE', 'HG']
    parallelToAD = ['AD', 'CB', 'EH', 'GF', 'DA', 'BC', 'HE', 'FG']
    parallelToAE = ['AE', 'BF', 'CG', 'DH', 'EA', 'FB', 'GC', 'HD']
    ln = query[4]
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
        parentDims = cur.fetchall()
        print parentDims[0]
        if(len(parentDims)==0):
            print "Error:Insertion sql"
            return
        parentDims = parentDims[0]
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
def checkContainerWallFaces(query):
    ln = query[4]
    ln = ln[:len(ln)-3]# get all the inserting values in  tuples
    ln = ln.split('),')
    ln = map(lambda x:x[1:],ln)

    for ins in ln:
        inst = ins.split(',')
        container = inst[0]
        query1 = "select * from containerConcreteTypes where containerConcreteTypeId = " + container + ";"
        cur.execute(query1)
        result = cur.fetchall()[0]
        dimList = [(result[1], result[2]),(result[1], result[2]),(result[2], result[3]),(result[2], result[3]),(result[3], result[1]),(result[3], result[1])]
        for i in range(6):
            query2 = "select * from abstractwall where wallid = " + inst[i+1] + ";"
            cur.execute(query2)
            res = cur.fetchall()[0]
            if(res[1] != dimList[i][0] or res[2] != dimList[i][1]):
                print "wall size does not match " + str(dimList[i]) +" and (" + res[0] + ", " + str(res[1]) + ", " + str(res[2]) +")"
                return
        q = " ".join(query)
        try:
            cur.execute(q)
            return
        except psycopg2.Error as e:
            print "Unable to insert!"
            print e.pgerror

def checkNonContainerWallFaces(query):
    ln = query[4]
    ln = ln[:len(ln)-3]
    ln = ln.split('),')
    ln = map(lambda x:x[1:],ln)

    for ins in ln:
        inst = ins.split(',')
    
        nonContainer = inst[0]
        query1 = "select * from nonContainerConcreteTypes where nonContainerConcreteTypeId = " + nonContainer + ";"
        cur.execute(query1)
        result = cur.fetchall()[0]
    
        dimList = [(result[1], result[2]),(result[1], result[2]),(result[2], result[3]),(result[2], result[3]),(result[3], result[1]),(result[3], result[1])]
    
        for i in range(6):
            query2 = "select * from abstractwall where wallid = " + inst[i+1] + ";"
            cur.execute(query2)
            res = cur.fetchall()[0]
            if(res[1] != dimList[i][0] or res[2] != dimList[i][1]):
                print "wall size does not match " + str(dimList[i]) +" and (" + res[0] + ", " + str(res[1]) + ", " + str(res[2]) +")"
                return
        q = " ".join(query)
        try:
            cur.execute(q)
            return
        except psycopg2.Error as e:
            print "Unable to insert!"
            print e.pgerror

if __name__ == '__main__':
    flag = 0
    k = 0
    cur = fnConnectPsql()
    for query in file:
        k = k+1
        print query
        print k
                
        if(query[0]=='insert' and query[2]=="directchild_parent"):
            checkVolumeParentChild(query)
        elif(query[0]=='insert' and query[2]=="walldoor"):
            checkWallDoors(query)
        elif(query[0]=='insert' and query[2]=="containerConcretetypefaces"):
            checkContainerWallFaces(query)
        elif(query[0]=='insert' and query[2]=="noncontainerConcretetypefaces"):
            checkNonContainerWallFaces(query)
        else:
            q = (" ".join(query))[:-1]
            if( q != ''):
                try:
                    cur.execute(q)
                except psycopg2.Error as e:
                    print "Unable to insert!"
                    print e.pgerror


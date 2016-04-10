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
    sDbname = 'saurabh'
    sUser = 'saurabh'
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
    print ln

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
        #check wall orientation
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
            print q
            try:
                cur.execute(q)
                return
            except psycopg2.Error as e:
                print "Unable to insert!"
                print e.pgerror



cur = fnConnectPsql()

if __name__ == '__main__':
    flag = 0
    k = 0
    for query in file:
        k = k+1
        print k
        if(query[0]=='insert' and query[2]=="walldoor"):
            checkWallDoors(query)
        if(query[0]=='insert' and query[2]=="containerConcreteTypefaces"):
            checkWallFaces(query)
        else:
            q = (" ".join(query))[:-1]
            if( q != ''):
                try:
                    cur.execute(q)
                except psycopg2.Error as e:
                    print "Unable to Insert!"
                    print e.pgerror


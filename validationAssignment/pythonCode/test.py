#!/usr/bin/python

#here add file which take arguments from file, do insertion according to that, and if failed then return error
import psycopg2
import sys
file = []
fp = open('NewInsertion.sql','r')
for line in fp:
    line = line.split(' ')
    file.append(line)
            
print file



    
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

def fnGetDimension(iIdValue,dimensionsList):
    cur = fnConnectPsql()
    cur.execute("select walllengthab, walllengthad from abstractwall where wallid={}".format(iIdValue))
    getParentDimList = cur.fetchall()
    getParentDimList = [i for i in getParentDimList[0]]
    iFlag = 0
    for i in range(len(getParentDimList)):
        if getParentDimList[i] > dimensionsList[i]:
            iFlag = 1
        else:
            iFlag = 0
    if iFlag == 1:
        cur.execute("insert into temp2 values({}, {}, {}, {});".format(iIdValue, dimensionsList[0], dimensionsList[1], dimensionsList[2]))
        print "inserted"

def fnWallIdCheck(iId, givenWallList, iContainerType):
    iFlag = 0
    iFlagInner = 0
    cur = fnConnectPsql()
    cur.execute("select * from abstractwall;")
    wallList = cur.fetchall()
    wallList = [i[0] for i in wallList]
    cur.execute("select containerconcreteroof, containerconcretefront, containerconcreteback, containerconcretefloor, containerconcreteleft, containerconcreteright from containerconcretetypefaces;")
    usedWalls = cur.fetchall()
    cur.execute("select noncontainerconcreteroof, noncontainerconcretefront, noncontainerconcreteback, noncontainerconcretefloor, noncontainerconcreteleft, noncontainerconcreteright from noncontainerconcretetypefaces;")
    wallsTemp = cur.fetchall()
    for i in wallsTemp:
        usedWalls.append(i)
    usedWalls = [e for l in usedWalls for e in l]
    print wallList
    print givenWallList
    print usedWalls
    for i in givenWallList:
        if i in wallList:
            iFlag = 1
            continue
        else:
            iFlag = 0
            break;
    if iFlag == 1:
        for i in givenWallList:
            if i in usedWalls:
                iFlagInner = 0
                break;
            else:
                iFlagInner = 1
                continue;
    if iFlagInner == 1:
        if(iContainerType == 0):
            query = "insert into noncontainerconcretetypefaces values('{}', '{}', '{}', '{}', '{}', '{}', '{}');".format(iId, givenWallList[0], givenWallList[1], givenWallList[2], givenWallList[3], givenWallList[4], givenWallList[5])
            print query
            cur.execute(query)
        else:
            query = "insert into containerconcretetypefaces values('{}', '{}', '{}', '{}', '{}', '{}', '{}');".format(iId, givenWallList[0], givenWallList[1], givenWallList[2], givenWallList[3], givenWallList[4], givenWallList[5])
            print query
            cur.execute(query)
if __name__ == '__main__':
    '''dimensionsList = []
    for i in sys.argv[1:]:
        dimensionsList.append(i)
    iIdValue = dimensionsList[0]
    dimensionsList = map(int, dimensionsList[1:])
    fnGetDimension(iIdValue, dimensionsList) 
    givenWallList = []
    for i in sys.argv[2:-1]:
        givenWallList.append(i)
    fnWallIdCheck(sys.argv[1], givenWallList, int(sys.argv[-1]))
'''

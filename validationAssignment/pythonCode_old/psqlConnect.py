#!/usr/bin/python
import psycopg2
import sys

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

            cur.execute(query)
if __name__ == '__main__':
    '''dimensionsList = []
    for i in sys.argv[1:]:
        dimensionsList.append(i)
    iIdValue = dimensionsList[0]
    dimensionsList = map(int, dimensionsList[1:])
    fnGetDimension(iIdValue, dimensionsList) '''
    givenWallList = []
    for i in sys.argv[2:-1]:
        givenWallList.append(i)
    fnWallIdCheck(sys.argv[1], givenWallList, int(sys.argv[-1]))

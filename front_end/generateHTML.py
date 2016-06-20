import ConfigParser
import sys

Config = ConfigParser.ConfigParser()
Config.read(sys.argv[1])

def generateHTML(fileName,jsFile,tableId):
    fo = open(fileName,"w+");
    header = '<!DOCTYPE html>\n<html>\n<head>\n<title> UI Table </title>\n<link rel="stylesheet" type="text/css" href="css/styles.css">\n<script src="js/jquery-1.11.3.js"></script>\n<script src="js/listTable.js"></script>\n<script src="'+jsFile+'"></script>\n</head>\n'
    body ='<body>\n<table id="'+tableId+'">\n</table>\n<br>'
    submit = ""
    if(fileName=='tableNames.html'):
        submit ='selected table = <input type="text" id="selectionBox" value="" disabled>\n'
    if(fileName=='editTable.html'):
        submit ='output of given operation = <input type="text" id="outPutBox" value="" disabled>\n'
        
    submit = submit + '<button class="submitButton"> submit </button>\n</body>\n</html>\n'
    fo.write(header+body+submit);
    fo.close();

for section in Config.sections():
    fileName = section+".html"
    jsFile = Config.get(section,'jsFile');
    tableId = Config.get(section,'tableId');
    generateHTML(fileName,jsFile,tableId);


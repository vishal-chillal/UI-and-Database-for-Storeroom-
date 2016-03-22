import ConfigParser
import sys

def genTable(name,columns,attr):
    table_tag = "<table id=\""+name+"\" name=\""+name+"\">\n"
    header = '<tr class="header_row">'
    for i in xrange(columns):
        header = header+"\n<td><input type\"text\" value="+attr[i]+"></td>"
    header = header+"\n</tr>\n"
    row = '<tr>'
    for i in xrange(columns):
        row = row+'\n<td><input type="text"></td>'
    row = row+'\n</tr>\n'
    str = table_tag+header+row+'\n</table>\n'

    return(str+'\n<br>')

Config = ConfigParser.ConfigParser()
Config.read(sys.argv[1])
html_file = sys.argv[2]


file = open(html_file,"a")
for table in Config.sections():
    name = Config.get(table,'Name')
    columns =  int(Config.get(table,'Columns'))
    attr = Config.get(table,'Attr').split(',')
    file.write(genTable(name,columns,attr));

file.write("</body>\n</html>\n")
file.close()

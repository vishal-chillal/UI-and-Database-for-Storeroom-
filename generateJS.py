import ConfigParser
import sys

Config = ConfigParser.ConfigParser()
Config.read(sys.argv[1])

for table in Config.sections():
    print Config.get(table,'Name')
    print Config.get(table,'Columns')
    print Config.get(table,'Attr').split(',')

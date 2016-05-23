run:
	psql -f create_db.sql
	python runMain.py Final_Total_DB.sql databaseConfig > output.txt;clear
#	python runMain.py insert.sql databaseConfig > output.txt;clear
	less output.txt
clean:
	rm output.txt
error:
	psql -f create_db.sql
	python runMain.py error_db.sql databaseConfig > output.txt;clear
	less output.txt

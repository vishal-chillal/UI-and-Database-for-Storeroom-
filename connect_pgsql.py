import psycopg2

conn = psycopg2.connect("dbname=saurabh user=saurabh")

cur = conn.cursor()
query = "select table_name from information_schema.tables where table_schema = 'public';"
cur.execute(query)
print cur.fetchall()

cur.close()
conn.close()

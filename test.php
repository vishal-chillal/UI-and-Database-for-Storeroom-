<?php
$host        = "host=127.0.0.1";
$port        = "port=5432";
$dbname      = "dbname=vishal";
$credentials = "user=mw password=password";

$db = pg_connect( "$host $port $dbname $credentials"  );
if(!$db){
	echo "Error : Unable to open database\n";
} else {
	echo "Opened database successfully\n";
}

$sql =  "SELECT * from objects";

$ret = pg_query($db, $sql);
if(!$ret){
	echo pg_last_error($db);
	exit;
}
while($row = pg_fetch_row($ret)){
	echo "ID = ". $row[0] . "\n";
}
     echo "Operation done successfully\n";
 pg_close($db);
?>


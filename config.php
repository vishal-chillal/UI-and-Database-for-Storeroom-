
<?php
$host        = "host=localhost";
$port        = "port=5432";
$dbname      = "dbname=vishal";
$credentials = "user=se1 password=password";

$db = pg_connect($host." ".$port." ".$dbname." ".$credentials);
//$dbconn3 = pg_connect("host=localhost port=5432 dbname=saurabh user=saurabh password=s");
print $db;
if(!$db){
	echo "Error : Unable to open database\n";
} else {
	echo "Opened database successfully\n";
}
?>

<?php

require "config.php";


$ret = pg_query($db, "SELECT * from objects");
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


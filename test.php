<?php

require "config.php";

$table_name="";
$coulmnAttr= [];

for($i=0;$i<5;$i++)
$ret = pg_query($db, "create table if not exists objects");
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

<!DOCTYPE html>
<html>
	<head>
		<title> UI Table </title>
		<link rel="stylesheet" type="text/css" href="css/styles.css">
		<script src="js/jquery-1.11.3.js"></script>
		<script src="js/dynamicTable.js"></script>
	</head>
	<body>
		<table id="idTable" name="objects">
			<tr id="header_row">
				<th><input type"text" name"Sr_No"></th>
				<th><input type"text" name"Object_ID"></th>
				<th><input type"text" name"Object_Lable"></th>
				<th><input type"text" name"Object_Properties"></th>
			</tr>
			<tr>
				<td><input type="text" name="Sr_No" disabled value="0"></td>
				<td><input type="text" name="Object_ID"></td>
				<td><input type="text" name="Object_Lable"></td>
				<td><input type="text" name="Object_Properties"></td>
			</tr>
		</table>
	</body>
</html>


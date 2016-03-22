$(document).ready(function (){
	includeJs('listTable.js');
	alert("hello");
	genTableOfTableNames(lsTable);
});

function includeJs(path)
{
	var imported = document.createElement('script');
	imported.src = path;
	document.head.appendChild(imported);
}




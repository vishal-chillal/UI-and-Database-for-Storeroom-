tables = []
function addTableRow(name,arr){
	for(i=0;i<tables.length;i++){
		if(table[i][0] == name){
			table[i][1].push(arr);
			return;
		}
		table_row = [name,[arr]];
		tables.push(table_row);
	}
}

function modifyRow(name,arr,index)
{
	for(i=0;i<tables.length;i++){
		if(table[i][0] == name){
			table[i][1][index]=arr;
		}
	}
}

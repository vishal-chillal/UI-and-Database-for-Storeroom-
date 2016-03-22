$(document).ready(function (){

	/*alert(localStorage.tupple);*/
	getEditTable(localStorage.table,localStorage.tupple,tupValLs);
	$("input").keydown(function(e){
		handleKeyEvent(e,$(this));
	});


});
function handleKeyEvent(e,ths)
{
	var keycode = e.which;
	if(keycode == '32'){
		if(ths.parent().hasClass('select'))
			ths.parent().removeClass('select')
		else
			ths.parent().addClass('select')

	}
	if(keycode == '38'){
		next = ths.parent().prev()
		next.find('input').focus();
	}
	if(keycode == '40'){
		next = ths.parent().next()
		next.find('input').focus();
	}
}

function includeJs(path)
{
	var imported = document.createElement('script');
	imported.src = path;
	document.head.appendChild(imported);
}

function getEditTable(tableName,tupLs,tupValLs){
	tupLs = tupLs.split(",");
	column = ""
	for(i=0;i<tupLs.length;i++){
		column = column + '<td> <input type="button" value="'+tupLs[i]+'"></td>'
	}
	$('#editTable').append('<tr>'+column+'</tr>;')
	rowAttr = []
	for(i=0;i<tupValLs.length;i++){
		if(tuppleLs[i][0]==tableName){
			for(j=0;j<tupLs.length;j++){
				for(k=0;k<tupValLs[i][1].length;k++){
					/*if(tupLs[j]==tupValLs[i][1][k]){*/
					if(tupValLs[i][1][k][0]==tupLs[j])
						rowAttr.push(tupValLs[i][1][k][1]);
				}
			}
		}
	}
	addRow(rowAttr,tupLs)
}

function addRow(valLs,tupLs){
	console.log(valLs)
	for(j=0;j<valLs.length;j++){
		row = ""
		for(i=0;i<tupLs.length;i++){
			row = row + '<td> <input type="text" value="'+valLs[j][i]+'"></td>'
		}
		$('#editTable').append('<tr>'+row+'</tr>;')
	}
}

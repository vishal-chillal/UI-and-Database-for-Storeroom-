$(document).ready(function (){
	getEditTable(localStorage.table,localStorage.tupple,tupValLs);
	$('#editTable').find('tr').first().find('input').focus();
	addNewRowBelow($('#editTable').find('tr').first().find('input'));
	$("input").keydown(function(e){
		handleKeyEvent(e,$(this));
	});
	$('.submitButton').click(function(e){
		    window.location="tableNames.html";
	});
});

function addNewRowBelow(ths){
	flag = 1
	ls = ths.parent().parent().parent().find('input')
	for(i=0;i<ls.length;i++){
		if($(ls[i]).val()=="")
			flag = 0;
	}
	if(flag){
		column = ""
		ls = ths.parent().parent().find('input')
		for(i=0;i<ls.length;i++)
			column = column + '<td><input type="text" value=""></td>'
		obj = $('<tr>'+column+'</tr>;')
		obj.find('input').keydown(function(e){
			handleKeyEvent(e,$(this));
		});
		$('#editTable').append(obj);

	}
}
function handleKeyEvent(e,ths)
{
	var keycode = e.which;
	if(keycode == '13'){
		addNewRowBelow(ths);
	}
	if(keycode == '37'){
		next = ths.parent().prev()
		next.find('input').focus();
	}
	if(keycode == '39'){
		next = ths.parent().next()
		next.find('input').focus();
	}
	if(keycode == '38'){
		current = (ths.parent().parent().find('input').index(ths));
		ths.parent().parent().prev().find("input:eq("+current+")").focus();
	}
	if(keycode == '40'){
		current = (ths.parent().parent().find('input').index(ths));
		ths.parent().parent().next().find("input:eq("+current+")").focus();
	}
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
	for(j=0;j<valLs[0].length;j++){
		row = ""
		for(i=0;i<tupLs.length;i++){
			row = row + '<td> <input type="text" value="'+valLs[j][i]+'"></td>'
		}
		$('#editTable').append('<tr>'+row+'</tr>;')
	}
}

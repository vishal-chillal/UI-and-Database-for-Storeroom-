var passingArg = {"a":"asd","b":"asdad","d":"asdsad"}
$(document).ready(function (){
    var old_table = getEditTable(localStorage.table,localStorage.tupple,tupValLs);
    $('#editTable').find('tr').first().find('input').focus();
//    console.log($('#editTable').find('tr').first().find('input').focus();)
    addNewRowBelow($('#editTable').find('tr').first().find('input'));
    $("input").keydown(function(e){
	handleKeyEvent(e,$(this));
    });
    $('.submitButton').click(function(e){
	// window.location="tableNames.html";
	checkChanges(old_table);
	
    });
});

function checkChanges(old_table){
    old_vals= [];
    Entry = "";
    Entry1 = "";
    
    insertEntries = [];
    updateEntries = {};
    for(var i = 0; i < old_table[0].length; i++) {
	tList = [];
	for(var j = 0; j < old_table.length; j++) {
	    tList.push(old_table[j][i]);
	}
	old_vals.push(tList);
    }
    var new_val = getValuesFromTable();
    // now check values
    console.log(old_vals);
    console.log(new_val);
    if (old_vals.length < new_val.length){
	var kk = old_vals.length;
	for (var k = old_vals.length; k < new_val.length; k++){
	    insertEntries.push(new_val[k]);
	}
	console.log(insertEntries);
	var kstr = ""
	Entry = '{';
	for(var i = 0 ; i<insertEntries.length; i++){
	    Entry1 = '"{';
	    for( var k = 0 ; k<insertEntries[i].length; k++){
		Entry1 += "'"+ k.toString()+ "':'" + insertEntries[i][k] + "'";
	        if(k!=insertEntries[i].length-1)
	    		Entry1 += ","; 
	    }
	    Entry1 += '}"'; 
	    if(i!=insertEntries.length-1)
	    	Entry1 += ","; 
	    Entry += '"'+i.toString() +'":'+Entry1;
	}
	Entry += ',"len":'+insertEntries.length +',"table":"'+localStorage.table+'"}';
    }
    
    for(var k = 0; k < old_vals.length; k++) {
	for(var m = 0; m < new_val[k].length ; m++){
	    if(new_val[k][m] != old_vals[k][m]){
		updateEntries.push(new_val[k]);
		break;
	    }
	}   
    }
    
    console.log(Entry);
//    console.log(updateEntries);
//    console.log(JSON.parse(JSON.stringify(old_vals)));
    var passingArg = JSON.parse(Entry);
    $(function(){
    	$.ajax({
    	    url:"http://localhost/cgi-bin/first.py",
    	    type: "post",
    	    datatype: "json",
    	    data: passingArg,
    	    success: function(response){
    		console.log(response);
    	    }
    	});
    });
}
function getValuesFromTable(){
    new_vals= [];
    console.log($('#editTable tr').length);
    // to get index name set i = 0;
    for (i = 1; i < $('#editTable tr').length; i++){
	tList = []
	for(j = 0; j < $('#editTable tr').eq(i).find('td').length; j++){
	    tList.push($('#editTable tr').eq(i).find('td').find('input').eq(j).val());
	}
	new_vals.push(tList);
    }
    return new_vals;
	
}

function addNewRowBelow(ths){
    flag = 1;
    ls = ths.parent().parent().parent().find('input');
    for(i=0;i<ls.length;i++){
	if($(ls[i]).val()=="")
	    flag = 0;
    }
    if(flag){
	column = "";
	ls = ths.parent().parent().find('input');
	for(i=0;i<ls.length;i++)
	    column = column + '<td><input type="text" value=""></td>';
	obj = $('<tr>'+column+'</tr>;');
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
	next = ths.parent().prev();
	next.find('input').focus();
    }
    if(keycode == '39'){
	next = ths.parent().next();
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
    column = "";
    for(i=0;i<tupLs.length;i++){
	column =column + '<td> <input type="button" value="'+tupLs[i]+'"></td>';
    }
    $('#editTable').append('<tr>'+column+'</tr>;');
    rowAttr = [];
    for(i=0;i<tupValLs.length;i++){
	if(tuppleLs[i][0]==tableName){
	    for(j=0;j<tupLs.length;j++){
		for(k=0;k<tupValLs[i][1].length;k++){
		    if(tupValLs[i][1][k][0]==tupLs[j])
			rowAttr.push(tupValLs[i][1][k][1]);
			// console.log(tupValLs[i][1][k][1]);
		}
	    }
	}
    }
    addRow(rowAttr,tupLs);
    return rowAttr;
}

function addRow(valLs,tupLs){
    for(j=0;j<valLs[0].length;j++){
	row = "";
	for(i=0;i<tupLs.length;i++){
	    row = row + '<td> <input type="text" value="'+valLs[i][j]+'"></td>';
	}
	$('#editTable').append('<tr>'+row+'</tr>;');
    }
}

$(document).ready(function (){
	genTuppleTable(tuppleLs,localStorage.table);
	$("input").keydown(function(e){
		handleKeyEvent(e,$(this));
	});
	$('.submitButton').click(function(e){
		alert("gotoNext");
		gotoEditTable();
		window.location="editTable.html";
	});
});

function gotoEditTable(){

	ls = []
	$('#tupplesTable > tbody  > tr >td').each(function() {
		if($(this).hasClass('select')){
			val = $(this).find('input').val();
			ls.push(val);
		}
	});
	alert(ls)
	localStorage.tupple = ls;
}

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

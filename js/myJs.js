$(document).ready(function (){
	genTableOfTableNames(lsTable);
	$("input").keydown(function(e){
		var x = $(this).val();
		handleKeyEvent(e,$(this));
	});
	$('.submitButton').click(function(e){
		if($('#selectionBox').val()!=""){
			gotoSelectTupple();
		    window.location="tupple.html";
		}
	});
});

function gotoSelectTupple(){
	localStorage.table = $('#selectionBox').val();
	alert(localStorage.table);
}

function handleKeyEvent(e,ths)
{
	var keycode = e.which;
	if(keycode == '32'){
		$('#selectionBox').val(ths.val());
	}
	if(keycode == '38'){
		next = ths.parent().parent().prev()
		next.find('input').focus();
	}
	if(keycode == '40'){
		next = ths.parent().parent().next()
		next.find('input').focus();
	}
}

function includeJs(path)
{
	var imported = document.createElement('script');
	imported.src = path;
	document.head.appendChild(imported);
}

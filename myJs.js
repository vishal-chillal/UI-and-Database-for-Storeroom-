$(document).ready(function (){
	genTableOfTableNames(lsTable);

	$("select").keydown(function(e){
		var x = $(this).val();
		handleKeyEvent(e,$(this));
	});



});

function handleKeyEvent(e,ths)
{
	var keycode = e.which;
	if(keycode == '32'){
		$('#selection').val(ths.val());
	}
	if(keycode == '38'){
		next = ths.parent().parent().prev()
		next.find('select').focus();
	}
	if(keycode == '40'){
		next = ths.parent().parent().next()
		next.find('select').focus();
	}
}

function includeJs(path)
{
	var imported = document.createElement('script');
	imported.src = path;
	document.head.appendChild(imported);
}

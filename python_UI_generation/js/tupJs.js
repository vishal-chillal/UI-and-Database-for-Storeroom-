$(document).ready(function (){
	genTuppleTable(tuppleLs,localStorage.table);
	$('#tupplesTable').find('input').first().focus();
	$("input").keydown(function(e){
		handleKeyEvent(e,$(this));
	});
	$('.submitButton').click(function(e){
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
	if(keycode == '13'){
		$('.submitButton').click();
	}
	if(keycode == '38'){
		next = ths.parent().parent().prev()
		next.find('input').focus();
	}
	if(keycode == '40'){
		next = ths.parent().parent().next()
		next.find('input').focus();
	}
	if(keycode=='114'){
		deselectAll();
	}
	if(keycode=='115'){
		invertSel();
	}
	if(keycode=='113'){
		selectAll();
	}
}

function deselectAll(){
	$('#tupplesTable > tbody  > tr >td').each(function() {
		if($(this).hasClass('select')){
			$(this).removeClass('select');
			flag = 0;
		}
	});
}
function selectAll(){
	$('#tupplesTable > tbody  > tr >td').each(function() {
		$(this).addClass('select');
	});
}
function invertSel(){
	$('#tupplesTable > tbody  > tr >td').each(function() {
		if($(this).hasClass('select')){
			$(this).removeClass('select');
		}
		else
			$(this).addClass('select');
	});
}

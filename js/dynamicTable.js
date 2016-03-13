$(document).ready(function (){
	includeJs('js/dataStructure.js');
	$("#idTable tr:last input").on('focusout',function(e){
		newRow(e,$(this))
		modfRow(e,$(this));
	});
	$("input").keydown(function(e){
		keyEvents(e,$(this));
	});
});

function newRow(e,ths)
{
	var flag = true;
	arr = [];
	var arg = $("#idTable tr:last input");
	for(i=0;i<arg.length;i++){
		if($(arg[i]).val()=="")
			flag = false;
		arr.push($(arg[i]).val());
	}
	console.log(arr);
	if (flag){
		addRow(rowDict,arr);
		ths.parent().parent().find("input").unbind("focusout");
		ths.parent().parent().find('input').on('focusout',function(e){
			modfRow(e,$(this));
		});

		var obj = $("<tr class='enter'><td><input type='text' name='Sr_No' disabled value='"+(countRow-1)+"'></td><td><input type='text' name='Object_ID' ></td><td><input type='text' name='Object_Lable' ></td><td><input type='text' name='Object_Properties'></td></tr>")

		obj.find('input').on('focusout',function(e){
			newRow(e,$(this))
		});

		obj.find('input').on('focusout',function(e){
			modfRow(e,$(this));
		});

		obj.find('input').keydown(function(e){
			keyEvents(e,$(this));
		});
		$('#idTable').append(obj);
	}

}
/*function to include other js files*/
function includeJs(path)
{
	var imported = document.createElement('script');
	imported.src = path;
	document.head.appendChild(imported);
}

function keyEvents(e,ths)
{
	var keycode = e.which;
	if(keycode == '13'){
		ths.parent().parent().next().find('input:eq(1)').focus();
		var name = ths.attr('name');
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
function modfRow(e,ths)
{
	console.log("called");
	var arr = []
	var flag = true;
	var par = ths.parent().parent();
	var arg = par.find("input");
	for(i=0;i<arg.length;i++){
		if($(arg[i]).val()=="")
			flag = false;
		arr.push($(arg[i]).val());
	}
	if(flag)
		modifyRow(rowDict,arr);
}

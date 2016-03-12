$(document).ready(function (){
	includeJs('js/dataStructure.js');

	$("#idTable tr:last input").on('focusout',function(e){
		$(this.parent)
		var v1 = $("#idTable tr:last [name='Sr_No']");
		var v2 = $("#idTable tr:last [name='Object_ID']");
		var v3 = $("#idTable tr:last [name='Object_Lable']");
		var v4 = $("#idTable tr:last [name='Object_Properties']");
		if (v2.val() != "" && v3.val() != "" && v4.val() != ""){
			addRow(rowDict,v2.val(),v3.val(),v4.val());
			$("#idTable tr:last").before("<tr class='enter'><td><input type='text' name='Sr_No' disabled value='"+(countRow-1)+"'></td><td><input type='text' name='Object_ID' value='"+v2.val()+"'></td><td><input type='text' name='Object_Lable' value='"+v3.val()+"'></td><td><input type='text' name='Object_Properties' value='"+v4.val()+"'></td></tr>");

			v1.val(countRow);
			v2.val("");
			v3.val("");
			v4.val("");
			$("#idTable tr.enter input").on('focusout',function(e){
				applyEvent(e,$(this));
			});
			$('#idTable tr.enter input').keydown(function(event){
				var keycode = event.which;
				if(keycode == '13'){
					$(this).parent().parent().next().find("[name='Object_ID']").focus();
					var name = $(this).attr('name');
					alert(name);
				}
				if(keycode == '38'){
					var name = $(this).attr('name');
					$(this).parent().parent().prev().find("[name='"+name+"']").focus();
				}
				if(keycode == '40'){
					var name = $(this).attr('name');
					$(this).parent().parent().next().find("[name='"+name+"']").focus();
				}
			});
		}
	});
});
/*function to include other js files*/
function includeJs(path)
{
	var imported = document.createElement('script');
	imported.src = path;
	document.head.appendChild(imported);
}

function applyEvent(e,ths)
{
	var par = ths.parent().parent();
	var v1 = par.find("[name='Sr_No']");
	var v2 = par.find("[name='Object_ID']");
	var v3 = par.find("[name='Object_Lable']");
	var v4 = par.find("[name='Object_Properties']");
	modifyRow(rowDict,v1.val(),v2.val(),v3.val(),v4.val());
}

rowDict = []
countRow = 0

function addRow(rowDict,Object_ID,Object_Lable,Object_Properties)
{
	rowDict.push({
		kSr_No : countRow,
		kObject_ID : Object_ID,
		kObject_Lable : Object_Lable,
		kObject_Properties : Object_Properties
	})
	countRow += 1;
	console.log(rowDict)

}

function modifyRow(rowDict,Sr_No,Object_ID,Object_Lable,Object_Properties)
{
	for(i=0;i<rowDict.length;i++){
		if(rowDict[i].kSr_No == Sr_No){
			rowDict[i].kObject_ID = Object_ID,
			rowDict[i].kObject_Lable = Object_Lable,
			rowDict[i].kObject_Properties = Object_Properties
			break;
		}
	}
	console.log(rowDict)

}
/*console.log(rowDict)*/
	/*addRow(rowDict,2,3,4)*/
	/*addRow(rowDict,12,13,14)*/
	/*console.log(rowDict)*/
	/*modifyRow(rowDict,1,10,15,20)*/
	/*console.log(rowDict)*/

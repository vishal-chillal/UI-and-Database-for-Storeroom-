rowDict = []
countRow = 0

function addRow(rowDict,arr)
{
	rowDict.push({
		kSr_No : arr[0],
		kObject_ID : arr[1],
		kObject_Lable : arr[2],
		kObject_Properties : arr[3]
	})
	countRow += 1;
	console.log(rowDict);

}

function modifyRow(rowDict,arr)
{
	console.log("called");
	for(i=0;i<rowDict.length;i++){
		if(rowDict[i].kSr_No == arr[0]){
			rowDict[i].kObject_ID = arr[1],
			rowDict[i].kObject_Lable = arr[2],
			rowDict[i].kObject_Properties = arr[3]
			break;
		}
	}
	console.log(rowDict);

}


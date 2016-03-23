lsTable = ['doors',
 'containerconcretetypes',
 'door_wall',
 'unit_list',
 'walls',
 'containerconcretetypefaces',
 'noncontainerconcretetypefaces',
 'physicalentities',
 'noncontainerconcretetypes',
 'propertytypes',
 'properties',
 'containerconcretetypeproperties',
 'containerobjects',
 'typeinheritance',
 'types',
 'measurementunits',
 'noncontainerconcretetypeproperties',
 'objects',
 'containerobjectproperties',
 'noncontainerobjects',
 'noncontainerobjectproperties',
 'child_parrent',
 ]
function genTableOfTableNames(lsTable){
for(i=0;i<lsTable.length;i++){
$('#lsTable').append('<tr><td> <input type="button" value="'+lsTable[i]+'"></td></tr>')
}
}
function genTuppleTable(tuppleLs,tableName){
for(i=0;i<tuppleLs.length;i++){
if(tuppleLs[i][0] == tableName){
for(j=0;j<tuppleLs[i][1].length;j++){
$('#tupplesTable').append('<tr><td> <input type="button" value="'+tuppleLs[i][1][j]+'"></td></tr>')
}
}
}
}
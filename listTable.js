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
$('#lsTable').append('<tr><td> <select> <option> '+lsTable[i]+'</option> </select> </td></tr>')
}
}
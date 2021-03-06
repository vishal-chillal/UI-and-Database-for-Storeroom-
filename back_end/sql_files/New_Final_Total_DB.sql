drop table directChild_parent CASCADE;
drop table nonContainerObjectProperties CASCADE;
drop table nonContainerObjects CASCADE;
drop table containerObjectProperties CASCADE;
drop table containerObjects CASCADE;
drop table unitList CASCADE;
drop table properties CASCADE;
drop table containerConcreteTypeFaces CASCADE; 
drop table containerConcreteTypes CASCADE;
drop table nonContainerConcreteTypeFaces CASCADE; 
drop table nonContainerConcreteTypes CASCADE;
drop table types CASCADE;
drop table objects CASCADE;
drop table propertyTypes CASCADE;
drop table WallDoor CASCADE;
drop table abstractWall CASCADE;
drop table abstractDoor CASCADE;


create table objects (objectID varchar(20) primary key check(objectID like 'nc%' OR objectID like 'c%'));

create table types (typeID varchar(20) primary key check(typeID like 'nct%' OR typeID like 'ct%'),typeName varchar(20) NOT NULL,description varchar(40));

create table containerConcreteTypes (containerConcreteTypeId varchar(20) references types(typeID) UNIQUE check(containerConcreteTypeID like 'ct%'),containerLengthAB integer check(containerLengthAB>0),containerLengthAD integer check(containerLengthAD>0),containerLengthAE integer check(containerLengthAE>0),containerThickness integer check(containerThickness>0),userObjectCommentGlobal varchar(40));

create table abstractDoor(doorID varchar(20) primary key check(doorID like 'd%'),doorLengthAB integer check(DoorLengthAB>0),doorLengthAD integer check(DoorLengthAD>0),doorColorR integer check(doorColorR>=0 AND doorColorR<=255),doorColorG integer check(doorColorG>=0 AND doorColorG<=255),doorColorB integer check(doorColorB>=0 AND doorColorB<=255));

create table abstractWall(WallID varchar(20) primary key,WallLengthAB integer check(WallLengthAB>0),WallLengthAD integer check(WallLengthAD>0),WallColorR integer check(WallColorR>=0 AND WallColorR<=255),WallColorG integer check(WallColorG>=0 AND WallColorG<=255),WallColorB integer check(WallColorB>=0 AND WallColorB<=255),userWallComment varchar(40));

create table WallDoor(wallID varchar(20) references abstractWall(WallID),doorID varchar(20) references abstractDoor(doorID) UNIQUE,DisplacementAB integer check(DisplacementAB>0),DisplacementAD integer check(DisplacementAD>0),orientation varchar(4) check(orientation like 'ABCD' OR orientation like 'ABCD' OR orientation like 'ABCD' OR orientation like 'ABCD' OR orientation like 'DCBA' OR orientation like 'DABC' OR orientation like 'CBAD' ),primary key(wallID,doorID));    

create table containerConcreteTypeFaces (containerConcreteTypeId varchar(20) references containerConcreteTypes (containerConcreteTypeId) UNIQUE,containerConcreteRoof varchar(20) references abstractWall (WallID) NOT NULL UNIQUE,containerConcreteFloor varchar(20) references abstractWall (WallID) NOT NULL UNIQUE,containerConcreteRight varchar(20) references abstractWall (WallID) NOT NULL UNIQUE,containerConcreteLeft varchar(20) references abstractWall (WallID) NOT NULL UNIQUE,containerConcreteFront varchar(20) references abstractWall (WallID) NOT NULL UNIQUE,containerConcreteBack varchar(20) references abstractWall (WallID) NOT NULL UNIQUE);

create table nonContainerConcreteTypes (nonContainerConcreteTypeId varchar(20) references types(typeID) UNIQUE check(nonContainerConcreteTypeID like 'nct%'),nonContainerLengthAB integer check(nonContainerLengthAB>0),nonContainerLengthAD integer check(nonContainerLengthAD>0),nonContainerLengthAE integer check(nonContainerLengthAE>0),userObjectCommentGlobal varchar(20));

create table nonContainerConcreteTypeFaces (nonContainerConcreteTypeId varchar(20) references nonContainerConcreteTypes(nonContainerConcreteTypeId) UNIQUE,nonContainerConcreteRoof varchar(20) references abstractWall (WallID) NOT NULL UNIQUE,nonContainerConcreteFloor varchar(20) references abstractWall (WallID) NOT NULL UNIQUE,nonContainerConcreteRight varchar(20) references abstractWall (WallID) NOT NULL UNIQUE,nonContainerConcreteLeft varchar(20) references abstractWall (WallID) NOT NULL UNIQUE,nonContainerConcreteFront varchar(20) references abstractWall (WallID) NOT NULL UNIQUE,nonContainerConcreteBack varchar(20) references abstractWall (WallID) NOT NULL UNIQUE);

create table propertyTypes (propertyType varchar(20) primary key check(propertyType like 'pT%'),userDescription varchar(40));

create table properties (propertyID varchar(20) primary key check(propertyID like 'pr0%'),propertyName varchar(15) NOT NULL,propertyType varchar(20) references propertyTypes(propertyType),userDescription varchar(40));

create table unitList (unitID varchar(15) primary key check(unitID like 'Uid0%'),unitName varchar(20) NOT NULL,unitAbbr varchar(20),propertyID varchar(20) references properties( propertyID));



create table containerObjects (objectID varchar(20) references objects(objectID) UNIQUE check(objectID like 'c%'),containerConcreteTypeId varchar(20) references containerConcreteTypes (containerConcreteTypeId),userLabel varchar(20),userObjectCommentLocal varchar(40));

create table nonContainerObjects (objectID varchar(20) references objects(objectID) unique check(objectID like 'nc%'),nonContainerConcreteTypeId varchar(20) references nonContainerConcreteTypes (nonContainerConcreteTypeId),userLabel varchar(20),userObjectCommentLocal varchar(40) check(objectID like 'nc%'));

create table directChild_parent (childID varchar(20) references types(typeID),parentID varchar(20) references containerConcreteTypes(containerConcreteTypeID) check(parentID like 'c%'),DisplacementAB integer check(DisplacementAB>0),DisplacementAD integer check(DisplacementAD>0),DisplacementAE integer check(DisplacementAE>0),orientation_RoofFace varchar(4) NOT NULL,primary key(childId, parentID));

create table nonContainerObjectProperties (objectID varchar(20) references nonContainerObjects(objectID),propertyID varchar(20) references properties(propertyID),propertyValue varchar(20) NOT NULL,measurementUnitID varchar(20) references unitList(unitID),userCommentLocal varchar(20),userLabel varchar(20),primary key(objectID, propertyID));

create table containerObjectProperties (objectID varchar(20) references containerObjects(objectID),propertyID varchar(20) references properties(propertyID),propertyValue varchar(20) NOT NULL,measurementUnitID varchar(20) references unitList(unitID),userCommentLocal varchar(20),userLabel varchar(20),primary key(objectID, propertyID));


insert into objects values ('nc1_beam'),('nc2_bench'),('nc3_swBoard'),('nc4_amplifier'),('nc5_woodenStage'),('c1_classRoom'),('c2_ampBox'),('c3_chlkBox'),('c4_table'),('c5_blackBox'),('c6_smlTable'),('c7_bigTable');

insert into abstractDoor values ('d1_classRoom',1000,2000,55,60,100),('d2_classRoom',1000,2000,55,60,100),('d3_classRoom',1000,2000,55,60,100),('d4_classRoom',1000,2000,55,60,100),('d5_blackBox',520,520,10,10,10),('d6_ampBox',740,48,50,50,20),('d7_chalkBox',90,90,120,100,30),('d8_table',1460,730,15,15,20),('d9_smlTable',480,100,15,15,20),('d10_bigTable',480,580,15,15,20);

insert into types values ('ct1','classRoom','upper_class_room'),('ct2','ampBox','glass_metal amp box'),('ct3','chalkBox',''),('ct4','table','woodenTable'),('ct5','balckBox','woodenBOx'),('ct6','smlTbl','table_small_compartment'),('ct7','bigTbl','table_big_compartment'),('nct1','beam','concrete beam'),('nct2','bench','wooden'),('nct3','swBoard','switchBoard'),('nct4','amplifier','electricAmp'),('nct5','stage','woodenStage');
insert into containerConcreteTypes values ('ct1',6380,13880,3460,280,'classroom'),('ct2',500,600,760,10,'ampBox'),('ct3',100,100,100,1,'chalkBox'),('ct4',1500,750,750,20,'table'),('ct5',540,540,600,10,'blackBOx'),('ct6',500,710,120,10,'smlTbl'),('ct7',500,710,590,10,'bigTbl');
insert into nonContainerConcreteTypes values ('nct1',6100,260,570,'beam'),('nct2',750,910,750,'bench'),('nct3',40,300,250,'switch'),('nct4',250,350,100,'amplifier'),('nct5',6100,2000,300,'stage');
insert into containerobjects values ('c1_classRoom','ct1','classroom'),('c2_ampBox','ct2','amplifierbox'),('c3_chlkBox','ct3','chalkbox'),('c4_table','ct4','table'),('c5_blackBox','ct5','blackBox'),('c6_smlTable','ct6','smallTblCmprtmnt'),('c7_bigTable','ct7','bigTblCmprtmnt');
insert into noncontainerobjects values ('nc1_beam','nct1','beam'),('nc2_bench','nct2','bench'),('nc3_swBoard','nct3','switch'),('nc4_amplifier', 'nct4','amplifier'),('nc5_woodenStage','nct5','stage');
insert into propertyTypes values ('pT1','boolean'),('pT2','number'),('pT3','list'),('pT4','date');
insert into properties values ('pr01','fragile','pT1',''),('pr02','weight','pT2',''),('pr03','temperature','pT2',''),('pr04','sideUP','pT3',''),('pr05','expiry','pT4',''),('pr06','humidity','pT2',''),('pr07','pressure','pT2',''),('pr08','waterDamage','pT1','');
insert into unitList values ('Uid01','isFrigile','bool','pr01'),('Uid02','kilogram','kg','pr02'),('Uid03','celceous','c','pr03'),('Uid04','checkSide','','pr04'),('Uid05','whichDate','exp','pr05'),('Uid06','metercube','mc','pr06'),('Uid07','pascal','pas','pr07'),('Uid08','isWtrDamage','YorN','pr08');
insert into containerobjectproperties values ('c1_classRoom','pr03','23','Uid02','','classroom'),('c2_ampBox','pr01','True','Uid01','','ampbox'),('c2_ampBox','pr08','True','Uid08','','ampbox'),('c3_chlkBox','pr04','ABFE','Uid04','','chalkBox'),('c3_chlkBox','pr01','True','Uid01','','chalkBox'),('c3_chlkBox','pr08','True','Uid08','','chalkBox'),('c5_blackBox','pr04','DCBA','Uid04','','table'),('c5_blackBox','pr07','75','Uid07','','blackbox');
insert into noncontainerobjectproperties values ('nc1_beam','pr01','False','Uid01','','beam'),('nc3_swBoard','pr01','False','Uid01','','switch'),('nc3_swBoard','pr08','True','Uid08','','switch'),('nc4_amplifier','pr04','ABCD', 'Uid04','','amplifier'),('nc4_amplifier','pr08','True','Uid08', '','amplifier'),('nc2_bench','pr04','DCBA','Uid04','','bench'),('nc2_bench','pr02','200','Uid02','','bench'),('nc5_woodenStage','pr04','ABCD','Uid04','','stage'),('nc5_woodenStage','pr02','700','Uid02','','stage');
insert into directchild_parent values ('nct1','ct1',1,1,2400,'ABCD'),('nct4','ct2',100,120,150,'ABCD'),('ct2','ct1',6099,650,2200,'DABC'),('nct3','ct1',1,4800,2300,'ABCD'),('nct2','ct1',1,4800,2420,'ABCD'),('ct4','ct1',4600,2400,2430,'ABCD'),('ct6','ct4',10,10,10,'ABCD'),('ct7','ct4',10,10,160,'ABCD'),('ct5','ct1',6080,20,2280,'DABC'),('nct5','ct1',6100,2000,2880,'CDAB');


insert into abstractWall values ('WC_RoomRoof',6380,13880,200,200,200,'RoomRoof'),('WC_RoomFloor',6380,13880,200,200,200,'RoomFloor'),('WC_RoomRight',13880,3460,200,200,200,'RoomRight'),('WC_RoomLeft',13880,3460,200,200,200,'RoomLeft'),('WC_RoomFront',3460,6380,200,200,200,'RoomFront'),('WC_RoomBack',3460,6380,200,200,200,'RoomBack'),('WC_AmpRoof',500,600,150,150,150,'AmpRoof'),('WC_AmpFloor',500,600,150,150,150,'AmpFloor'),('WC_AmpRight',600,760,150,150,150,'AmpRight'),('WC_AmpLeft',600,760,150,150,150,'AmpLeft'),('WC_AmpFront',760,500,150,150,150,'AmpFront'),('WC_AmpBack',760,500,150,150,150,'AmpBack'),('WC_chlkBoxRoof',100,100,0,0,255,'chlkBoxRoof'),('WC_chlkBoxFloor',100,100,0,0,255,'chlkBoxFloor'),('WC_chlkBoxRight',100,100,0,0,255,'chlkBoxRight'),('WC_chlkBoxLeft',100,100,0,0,255,'chlkBoxLeft'),('WC_chlkBoxFront',100,100,0,0,255,'chlkBoxFront'),('WC_chlkBoxBack',100,100,0,0,255,'chlkBoxBack'),('WC_TableRoof',1500,750,0,0,255,'TableRoof'),('WC_TableFloor',1500,750,0,0,255,'TableFloor'),('WC_TableRight',750,750,0,0,255,'TableRight'),('WC_TableLeft',750,750,0,0,255,'TableLeft'),('WC_TableFront',750,1500,0,0,255,'TableFront'),('WC_TableBack',750,1500,0,0,255,'TableBack'),('WC_BlackBoxRoof',540,540,20,20,20,'BlackBoxRoof'),('WC_BlackBoxFloor',540,540,20,20,20,'BlackBoxFloor'),('WC_BlackBoxRight',540,600,20,20,20,'BlackBoxRight'),('WC_BlackBoxLeft',540,600,20,20,20,'BlackBoxLeft'),('WC_BlackBoxFront',600,540,150,150,150,'BlackBoxFront'),('WC_BlackBoxBack',600,540,150,150,150,'BlackBoxBack'),

('WC_SmlTableRoof',500,710,0,0,255,'SmlTableRoof'),('WC_SmlTableFloor',500,710,0,0,255,'SmlTableFloor'),('WC_SmlTableRight',710,120,0,0,255,'SmlTableRight'),('WC_SmlTableLeft',710,120,0,0,255,'SmlTableLeft'),('WC_SmlTableFront',120,500,0,0,255,'SmlTableFront'),('WC_SmlTableBack',120,500,0,0,255,'SmlTableBack'),

('WC_BigTableRoof',500,710,0,0,255,'BigTableRoof'),('WC_BigTableFloor',500,710,0,0,255,'BigTableFloor'),('WC_BigTableRight',710,590,0,0,255,'BigTableRight'),('WC_BigTableLeft',710,590,0,0,255,'BigTableLeft'),('WC_BigTableFront',590,500,0,0,255,'BigTableFront'),('WC_BigTableBack',590,500,0,0,255,'BigTableBack'),

('WNC_BeamRoof',6100,260,200,200,200,'BeamRoof'),('WNC_BeamFloor',6100,260,200,200,200,'BeamFloor'),('WNC_BeamRight',260,570,200,200,200,'BeamRight'),('WNC_BeamLeft',260,570,200,200,200,'BeamLeft'),('WNC_BeamFront',570,6100,200,200,200,'BeamFront'),('WNC_BeamBack',570,6100,200,200,200,'BeamBack'),('WNC_BenchRoof',750,910,218,165,32,'BenchRoof'),('WNC_BenchFloor',750,910,218,165,32,'BenchFloor'),('WNC_BenchRight',910,750,255,250,205,'BenchRight'),('WNC_BenchLeft',910,750,255,250,205,'BenchLeft'),('WNC_BenchFront',750,750,255,250,205,'BenchFront'),('WNC_BenchBack',750,750,255,250,205,'BenchBack'),('WNC_SwitchRoof',40,300,211,211,211,'SwitchRoof'),('WNC_SwitchFloor',40,300,211,211,211,'SwitchFloor'),('WNC_SwitchRight',300,250,211,211,211,'SwitchRight'),('WNC_SwitchLeft',300,250,211,211,211,'SwitchLeft'),('WNC_SwitchFront',250,40,211,211,211,'SwitchFront'),('WNC_SwitchBack',250,40,211,211,211,'SwitchBack'),('WNC_AmplifierRoof',250,350,5,5,5,'AmplifierRoof'),('WNC_AmplifierFloor',250,350,5,5,5,'AmplifierFloor'),('WNC_AmplifierRight',350,100,5,5,5,'AmplifierRight'),('WNC_AmplifierLeft',350,100,5,5,5,'AmplifierLeft'),('WNC_AmplifierFront',100,250,5,5,5,'AmplifierFront'),('WNC_AmplifierBack',100,250,5,5,5,'AmplifierBack'),('WNC_StageRoof',6100,2000,205,205,205,'StageRoof'),('WNC_StageFloor',6100,2000,205,205,205,'StageFloor'),('WNC_StageRight',2000,300,205,205,205,'StageRight'),('WNC_StageLeft',2000,300,205,205,205,'StageLeft'),('WNC_StageFront',300,6100,205,205,205,'StageFront'),('WNC_StageBack',300,6100,205,205,205,'StageBack');


insert into walldoor values ('WC_RoomFront','d1_classRoom',200,200,'ABCD'),('WC_RoomFront','d2_classRoom',250,200,'DABC'),('WC_RoomFront','d3_classRoom',13590,200,'DABC'),('WC_AmpFront','d6_ampBox',10,10,'ABCD'),('WC_TableBack','d8_table',20,20,'DCBA'),('WC_chlkBoxRoof','d7_chalkBox',1,1,'ABCD'),('WC_BlackBoxRight','d5_blackBox',10,10,'DCBA'),('WC_SmlTableRoof','d9_smlTable',1,1,'ABCD'),('WC_BigTableFront','d10_bigTable',1,1,'ABCD');

insert into containerConcretetypefaces values ('ct1','WC_RoomRoof','WC_RoomFloor','WC_RoomRight','WC_RoomLeft','WC_RoomFront','WC_RoomBack'),('ct2','WC_AmpRoof','WC_AmpFloor','WC_AmpRight','WC_AmpLeft','WC_AmpFront','WC_AmpBack'),('ct3','WC_chlkBoxRoof','WC_chlkBoxFloor','WC_chlkBoxLeft','WC_chlkBoxRight','WC_chlkBoxFront','WC_chlkBoxBack'),('ct4','WC_TableRoof','WC_TableFloor','WC_TableLeft','WC_TableRight','WC_TableFront','WC_TableBack'),('ct5','WC_BlackBoxRoof','WC_BlackBoxFloor','WC_BlackBoxLeft','WC_BlackBoxRight','WC_BlackBoxFront','WC_BlackBoxBack'),('ct6','WC_SmlTableRoof','WC_SmlTableFloor','WC_SmlTableLeft','WC_SmlTableRight','WC_SmlTableFront','WC_SmlTableBack'),('ct7','WC_BigTableRoof','WC_BigTableFloor','WC_BigTableLeft','WC_BigTableRight','WC_BigTableFront','WC_BigTableBack');
insert into noncontainerConcretetypefaces values ('nct1','WNC_BeamRoof','WNC_BeamFloor','WNC_BeamRight','WNC_BeamLeft','WNC_BeamFront','WNC_BeamBack'),('nct2','WNC_BenchRoof','WNC_BenchFloor','WNC_BenchRight','WNC_BenchLeft','WNC_BenchFront','WNC_BenchBack'),('nct3','WNC_SwitchRoof','WNC_SwitchFloor','WNC_SwitchRight','WNC_SwitchLeft','WNC_SwitchFront','WNC_SwitchBack'),('nct4','WNC_AmplifierRoof','WNC_AmplifierFloor','WNC_AmplifierRight','WNC_AmplifierLeft','WNC_AmplifierFront','WNC_AmplifierBack'),('nct5','WNC_StageRoof','WNC_StageFloor','WNC_StageRight','WNC_StageLeft','WNC_StageFront','WNC_StageBack');

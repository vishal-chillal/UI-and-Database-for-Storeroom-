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


create table objects (objectID varchar(10) primary key check(objectID like 'nc%' OR objectID like 'c%'));

create table types (typeID varchar(10) primary key check(typeID like 'nct%' OR typeID like 'ct%'),typeName varchar(20) NOT NULL,description varchar(40));

create table containerConcreteTypes (containerConcreteTypeId varchar(10) references types(typeID) UNIQUE check(containerConcreteTypeID like 'ct%'),containerLengthAB integer check(containerLengthAB>0),containerLengthAD integer check(containerLengthAD>0),containerLengthAE integer check(containerLengthAE>0),containerThickness integer check(containerThickness>0),userObjectCommentGlobal varchar(40));

create table abstractDoor(doorID varchar(10) primary key check(doorID like 'd%'),doorLengthAB integer check(DoorLengthAB>0),doorLengthAD integer check(DoorLengthAD>0),doorColorR integer check(doorColorR>=0 AND doorColorR<=255),doorColorG integer check(doorColorG>=0 AND doorColorG<=255),doorColorB integer check(doorColorB>=0 AND doorColorB<=255));

create table abstractWall(WallID varchar(10) primary key,WallLengthAB integer check(WallLengthAB>0),WallLengthAD integer check(WallLengthAD>0),WallColorR integer check(WallColorR>=0 AND WallColorR<=255),WallColorG integer check(WallColorG>=0 AND WallColorG<=255),WallColorB integer check(WallColorB>=0 AND WallColorB<=255),userWallComment varchar(40));

create table WallDoor(wallID varchar(10) references abstractWall(WallID),doorID varchar(10) references abstractDoor(doorID) UNIQUE,DisplacementAB integer check(DisplacementAB>0),DisplacementAD integer check(DisplacementAD>0),orientation varchar(4) check(orientation like 'ABCD' OR orientation like 'ABCD' OR orientation like 'ABCD' OR orientation like 'ABCD' OR orientation like 'DCBA' OR orientation like 'DABC' OR orientation like 'CBAD' ),primary key(wallID,doorID));    

create table containerConcreteTypeFaces (containerConcreteTypeId varchar(10) references containerConcreteTypes (containerConcreteTypeId) UNIQUE,containerConcreteRoof varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,containerConcreteFloor varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,containerConcreteRight varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,containerConcreteLeft varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,containerConcreteFront varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,containerConcreteBack varchar(10) references abstractWall (WallID) NOT NULL UNIQUE);

create table nonContainerConcreteTypes (nonContainerConcreteTypeId varchar(10) references types(typeID) UNIQUE check(nonContainerConcreteTypeID like 'nct%'),nonContainerLengthAB integer check(nonContainerLengthAB>0),nonContainerLengthAD integer check(nonContainerLengthAD>0),nonContainerLengthAE integer check(nonContainerLengthAE>0),userObjectCommentGlobal varchar(10));

create table nonContainerConcreteTypeFaces (nonContainerConcreteTypeId varchar(10) references nonContainerConcreteTypes(nonContainerConcreteTypeId) UNIQUE,nonContainerConcreteRoof varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,nonContainerConcreteFloor varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,nonContainerConcreteRight varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,nonContainerConcreteLeft varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,nonContainerConcreteFront varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,nonContainerConcreteBack varchar(10) references abstractWall (WallID) NOT NULL UNIQUE);

create table propertyTypes (propertyType varchar(10) primary key check(propertyType like 'pT%'),userDescription varchar(40));

create table properties (propertyID varchar(10) primary key check(propertyID like 'pr0%'),propertyName varchar(15) NOT NULL,propertyType varchar(10) references propertyTypes(propertyType),userDescription varchar(40));

create table unitList (unitID varchar(15) primary key check(unitID like 'Uid0%'),unitName varchar(20) NOT NULL,unitAbbr varchar(10),propertyID varchar(10) references properties( propertyID));



create table containerObjects (objectID varchar(10) references objects(objectID) UNIQUE check(objectID like 'c%'),containerConcreteTypeId varchar(10) references containerConcreteTypes (containerConcreteTypeId),userLabel varchar(20),userObjectCommentLocal varchar(40));--objectId should be of container

create table nonContainerObjects (objectID varchar(10) references objects(objectID) unique check(objectID like 'nc%'),nonContainerConcreteTypeId varchar(10) references nonContainerConcreteTypes (nonContainerConcreteTypeId),userLabel varchar(20),userObjectCommentLocal varchar(40) check(objectID like 'nc%'));--objectId should be of container

create table directChild_parent (childID varchar(10) references types(typeID),parentID varchar(10) references containerConcreteTypes(containerConcreteTypeID) check(parentID like 'c%'),DisplacementAB integer check(DisplacementAB>0),DisplacementAD integer check(DisplacementAD>0),DisplacementAE integer check(DisplacementAE>0),orientation_RoofFace varchar(4) NOT NULL,primary key(childId, parentID));

create table nonContainerObjectProperties (objectID varchar(10) references nonContainerObjects(objectID),propertyID varchar(10) references properties(propertyID),propertyValue varchar(10) NOT NULL,measurementUnitID varchar(10) references unitList(unitID),userCommentLocal varchar(10),userLabel varchar(10),primary key(objectID, propertyID));

create table containerObjectProperties (objectID varchar(10) references containerObjects(objectID),propertyID varchar(10) references properties(propertyID),propertyValue varchar(10) NOT NULL,measurementUnitID varchar(10) references unitList(unitID),userCommentLocal varchar(10),userLabel varchar(10),primary key(objectID, propertyID));

insert into objects values ('nc1'),('nc2'),('nc3'),('nc4'),('nc5'),('c1'),('c2'),('c3'),('c4'),('c5'),('c6'),('c7');
insert into abstractDoor values ('d1',1000,2000,55,60,100),('d2',1000,2000,55,60,100),('d3',1000,2000,55,60,100),('d4',1000,2000,55,60,100),('d5',520,520,10,10,10),('d6',740,48,50,50,20),('d7',90,90,120,100,30),('d8',1460,730,15,15,20),('d9',480,100,15,15,20),('d10',480,580,15,15,20);
insert into types values ('ct1','classRoom','upper_class_room'),('ct2','ampBox','glass_metal amp box'),('ct3','chalkBox',''),('ct4','table','woodenTable'),('ct5','balckBox','woodenBOx'),('ct6','smlTbl','table_small_compartment'),('ct7','bigTbl','table_big_compartment'),('nct1','beam','concrete beam'),('nct2','bench','wooden'),('nct3','swBoard','switchBoard'),('nct4','amplifier','electricAmp'),('nct5','stage','woodenStage');
insert into containerConcreteTypes values ('ct1',6380,13880,3460,280,'classroom'),('ct2',500,600,760,10,'ampBox'),('ct3',100,100,100,1,'chalkBox'),('ct4',1500,750,750,20,'table'),('ct5',540,540,600,10,'blackBOx'),('ct6',500,710,120,10,'smlTbl'),('ct7',500,710,590,10,'bigTbl');
insert into nonContainerConcreteTypes values ('nct1',6100,260,570,'beam'),('nct2',750,910,750,'bench'),('nct3',40,300,250,'switch'),('nct4',250,350,100,'amplifier'),('nct5',6100,2000,300,'stage');
insert into containerobjects values ('c1','ct1','classroom'),('c2','ct2','amplifierbox'),('c3','ct3','chalkbox'),('c4','ct4','table'),('c5','ct5','blackBox'),('c6','ct6','smallTblCmprtmnt'),('c7','ct7','bigTblCmprtmnt');
insert into noncontainerobjects values ('nc1','nct1','beam'),('nc2','nct2','bench'),('nc3','nct3','switch'),('nc4', 'nct4','amplifier'),('nc5','nct5','stage');
insert into propertyTypes values ('pT1','boolean'),('pT2','number'),('pT3','list'),('pT4','date');
insert into properties values ('pr01','fragile','pT1',''),('pr02','weight','pT2',''),('pr03','temperature','pT2',''),('pr04','sideUP','pT3',''),('pr05','expiry','pT4',''),('pr06','humidity','pT2',''),('pr07','pressure','pT2',''),('pr08','waterDamage','pT1','');
insert into unitList values ('Uid01','isFrigile','bool','pr01'),('Uid02','kilogram','kg','pr02'),('Uid03','celceous','c','pr03'),('Uid04','checkSide','','pr04'),('Uid05','whichDate','exp','pr05'),('Uid06','metercube','mc','pr06'),('Uid07','pascal','pas','pr07'),('Uid08','isWtrDamage','YorN','pr08');
insert into containerobjectproperties values ('c1','pr03','23','Uid02','','classroom'),('c2','pr01','True','Uid01','','ampbox'),('c2','pr08','True','Uid08','','ampbox'),('c3','pr04','ABFE','Uid04','','chalkBox'),('c3','pr01','True','Uid01','','chalkBox'),('c3','pr08','True','Uid08','','chalkBox'),('c4','pr04','DCBA','Uid04','','table'),('c5','pr07','75','Uid07','','blackbox');
insert into noncontainerobjectproperties values ('nc1','pr01','False','Uid01','','beam'),('nc3','pr01','False','Uid01','','switch'),('nc3','pr08','True','Uid08','','switch'),('nc4','pr04','ABCD', 'Uid04','','amplifier'),('nc4','pr08','True','Uid08', '','amplifier'),('nc2','pr04','DCBA','Uid04','','bench'),('nc2','pr02','200','Uid02','','bench'),('nc5','pr04','ABCD','Uid04','','stage'),('nc5','pr02','700','Uid02','','stage');
insert into directchild_parent values ('nct1','ct1',1,1,2400,'ABCD'),('nct4','ct2',100,120,150,'ABCD'),('ct2','ct1',6099,650,2200,'DABC'),('nct3','ct1',1,4800,2300,'ABCD'),('nct2','ct1',1,4800,2420,'ABCD'),('ct4','ct1',4600,2400,2430,'ABCD'),('ct6','ct4',10,10,10,'ABCD'),('ct7','ct4',10,10,160,'ABCD'),('ct5','ct1',6080,20,2280,'DABC'),('nct5','ct1',6100,2000,2880,'CDAB');
insert into abstractWall values ('WC101',6380,13880,200,200,200,'RoomRoof'),('WC102',6380,13880,200,200,200,'RoomFloor'),('WC103',13880,3460,200,200,200,'RoomRight'),('WC104',13880,3460,200,200,200,'RoomLeft'),('WC105',3460,6380,200,200,200,'RoomFront'),('WC106',3460,6380,200,200,200,'RoomBack'),('WC201',500,600,150,150,150,'AmpRoof'),('WC202',500,600,150,150,150,'AmpFloor'),('WC203',600,760,150,150,150,'AmpRight'),('WC204',600,760,150,150,150,'AmpLeft'),('WC205',760,500,150,150,150,'AmpFront'),('WC206',760,500,150,150,150,'AmpBack'),('WC301',100,100,0,0,255,'chlkBoxRoof'),('WC302',100,100,0,0,255,'chlkBoxFloor'),('WC303',100,100,0,0,255,'chlkBoxRight'),('WC304',100,100,0,0,255,'chlkBoxLeft'),('WC305',100,100,0,0,255,'chlkBoxFront'),('WC306',100,100,0,0,255,'chlkBoxBack'),('WC401',1500,750,0,0,255,'TableRoof'),('WC402',1500,750,0,0,255,'TableFloor'),('WC403',750,750,0,0,255,'TableRight'),('WC404',750,750,0,0,255,'TableLeft'),('WC405',750,1500,0,0,255,'TableFront'),('WC406',750,1500,0,0,255,'TableBack'),('WC501',540,540,20,20,20,'BlackBoxRoof'),('WC502',540,540,20,20,20,'BlackBoxFloor'),('WC503',540,600,20,20,20,'BlackBoxRight'),('WC504',540,600,20,20,20,'BlackBoxLeft'),('WC505',600,540,150,150,150,'BlackBoxFront'),('WC506',600,540,150,150,150,'BlackBoxBack'),('WC601',500,710,0,0,255,'SmlTableRoof'),('WC602',500,710,0,0,255,'SmlTableFloor'),('WC603',710,120,0,0,255,'SmlTableRight'),('WC604',710,120,0,0,255,'SmlTableLeft'),('WC605',120,500,0,0,255,'SmlTableFront'),('WC606',120,500,0,0,255,'SmlTableBack'),('WC701',500,710,0,0,255,'SmlTableRoof'),('WC702',500,710,0,0,255,'SmlTableFloor'),('WC703',710,590,0,0,255,'SmlTableRight'),('WC704',710,590,0,0,255,'SmlTableLeft'),('WC705',590,500,0,0,255,'SmlTableFront'),('WC706',590,500,0,0,255,'SmlTableBack'),('WNC101',6100,260,200,200,200,'BeamRoof'),('WNC102',6100,260,200,200,200,'BeamFloor'),('WNC103',260,570,200,200,200,'BeamRight'),('WNC104',260,570,200,200,200,'BeamLeft'),('WNC105',570,6100,200,200,200,'BeamFront'),('WNC106',570,6100,200,200,200,'BeamBack'),('WNC201',750,910,218,165,32,'BenchRoof'),('WNC202',750,910,218,165,32,'BenchFloor'),('WNC203',910,750,255,250,205,'BenchRight'),('WNC204',910,750,255,250,205,'BenchLeft'),('WNC205',750,750,255,250,205,'BenchFront'),('WNC206',750,750,255,250,205,'BenchBack'),('WNC301',40,300,211,211,211,'SwitchRoof'),('WNC302',40,300,211,211,211,'SwitchFloor'),('WNC303',300,250,211,211,211,'SwitchRight'),('WNC304',300,250,211,211,211,'SwitchLeft'),('WNC305',250,40,211,211,211,'SwithcFront'),('WNC306',250,40,211,211,211,'SwitchBack'),('WNC401',250,350,5,5,5,'AmplifierRoof'),('WNC402',250,350,5,5,5,'AmplifierFloor'),('WNC403',350,100,5,5,5,'AmplifierRight'),('WNC404',350,100,5,5,5,'AmplifierLeft'),('WNC405',100,250,5,5,5,'AmplifierFront'),('WNC406',100,250,5,5,5,'AmplifierBack'),('WNC501',6100,2000,205,205,205,'StageRoof'),('WNC502',6100,2000,205,205,205,'StageFloor'),('WNC503',2000,300,205,205,205,'StageRight'),('WNC504',2000,300,205,205,205,'StageLeft'),('WNC505',300,6100,205,205,205,'StageFront'),('WNC506',300,6100,205,205,205,'StageBack');
insert into walldoor values ('WC105','d1',200,200,'ABCD'),('WC105','d2',250,200,'DABC'),('WC105','d3',13590,200,'DABC'),('WC205','d6',10,10,'ABCD'),('WC406','d8',20,20,'DCBA'),('WC301','d7',1,1,'ABCD'),('WC503','d5',10,10,'DCBA'),('WC601','d9',1,1,'ABCD'),('WC706','d10',1,1,'ABCD');
insert into containerConcretetypefaces values ('ct1','WC101','WC102','WC103','WC104','WC105','WC106'),('ct2','WC201','WC202','WC203','WC204','WC205','WC206'),('ct3','WC301','WC302','WC303','WC304','WC305','WC306'),('ct4','WC401','WC402','WC403','WC404','WC405','WC406'),('ct5','WC501','WC502','WC503','WC504','WC505','WC506'),('ct6','WC601','WC602','WC603','WC604','WC605','WC606'),('ct7','WC701','WC702','WC703','WC704','WC705','WC706');
insert into noncontainerConcretetypefaces values ('nct1','WNC101','WNC102','WNC103','WNC104','WNC105','WNC106'),('nct2','WNC201','WNC202','WNC203','WNC204','WNC205','WNC206'),('nct3','WNC301','WNC302','WNC303','WNC304','WNC305','WNC306'),('nct4','WNC401','WNC402','WNC403','WNC404','WNC405','WNC406'),('nct5','WNC501','WNC502','WNC503','WNC504','WNC505','WNC506');

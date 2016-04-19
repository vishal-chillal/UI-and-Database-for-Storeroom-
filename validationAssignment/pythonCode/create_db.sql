/*
VAlidations:
1. Check constraints on ID names,Dimensions,RGB values,Orientations.
2. One object cannot be child of two parent.
3. Uniqueness Off wall withing that column.

Total No Of Tables: 17
*/


drop table IF EXISTS directChild_parent CASCADE;
drop table IF EXISTS nonContainerObjectProperties CASCADE;
drop table IF EXISTS nonContainerObjects CASCADE;
drop table IF EXISTS containerObjectProperties CASCADE;
drop table IF EXISTS containerObjects CASCADE;
drop table IF EXISTS unitList CASCADE;
drop table IF EXISTS properties CASCADE;
drop table IF EXISTS containerConcreteTypeFaces CASCADE; 
drop table IF EXISTS containerConcreteTypes CASCADE;
drop table IF EXISTS nonContainerConcreteTypeFaces CASCADE; 
drop table IF EXISTS nonContainerConcreteTypes CASCADE;
drop table IF EXISTS types CASCADE;
drop table IF EXISTS objects CASCADE;
drop table IF EXISTS propertyTypes CASCADE;
drop table IF EXISTS WallDoor CASCADE;
drop table IF EXISTS abstractWall CASCADE;
drop table IF EXISTS abstractDoor CASCADE;


--Only allow objectID which starts from 'c':Container  or 'nc':NonContainer
create table objects(objectID varchar(10) primary key check(objectID like 'nc%' OR objectID like 'c%'));

--Only allow typeID which starts from 'ct':typeContainer  or 'nct':typeNonContainer
create table types(
typeID varchar(10) primary key check(typeID like 'nct%' OR typeID like 'ct%'),
typeName varchar(20) NOT NULL,
description varchar(40));

--Only allow typeID which starts from 'd'
--Dimesions must be positive integers
--R,G,B values must bbe in the range from 0 to 255
create table abstractDoor(
doorID varchar(10) primary key check(doorID like 'd%'),
doorLengthAB integer check(DoorLengthAB>0),
doorLengthAD integer check(DoorLengthAD>0),
doorColorR integer check(doorColorR>=0 AND doorColorR<=255),
doorColorG integer check(doorColorG>=0 AND doorColorG<=255),
doorColorB integer check(doorColorB>=0 AND doorColorB<=255));

--Only allow typeID which starts from 'WC':containerWalls or 'WNC':nonContainerWalls
--Dimesions must be positive integers
--R,G,B values must bbe in the range from 0 to 255
create table abstractWall(
WallID varchar(10) primary key check(WallID like 'WC%' or WallID like 'WNC%'),
WallLengthAB integer check(WallLengthAB>0),
WallLengthAD integer check(WallLengthAD>0),
WallColorR integer check(WallColorR>=0 AND WallColorR<=255),
WallColorG integer check(WallColorG>=0 AND WallColorG<=255),
WallColorB integer check(WallColorB>=0 AND WallColorB<=255),
userWallComment varchar(40));

--Wall must be from a conntainer
--Door must be unique
--Displacement of door must be positive integer and Orientation must be within the given pattern
create table WallDoor(
doorID varchar(10) references abstractDoor(doorID) ON UPDATE CASCADE ON DELETE CASCADE UNIQUE,
wallID varchar(10) references abstractWall(WallID) ON UPDATE CASCADE ON DELETE CASCADE check(WallID like 'WC%'),
primary key(wallID,doorID),
DisplacementAB integer check(DisplacementAB>0),
DisplacementAD integer check(DisplacementAD>0),
orientation varchar(4) check(orientation like 'ABCD' OR orientation like 'BCDA' OR orientation like 'CDAB' OR orientation like 'DABC'));

--Only allow containerConcreteTypeId which starts from 'ct':typeContainer, No repetation
--All dimensions must be positive integer
create table containerConcreteTypes(
containerConcreteTypeId varchar(10) references types(typeID) UNIQUE check(containerConcreteTypeID like 'ct%'),
containerLengthAB integer check(containerLengthAB>0),
containerLengthAD integer check(containerLengthAD>0),
containerLengthAE integer check(containerLengthAE>0),
containerThickness integer check(containerThickness>0),
userObjectCommentGlobal varchar(40));


create table containerConcreteTypeFaces(
containerConcreteTypeId varchar(10) references containerConcreteTypes (containerConcreteTypeId) UNIQUE,
containerConcreteRoof varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
containerConcreteFloor varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
containerConcreteRight varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
containerConcreteLeft varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
containerConcreteFront varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
containerConcreteBack varchar(10) references abstractWall (WallID) NOT NULL UNIQUE);

create table nonContainerConcreteTypes(
nonContainerConcreteTypeId varchar(10) references types(typeID) UNIQUE check(nonContainerConcreteTypeID like 'nct%'),
nonContainerLengthAB integer check(nonContainerLengthAB>0),
nonContainerLengthAD integer check(nonContainerLengthAD>0),
nonContainerLengthAE integer check(nonContainerLengthAE>0),
userObjectCommentGlobal varchar(10));

create table nonContainerConcreteTypeFaces(
nonContainerConcreteTypeId varchar(10) references nonContainerConcreteTypes(nonContainerConcreteTypeId) UNIQUE,
nonContainerConcreteRoof varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
nonContainerConcreteFloor varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
nonContainerConcreteRight varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
nonContainerConcreteLeft varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
nonContainerConcreteFront varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
nonContainerConcreteBack varchar(10) references abstractWall (WallID) NOT NULL UNIQUE);

create table propertyTypes(
propertyType varchar(10) primary key check(propertyType like 'pT%'),
userDescription varchar(40));

create table properties(
propertyID varchar(10) primary key check(propertyID like 'pr0%'),
propertyName varchar(15) NOT NULL,propertyType varchar(10) references propertyTypes(propertyType),
userDescription varchar(40));

create table unitList(
unitID varchar(15) primary key check(unitID like 'Uid0%'),
unitName varchar(20) NOT NULL,unitAbbr varchar(10),
propertyID varchar(10) references properties( propertyID));

create table containerObjects(
objectID varchar(10) references objects(objectID) UNIQUE check(objectID like 'c%'),--objectId should be of container
containerConcreteTypeId varchar(10) references containerConcreteTypes (containerConcreteTypeId),
userLabel varchar(20),userObjectCommentLocal varchar(40));

create table nonContainerObjects(
objectID varchar(10) references objects(objectID) unique check(objectID like 'nc%'),--objectId should be of container
nonContainerConcreteTypeId varchar(10) references nonContainerConcreteTypes (nonContainerConcreteTypeId),
userLabel varchar(20),userObjectCommentLocal varchar(40) check(objectID like 'nc%'));

create table directChild_parent (childID varchar(10) references types(typeID),parentID varchar(10) references containerConcreteTypes(containerConcreteTypeID) check(parentID like 'c%'),DisplacementAB integer check(DisplacementAB>0),DisplacementAD integer check(DisplacementAD>0),DisplacementAE integer check(DisplacementAE>0),orientation_RoofFace varchar(4) NOT NULL,primary key(childId, parentID));

create table nonContainerObjectProperties (objectID varchar(10) references nonContainerObjects(objectID),propertyID varchar(10) references properties(propertyID),propertyValue varchar(10) NOT NULL,measurementUnitID varchar(10) references unitList(unitID),userCommentLocal varchar(10),userLabel varchar(10),primary key(objectID, propertyID));

create table containerObjectProperties (objectID varchar(10) references containerObjects(objectID),propertyID varchar(10) references properties(propertyID),propertyValue varchar(10) NOT NULL,measurementUnitID varchar(10) references unitList(unitID),userCommentLocal varchar(10),userLabel varchar(10),primary key(objectID, propertyID));

create or replace function checkContainerWall() returns trigger as $checkContainerWall$
begin
	declare w integer;
	begin
		if(select count(*) from containerconcretetypefaces v1 where

		       	(v1.containerconcreteroof ~* new.containerconcretefloor) or (v1.containerconcreteroof ~* new.containerconcreteleft) or (v1.containerconcreteroof ~* new.containerconcreteright) or (v1.containerconcreteroof ~* new.containerconcretefront) or (v1.containerconcreteroof ~* new.containerconcreteback) or

		       	(v1.containerconcretefloor ~* new.containerconcreteroof) or (v1.containerconcretefloor ~* new.containerconcreteleft) or (v1.containerconcretefloor ~* new.containerconcreteright) or (v1.containerconcretefloor ~* new.containerconcretefront) or (v1.containerconcretefloor ~* new.containerconcreteback) or

		       	(v1.containerconcreteright ~* new.containerconcreteroof) or (v1.containerconcreteright ~* new.containerconcretefloor) or (v1.containerconcreteright ~* new.containerconcreteleft) or (v1.containerconcreteright ~* new.containerconcretefront) or (v1.containerconcreteright ~* new.containerconcreteback) or

		       	(v1.containerconcreteroof ~* new.containerconcreteroof) or (v1.containerconcreteroof ~* new.containerconcretefloor) or (v1.containerconcreteroof ~* new.containerconcreteright) or (v1.containerconcreteroof ~* new.containerconcretefront) or (v1.containerconcreteroof ~* new.containerconcreteback)or

		       	(v1.containerconcretefront ~* new.containerconcreteroof) or (v1.containerconcretefront ~* new.containerconcretefloor) or (v1.containerconcretefront ~* new.containerconcreteleft) or (v1.containerconcretefront ~* new.containerconcreteright) or (v1.containerconcretefront ~* new.containerconcreteback)or

		       	(v1.containerconcreteback ~* new.containerconcreteroof) or (v1.containerconcreteback ~* new.containerconcretefloor) or (v1.containerconcreteback ~* new.containerconcreteleft) or (v1.containerconcreteback ~* new.containerconcreteright) or (v1.containerconcreteback ~* new.containerconcretefront) 
		)>0  then
			raise exception 'wall already exists';	
		end if;
		Return New;
	End;
	End;
	$checkContainerWall$ Language Plpgsql;

	Create Trigger checkContainerWall before insert on containerconcretetypefaces for each row execute procedure checkContainerWall();

create or replace function checkNonContWall() returns trigger as $checkNonContWall$
begin
	declare w integer;
	begin
		if(select count(*) from nonContainerconcretetypefaces v1 where

		       	(v1.nonContainerconcreteroof ~* new.nonContainerconcretefloor) or (v1.nonContainerconcreteroof ~* new.nonContainerconcreteleft) or (v1.nonContainerconcreteroof ~* new.nonContainerconcreteright) or (v1.nonContainerconcreteroof ~* new.nonContainerconcretefront) or (v1.nonContainerconcreteroof ~* new.nonContainerconcreteback) or

		       	(v1.nonContainerconcretefloor ~* new.nonContainerconcreteroof) or (v1.nonContainerconcretefloor ~* new.nonContainerconcreteleft) or (v1.nonContainerconcretefloor ~* new.nonContainerconcreteright) or (v1.nonContainerconcretefloor ~* new.nonContainerconcretefront) or (v1.nonContainerconcretefloor ~* new.nonContainerconcreteback) or

		       	(v1.nonContainerconcreteright ~* new.nonContainerconcreteroof) or (v1.nonContainerconcreteright ~* new.nonContainerconcretefloor) or (v1.nonContainerconcreteright ~* new.nonContainerconcreteleft) or (v1.nonContainerconcreteright ~* new.nonContainerconcretefront) or (v1.nonContainerconcreteright ~* new.nonContainerconcreteback) or

		       	(v1.nonContainerconcreteroof ~* new.nonContainerconcreteroof) or (v1.nonContainerconcreteroof ~* new.nonContainerconcretefloor) or (v1.nonContainerconcreteroof ~* new.nonContainerconcreteright) or (v1.nonContainerconcreteroof ~* new.nonContainerconcretefront) or (v1.nonContainerconcreteroof ~* new.nonContainerconcreteback)or

		       	(v1.nonContainerconcretefront ~* new.nonContainerconcreteroof) or (v1.nonContainerconcretefront ~* new.nonContainerconcretefloor) or (v1.nonContainerconcretefront ~* new.nonContainerconcreteleft) or (v1.nonContainerconcretefront ~* new.nonContainerconcreteright) or (v1.nonContainerconcretefront ~* new.nonContainerconcreteback)or

		       	(v1.nonContainerconcreteback ~* new.nonContainerconcreteroof) or (v1.nonContainerconcreteback ~* new.nonContainerconcretefloor) or (v1.nonContainerconcreteback ~* new.nonContainerconcreteleft) or (v1.nonContainerconcreteback ~* new.nonContainerconcreteright) or (v1.nonContainerconcreteback ~* new.nonContainerconcretefront) 
		)>0  then
			raise exception 'wall already exists';	
		end if;
		Return New;
	End;
	End;
	$checkNonContWall$ Language Plpgsql;

	Create Trigger checkNonContWall before insert on nonContainerconcretetypefaces for each row execute procedure checkNonContWall();
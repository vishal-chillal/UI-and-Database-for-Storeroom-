create table objects(
    objectID varchar(10) primary key check(objectID like 'nc%' OR objectID like 'c%')
);--objectID for container should start with c and container should start with nc

create table types(
    typeID varchar(10) primary key check(typeID like 'nct%' OR typeID like 'ct%'),
    typeName varchar(20) NOT NULL,
    description varchar(40)
);--typeID for container should start with ct and container should start with nct

create table containerConcreteTypes (
    containerConcreteTypeId varchar(10) references types(typeID) UNIQUE check(containerConcreteTypeID like 'ct%'),
    containerLengthAB integer check(containerLengthAB>0), 
    containerLengthAD integer check(containerLengthAD>0), 
    containerLengthAE integer check(containerLengthAE>0), 
    containerThickness integer check(containerThickness>0), 
    userObjectCommentGlobal varchar(40)
    
);--containerConcreteTypeID should be of container type and all length should be non zero

create table abstractDoor(
    doorID varchar(10) primary key check(doorID like 'd%'),
    doorLengthAB integer check(DoorLengthAB>0),
    doorLengthAD integer check(DoorLengthAD>0),
    doorColorR integer check(doorColorR>=0 AND doorColorR<=255),
    doorColorG integer check(doorColorG>=0 AND doorColorG<=255),
    doorColorB integer check(doorColorB>=0 AND doorColorB<=255)
);--doorId should start with d and color values should be in valid range and all lengths must be non zero

create table abstractWall(
    WallID varchar(10) primary key, --check(WallID like 'w%'),
    WallLengthAB integer check(WallLengthAB>0),
    WallLengthAD integer check(WallLengthAD>0),
    WallColorR integer check(WallColorR>=0 AND WallColorR<=255),
    WallColorG integer check(WallColorG>=0 AND WallColorG<=255),
    WallColorB integer check(WallColorB>=0 AND WallColorB<=255),
    userWallComment varchar(40)
);

create table WallDoor(
    wallID varchar(10) references abstractWall(WallID),
    doorID varchar(10) references abstractDoor(doorID) UNIQUE,
    DisplacementAB integer check(DisplacementAB>0), 
    DisplacementAD integer check(DisplacementAD>0), 
    orientation varchar(4) check(orientation like 'ABCD' OR orientation like 'ABCD' OR orientation like 'ABCD' OR orientation like 'ABCD' OR orientation like 'DCBA' OR orientation like 'DABC' OR orientation like 'CBAD' ), 
    primary key(wallID,doorID)
);--doorID should not repeate and must be from existing doors and orientation must be valid string from given range
    

create table containerConcreteTypeFaces (
    containerConcreteTypeId varchar(10) references containerConcreteTypes (containerConcreteTypeId) UNIQUE,
    containerConcreteRoof varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
    containerConcreteFloor varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
    containerConcreteRight varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
    containerConcreteLeft varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
    containerConcreteFront varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
    containerConcreteBack varchar(10) references abstractWall (WallID) NOT NULL UNIQUE
);--

create table nonContainerConcreteTypes (
    nonContainerConcreteTypeId varchar(10) references types(typeID) UNIQUE check(nonContainerConcreteTypeID like 'nct%'),
    nonContainerLengthAB integer check(nonContainerLengthAB>0), 
    nonContainerLengthAD integer check(nonContainerLengthAD>0), 
    nonContainerLengthAE integer check(nonContainerLengthAE>0), 
    userObjectCommentGlobal varchar(10)
);--nonContainerConcreteTypeID should be of non-container type and all length should be non zero

create table nonContainerConcreteTypeFaces (
    nonContainerConcreteTypeId varchar(10) references nonContainerConcreteTypes(nonContainerConcreteTypeId) UNIQUE,
    nonContainerConcreteRoof varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
    nonContainerConcreteFloor varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
    nonContainerConcreteRight varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
    nonContainerConcreteLeft varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
    nonContainerConcreteFront varchar(10) references abstractWall (WallID) NOT NULL UNIQUE,
    nonContainerConcreteBack varchar(10) references abstractWall (WallID) NOT NULL UNIQUE
);--

create table propertyTypes (
    propertyType varchar(10) primary key check(propertyType like 'pT%'),
    userDescription varchar(40)
);

create table properties (
    propertyID varchar(10) primary key check(propertyID like 'pr%'),
    propertyName varchar(10) NOT NULL,
    propertyType varchar(10) references propertyTypes(propertyType),
    userDescription varchar(40)
);

create table unitList (
    unitID varchar(10) primary key,
    unitName varchar(20) NOT NULL,
    unitAbbr varchar(10),
    propertyID varchar(10) references properties( propertyID)
);



create table containerObjects (
    objectID varchar(10) references objects(objectID) UNIQUE check(objectID like 'c%'),
    containerConcreteTypeId varchar(10) references containerConcreteTypes (containerConcreteTypeId),
    userLabel varchar(20),
    userObjectCommentLocal varchar(40) 
);--objectId should be of container

create table nonContainerObjects (
    objectID varchar(10) references objects(objectID) unique check(objectID like 'nc%'),
    nonContainerConcreteTypeId varchar(10) references nonContainerConcreteTypes (nonContainerConcreteTypeId),
    userLabel varchar(20),
    userObjectCommentLocal varchar(40) check(objectID like 'nc%')
);--objectId should be of container

create table directChild_parent(
    childID varchar(10) references objects(objectID),
    parentID varchar(10) references objects(objectID) check(parentID like 'c%'),
    DisplacementAB integer check(DisplacementAB>0), 
    DisplacementAD integer check(DisplacementAD>0), 
    DisplacementAE integer check(DisplacementAE>0), 
    orientation_FrontFace varchar(4) NOT NULL,
    orientation_RoofFace varchar(4) NOT NULL,
    primary key(childId, parentID)
);

create table nonContainerObjectProperties (
    objectID varchar(10) references nonContainerObjects(objectID),
    userAssignedID varchar(10) NOT NULL,
    propertyID varchar(10) references properties(propertyID), 
    propertyValue varchar(10) NOT NULL,
    measurementUnitID varchar(10) references unitList(unitID),  
    userCommentLocal varchar(10),
    userLabel varchar(10),
    primary key(objectID, propertyID)
);

create table containerObjectProperties (
    objectID varchar(10) references containerObjects(objectID),
    userAssignedID varchar(10) NOT NULL,
    propertyID varchar(10) references properties(propertyID), 
    propertyValue varchar(10) NOT NULL,
    measurementUnitID varchar(10) references unitList(unitID),
    userCommentLocal varchar(10),
    userLabel varchar(10),
    primary key(objectID, propertyID)
);

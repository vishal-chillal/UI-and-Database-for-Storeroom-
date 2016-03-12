drop table child_parrent CASCADE;
drop table nonContainerObjectProperties CASCADE;
drop table containerObjectProperties CASCADE;
drop table nonContainerObjects CASCADE;
drop table containerConcreteTypeProperties CASCADE;
drop table nonContainerConcreteTypeProperties CASCADE;
drop table containerObjects CASCADE;
drop table Unit_List CASCADE;
drop table properties CASCADE;
drop table containerConcreteTypeFaces CASCADE; 
drop table containerConcreteTypes CASCADE;
drop table nonContainerConcreteTypeFaces CASCADE; 
drop table nonContainerConcreteTypes CASCADE;
drop table typeInheritance CASCADE;
drop table types CASCADE;
drop table objects CASCADE;
drop table propertyTypes CASCADE;
drop table measurementunits CASCADE;
drop table physicalEntities CASCADE;
drop table Door_Wall CASCADE;
drop table Walls CASCADE;
drop table Doors CASCADE;

create table objects(
    objectID text primary key
);

create table types(
    type_id text primary key,
    type_name text NOT NULL,
    userDescription text
);

create table typeInheritance (
    type_id text references types(type_id) NOT NULL,
    super_type_id text references types(type_id) NOT NULL,
    primary key(type_id, super_type_id)
);

create table containerConcreteTypes (
    containerConcreteTypeId text primary key references types(type_id),
    containerLengthAB integer NOT NULL, 
    containerLengthAD integer NOT NULL, 
    containerLengthAE integer NOT NULL, 
    containerThickness integer NOT NULL,
    userObjectCommentGlobal text
    
);

create table Doors(
    DoorID text primary key,
    DoorLenghtAB integer NOT NULL,
    DoorLenghtAD integer NOT NULL,
    DoorColour text
);


create table Walls(
    WallID text primary key,
    WallLenghtAB integer NOT NULL,
    WallLenghtAD integer NOT NULL,
    WallColour text NOT NULL,
    userWallComment text
);

create table Door_Wall(
    wallID text references Walls(WallID) NOT NULL,
    DoorID text references Doors(DoorID) NOT NULL,
    DisplacementAB integer NOT NULL,
    DisplacementAD integer NOT NULL,
    orientation text NOT NULL, 
    primary key(wallID,DoorID,DisplacementAB,DisplacementAD)
);
    

create table containerConcreteTypeFaces (
    containerConcreteTypeId text primary key references containerConcreteTypes (containerConcreteTypeId),
    containerConcreteRoof text references Walls (WallID) NOT NULL,
    containerConcreteFloor text references Walls (WallID) NOT NULL, 
    containerConcreteRight text references Walls (WallID) NOT NULL,
    containerConcreteLeft text references Walls (WallID) NOT NULL,
    containerConcreteFront text references Walls (WallID) NOT NULL,
    containerConcreteBack text references Walls (WallID) NOT NULL
);
create table nonContainerConcreteTypes (
    nonContainerConcreteTypeId text primary key references types(type_id),
    nonContainerLengthAB integer NOT NULL, 
    nonContainerLengthAD integer NOT NULL, 
    nonContainerLengthAE integer NOT NULL, 
    userObjectCommentGlobal text
);

create table nonContainerConcreteTypeFaces (
    nonContainerConcreteTypeId text primary key references nonContainerConcreteTypes (nonContainerConcreteTypeId),
    nonContainerConcreteRoof text references Walls (WallID) NOT NULL,
    nonContainerConcreteFloor text references Walls (WallID) NOT NULL, 
    nonContainerConcreteRight text references Walls (WallID) NOT NULL,
    nonContainerConcreteLeft text references Walls (WallID) NOT NULL,
    nonContainerConcreteFront text references Walls (WallID) NOT NULL,
    nonContainerConcreteBack text references Walls (WallID) NOT NULL
);

create table physicalEntities(
    physicalEntityID text primary key,
    entity_name text
);

create table Unit_List (
    unit_id text primary key,
    unit_name text NOT NULL,
    unit_abbr text NOT NULL,
    physicalEntityID text references physicalEntities(physicalEntityID), 
    multiplication_factor float
);

create table propertyTypes (
    propertyType text primary key,
    physicalEntityID text references physicalEntities(physicalEntityID), 
    userDescription text
);

create table properties (
    propertyID text primary key,
    propertyType text references propertyTypes(propertyType),
    userDescription text
);

create table measurementUnits (
    measurementUnitID text primary key

);
create table containerConcreteTypeProperties (
    containerConcreteTypeId text references containerConcreteTypes (containerConcreteTypeId),
    propertyID text references properties(propertyID), 
    propertyValue text NOT NULL,
    measurementUnitID text references measurementUnits(measurementUnitID),  
    userCommentGlobal text,
    primary key(containerConcreteTypeId, propertyID)
);

create table nonContainerConcreteTypeProperties (
    nonContainerConcreteTypeId text references nonContainerConcreteTypes (nonContainerConcreteTypeId),
    propertyID text references properties(propertyID), 
    propertyValue text NOT NULL,
    measurementUnitID text references measurementUnits(measurementUnitID),  
    userCommentGlobal text,
    primary key(nonContainerConcreteTypeId, propertyID)
);


create table containerObjects (
    objectID text primary key references objects(objectID),
    containerConcreteTypeId text references containerConcreteTypes (containerConcreteTypeId),
    userLabel text NOT NULL,
    userObjectCommentLocal text
);

create table nonContainerObjects (
    objectID text primary key references objects(objectID) ,
    nonContainerConcreteTypeId text references nonContainerConcreteTypes (nonContainerConcreteTypeId),
    userLabel text,
    userObjectCommentLocal text
);

create table nonContainerObjectProperties (
    objectID text references nonContainerObjects(objectID),
    userAssignedID text NOT NULL,
    propertyID text references properties(propertyID), 
    propertyValue text NOT NULL,
    userCommentLocal text,
    userLabel text NOT NULL,
    primary key(objectID, propertyID)
);



create table containerObjectProperties (
    objectID text references containerObjects(objectID),
    userAssignedID text NOT NULL,
    propertyID text references properties(propertyID), 
    propertyValue text NOT NULL,
    userCommentLocal text,
    userLabel text NOT NULL,
    primary key(objectID, propertyID)
);


create table child_parrent(
    childID text references containerObjects(objectID),
    parrentID text references objects(objectID),
    DisplacementAB integer NOT NULL,
    DisplacementAD integer NOT NULL,
    DisplacementAE integer NOT NULL,
    orientation_FrontFace text NOT NULL,
    orientation_RoofFace text NOT NULL,
    primary key(childId, parrentID,DisplacementAB,DisplacementAD,DisplacementAE)
);

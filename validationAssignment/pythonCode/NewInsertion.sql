insert into objects values('nc1'),('nc2'),('nc3'),('nc4'),('nc5'),('c1'),('c2'),('c3'),('c4'),('c5');
insert into abstractDoor values('d1',200,100,55,60,100),('d2',200,100,55,60,100),('d3',200,100,55,60,100),('d4',200,100,55,60,100),('d5',60,54,10,10,100);
insert into types values('nct1','beam','concrete beam'),('nct2','bench','wooden'),('nct3','switch',''),('nct4','amplifier',''),('ct1','ampBox',''),('ct2','classRoom',''),('ct3','chalkBox','');
insert into containerConcreteTypes values('ct1',500,760,600,10,''),('ct2',6100,3180,13600,280,''),('ct3',100,100,100,1,'');
insert into nonContainerConcreteTypes values('nct1',6100,570,260,''),('nct3',40,250,300,''),('nct4',250,100,350,'');
insert into propertyTypes values('pT1','boolean'),('pT2','number'),('pT3','string'),('pT4','date');
insert into properties values('pr1','fragile','pT1',''),('pr2','weight','pT2',''),('pr3','temp','pT2',''),('pr4','side UP','pT3',''),('pr5','expiry','pT4','');
insert into unitList values('Uid01','boolean','','pr1'),('Uid02','kilogram','kg','pr2'),('Uid03','celceous','c','pr3'),('Uid04','others','','pr4');
insert into containerobjects values('c1','ct1','amplifierbox'),('c2','ct2','classroom'),('c3','ct3','chalkbox');
insert into noncontainerobjects values('nc1','nct1','beam'),('nc3','nct3','switch'),('nc4', 'nct4', 'amplifier');
insert into noncontainerobjectproperties values('nc1','nc1','pr1','false','Uid01','','beam'),('nc3','nc3','pr1','false','Uid01','','switch'),('nc4', 'nc4', 'pr4', 'ABFE', 'Uid04','','amplifier'),('nc4', 'nc4', 'pr1', 'true','Uid01', '','amplifier');
insert into containerobjectproperties values('c1','c1','pr1','true','Uid01','','ampbox'),('c2','c2','pr3','23','Uid02','','classroom'),('c3', 'c3', 'pr4', 'ABFE','Uid04', '','chalkBox'),('c3', 'c3', 'pr1', 'true','Uid01', '','chalkBox');
insert into directchild_parent values('nc1','c2','240','1','1','DCGH','ABCD'),('nc2','c2','4800','2420','1','DCGH','ABCD'),('nc3', 'c2', '4800', '2300','1', 'DCGH','ABCD'),('nc4', 'c1', '100', '150','200', 'DCGH','ABCD');
insert into abstractwall values('WC101',500,600,150,150,150,''),('WC102',500,600,150,150,150,''),('WC103',600,760,150,150,150,''),('WC104',600,760,150,150,150,''),('WC105',760,500,150,150,150,''),('WC106',760,500,150,150,150,''),('WC201',6100,13600,200,200,200,''),('WC202',6100,13600,200,200,200,''),('WC203',13600,3180,200,200,200,''),('WC204',13600,3180,200,200,200,''),('WC205',3180,6100,200,200,200,''),('WC206',3180,6100,200,200,200,''),

('WNC101',6100,260,200,200,200,''),('WNC102',6100,260,200,200,200,''),('WNC103',260,570,200,200,200,''),('WNC104',260,570,200,200,200,''),('WNC105',570,6100,200,200,200,''),('WNC106',570,6100,200,200,200,''),('WNC401',250,350,5,5,5,''),('WNC402',250,350,5,5,5,''),('WNC403',350,100,5,5,5,''),('WNC404',350,100,5,5,5,''),('WNC405',100,250,5,5,5,''),('WNC406',100,250,5,5,5,'');

insert into walldoor values('WC204','d1',200,200,'ABCD'),('WC204','d2',250,250,'ABCD');
insert into containerConcretetypefaces values('ct1','WC101','WC102','WC103','WC104','WC105','WC106');
insert into noncontainerConcretetypefaces values('nct1','WNC101','WNC102','WNC103','WNC104','WNC105','WNC106');

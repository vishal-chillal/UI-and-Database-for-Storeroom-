insert into objects values('N_C1'),('NC2'),('_NC3'),('nc7'),('nc8'),('c6'),('#C2'),('C3'),('c7'),('c9');
insert into abstractDoor values('D1',300,200,50,-2,350),('D2',300,200,-7,-10,-7),('d6',300,200,230,230,230),('D4',200,100,50,70,150),('d6',80,50,30,20,200);
insert into types values('NCT1','beam','concrete beam'),('nct7','stage','wooden'),('NCT3','switch',''),('nct8','blackbox',''),('CT1','ampBox',''),('CT2','classRoom',''),('ct5','table','');
insert into containerConcreteTypes values('vr1',500,760,600,10,''),('ct11',6100,80,900,280,''),('CB3',100,-100,100,-1,'');
insert into nonContainerConcreteTypes values('nct1',6100,570,260,''),('NCT3',-40,-50,-0.400,''),('VBR4',250,-100,0.350,'');
insert into propertyTypes values('PT1','boolean'),('br2','number'),('pT5','float'),('pt0','date');
insert into properties values('pr9','waterproof','pT1',''),('pr6','weight','NR2',''),('DF3','temp','pT2',''),('pr7','','pT3',''),('CX','expiry','PT4','');
insert into unitList values('u_id01','boolean','','PR1'),('2id','','kg','pr2'),('Uid05','centimeter','c','pr3'),('Uid04','others','','PR4');
insert into containerobjects values('c4','ct1','table'),('C2','ct2','classroom'),('C_t','ct3','chalkbox');
insert into noncontainerobjects values('N_C1','nct1','beam'),('nc5','nct3','bench'),('3_nc4', 'nct4', 'amplifier');
insert into noncontainerobjectproperties values('','nc1','pr1','false','Uid01','','beam'),('nc3','nc3','pr3','false','Uid01','','switch'),('nc4','nc4','','ABFE','Uid04','','amplifier');
insert into containerobjectproperties values('c2','c1','pr3','true','Uid01','','classroom'),('_c2','c2','pr3','23','Uid02','','classroom'),('c3','','','ABFE','Uid04','','chalkBox');
insert into directchild_parent values('nc3','c2','240','1','1','DCGH','ABCD'),('','','4800','2300','1','DCGH','ABCD'),('WNC501',120,30,125,125,125,''),('WNC502',120,30,125,125,125,''),('WNC503',30,120,125,125,125,''),('WNC504',30,120,125,125,125,''),('WNC405',120,30,5,5,5,''),('WNC406',120,30,5,5,5,'');

insert into walldoor values('WC204','d1',-200,-200,'ABCD'),('WC204','d2',250,250,'ABCD');
insert into containerConcretetypefaces values('!_ct1','WC101','WC102','WC103','WC104','WC105','WC106'),('ct3','WC103','WC104','WC105','WC106','WC107','WC108');
insert into noncontainerConcretetypefaces values('nct1','WNC101','WNC102','WNC103','WNC104','WNC105','WNC106'),('','WNC101','_WNC102','WNC103','WNC104','WNC105','WNC106');




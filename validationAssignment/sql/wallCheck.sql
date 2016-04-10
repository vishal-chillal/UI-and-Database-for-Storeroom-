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

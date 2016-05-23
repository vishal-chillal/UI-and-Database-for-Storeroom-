create or replace function checkWallDoor() returns trigger as $checkWallDoor$
begin
	declare x integer;
	declare y integer;
	declare dh integer;
	declare dw integer;
	begin

		if ((select WallLengthAB from abstractWall a where a.WallID like new.WallID) - (select doorLengthAB from abstractDoor absd1 where absd1.doorID like new.doorID)) < 0 then
		--select WallLengthAD into y from abstractWall abs2 where abs2.WallID like new.WallID;
		--
		--select doorLengthAD into dw from abstractDoor absd2 where absd2.doorID like new.doorID;
--		if(x) = 230 then --or (new.DisplacementAD)+dh > y) then --or dh > y or dw > x)then
			raise exception 'Door is outside the wall';
		end if;

		Return New;
	End;
End;
$checkWallDoor$ Language Plpgsql;

Create Trigger checkWallDoor before insert on WallDoor for each row execute procedure checkWallDoor();

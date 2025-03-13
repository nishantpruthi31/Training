-- trigger fxn don't accept parameteres
-- triggers can operate per row or once per statement
-- triggers fxn have access to records being modified via OLD(update and delete) and new(for insert and update ) variables


-- create trigger fxn
-- create trigger and attach it to operation

/* Query 1 */  -- create trigger fxn
create function general_hospital.f_clean_physician_name()
     returns TRIGGER
	 language plpgsql
	 as $$
	 begin
	 if NEW.last_name is null or NEW.first_name is null then 
	 raise exception 'Name cannott be null';
	 else 
	 NEW.last_name=trim(NEW.last_name);
	 NEW.first_name=trim(NEW.first_name);
	 New.full_name=concat(NEW.first_name,' ',NEW.last_name);
	 return NEW;
	 end if;
	 end ;
	 $$;
	 
/* Query 2 */ -- Attach trigger
CREATE trigger tr_clean_physician_table
before insert -- to execute this before inserting any row in table
on general_hospital.physicians
for each row -- for every insert we will get exception 
execute procedure general_hospital.f_clean_physician_name(); -- attaching fxn

	 
	 
/* Query 3 */
insert into general_hospital.physicians values (' JOHN ' ,'DOE ','ANYTHING',12345);
select * from general_hospital.physicians where id=12345

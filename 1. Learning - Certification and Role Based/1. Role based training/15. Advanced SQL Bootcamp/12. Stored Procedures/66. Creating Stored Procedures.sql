-- Creating stored procedures.

create procedure general_hospital.sp_test_procedure()
language plpgsql
as $$
begin -- begin of stored procedure
drop table if exists general_hospital.test_table;
create table general_hospital.test_table(id int);
commit;
end;    -- end of procedure
$$;  -- ending proedure with $$


call general_hospital.sp_test_procedure()
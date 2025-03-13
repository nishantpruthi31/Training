-- Very simmilar to dropping views and fxn's

/* Create or replace has limitations , 
1. Can't change argument type/number
2. Can't change name */

-- Alter can help us change name , schema , owner etc.

/* QUery 1 */
create or replace procedure general_hospital.sp_test_procedure()
language plpgsql
as $$
begin
drop table if exists general_hospital.test_table_new;
create TABLE general_hospital.test_table_new(id int);
commit;
end;
$$;

call general_hospital.sp_test_procedure();


/* Query 2 */
alter PROCEDURE general_hospital.sp_test_procedure
set schema public;

/* Query 3 */
drop procedure if exists sp_test_procedure

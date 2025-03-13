-- we can end transaction by end or commit 

/* Query 1 */
begin TRANSACTION ;
select now();
select * from general_hospital.physicians order by id;
update general_hospital.physicians set first_name='Bill',
full_name=concat(last_name,' Bill') where id =1
end TRANSACTION;  -- commit transaction we can do

/* Query 2 */
begin;
update general_hospital.physicians set first_name='Gage',
full_name=concat(last_name,' Gage') where id =1;
rollback;  -- so that update statements will be not take place.


select * from general_hospital.physicians where id=1;



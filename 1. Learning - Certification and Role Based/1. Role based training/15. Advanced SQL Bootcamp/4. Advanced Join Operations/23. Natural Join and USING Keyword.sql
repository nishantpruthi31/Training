--Databases when have common name of columns in many tables then we can use Natural join and Using keywords
-- Natural Join is implicit and in includes all common column name between two tables but if no common than it acts as cross join
-- Using is explicit and is preferred over natural join

/* Query 1 */
select
h.hospital_name,d.department_name
from general_hospital.departments d
inner join general_hospital.hospitals h
USING(hospital_id)


/* Query 2 */
select
h.hospital_name,d.department_name
from general_hospital.departments d
natural join general_hospital.hospitals h






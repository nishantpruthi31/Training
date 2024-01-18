-- List partitioning - useful when there are small , known no of values for partition field

/* Query 1 */
create table general_hospital.departments_partitioned(
hospital_id integer not null,
	department_id integer not null,
	department_name text,
	speciality_description text
) partition by list (hospital_id);

CREATE table general_hospital.departments_h111000
partition of general_hospital.departments_partitioned
for values in (111000);

CREATE table general_hospital.departments_h112000
partition of general_hospital.departments_partitioned
for values in (112000);

CREATE table general_hospital.departments_deFAULT
partition of general_hospital.departments_partitioned
default;

/* Query 2 */
insert into general_hospital.departments_partitioned
select 
hospital_id,department_id,department_name,specialty_description
from general_hospital.departments


/* Query 3 */ -- verification same as range partitioning




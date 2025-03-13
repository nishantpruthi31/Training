-- range partioning means divideing main table between certain range , such that each table have certain range of values

-- all constraints like foreign key, not null , index will be inherited to partitioned table
-- Unique/primary key must include all partitioning columns for better design


/* Creating a sample table to create partitions */
create table general_hospital.surgical_encounters_paritioned(
surgery_id integer not null,
	master_patient_id integer not null,
	surgical_admission_date date not null,
	surgical_discharge_date date)
	partition by range(surgical_admission_date);
	
create table general_hospital.surgical_encounters_y2016
partition of general_hospital.surgical_encounters_paritioned
for values from ('2016-01-01') to ('2017-01-01'); -- 2016 

create table general_hospital.surgical_encounters_y2017
partition of general_hospital.surgical_encounters_paritioned
for values from ('2017-01-01') to ('2018-01-01'); -- 2017

create table general_hospital.surgical_encounters_default
partition of general_hospital.surgical_encounters_paritioned
default;  -- for any values that does not fall in above two


/* QUery 2 */
insert into general_hospital.surgical_encounters_paritioned
select surgery_id,master_patient_id,surgical_admission_date,surgical_discharge_date
from general_hospital.surgical_encounters


/* Query 3 */ -- create index on partioned column and it will be inherited in all partitioned table
create index on general_hospital.surgical_encounters_paritioned
(surgical_admission_date)


/* Query 4 */  -- verification 
select extract(year from surgical_admission_date),count(*)
from general_hospital.surgical_encounters
group by 1 ;

select count(*),max(surgical_admission_date),min(surgical_admission_date)
from general_hospital.surgical_encounters_y2016



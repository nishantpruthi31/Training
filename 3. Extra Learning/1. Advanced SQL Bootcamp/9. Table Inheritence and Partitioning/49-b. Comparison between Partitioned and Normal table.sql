create table general_hospital.surgical_encounters_testing(
surgery_id integer not null,
	master_patient_id integer not null,
	surgical_admission_date date not null,
	surgical_discharge_date date);
	
insert into general_hospital.surgical_encounters_testing
select *
from general_hospital.surgical_encounters_paritioned


select * from general_hospital.surgical_encounters_testing 
where surgical_encounters_testing.surgical_admission_date >='2016-01-01'
and surgical_encounters_testing.surgical_admission_date <'2017-01-01'


select * from general_hospital.surgical_encounters_paritioned
where surgical_encounters_paritioned.surgical_admission_date >='2016-01-01'
and surgical_encounters_paritioned.surgical_admission_date <'2017-01-01'
	
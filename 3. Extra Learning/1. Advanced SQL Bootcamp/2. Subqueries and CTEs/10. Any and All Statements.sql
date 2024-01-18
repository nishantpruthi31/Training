-- any and all can be used in where or having clause and must be precedded 
-- by operator like > ,>= ,<,<=,=,!=,<> , LIKE

-- Any means or , also in and any  means same
-- if no success/true value for comparison and at least one null evaluation
-- for opertaor , result will be null

-- Subquery 1
-- we will get only those surgeries where total profit will be greater than all of the surgeries in subquery
select * from general_hospital.surgical_encounters
where total_profit > all( select avg(total_cost) from general_hospital.surgical_encounters
						group by diagnosis_description
						); 
	
-- Subquery 2
select diagnosis_description ,
avg(surgical_discharge_date-surgical_admission_date) as length_of_stay
from general_hospital.surgical_encounters 
group by diagnosis_description
having avg(surgical_discharge_date-surgical_admission_date) <=
all(
select avg(extract(day from patient_discharge_datetime -patient_admission_datetime))
	from general_hospital.encounters
	group by department_id

);
-- select extract(day from current_timestamp-'2023-11-17 00:00:00.000')


-- SubQuery 3
select unit_name,
string_agg(distinct surgical_type,',') as case_types
from general_hospital.surgical_encounters
group by unit_name
having string_agg(distinct surgical_type,',') like all(
select string_agg(distinct surgical_type,',') from general_hospital.surgical_encounters
);

--select string_agg(distinct surgical_type,',') from general_hospital.surgical_encounters
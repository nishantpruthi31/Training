-- CTE can be used with CRUD operations.

-- Example 1
with young_patients as(
select * from general_hospital.patients
	where date_of_birth >= '2000-01-01'
)
select * from young_patients where name ilike 'm%';

-- Example 2  /* using 1-2 cte's
with top_counties as(
select county,count(*) as num_patients from general_hospital.patients
	group by county
	having count(*) >1500
),
county_patients as(
select p.master_patient_id , p.county
	from general_hospital.patients p
	inner join top_counties t on t.county=p.county
)
select p.county,count(s.surgery_id) as num_surgeries
from general_hospital.surgical_encounters s
inner join county_patients p 
on s.master_patient_id=p.master_patient_id
group by p.county

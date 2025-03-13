-- used when we need to check if subquery returns any result , used with where clause
-- evaulated to true if at least one row is returned else false.
-- when subquery returns null , exists value to true

-- QUery 1 , using alias of outer table inside subquery
select e.*
 from general_hospital.encounters e
 where exists (
 select 1 from general_hospital.orders_procedures o
	 where e.patient_encounter_id=o.patient_encounter_id
 );
 
 
 
-- select 1 from general_hospital.surgical_encounters -- returns 1 in every row of total rows in table.
 -- Query 2
 select p.*
 from general_hospital.patients p
 where not exists(
	 select 1 from general_hospital.surgical_encounters s
 where s.master_patient_id = p.master_patient_id
 )
-- SubQuery 1 
select * from
(select * from general_hospital.patients 
 where date_of_birth>='2000-01-01'
 order by master_patient_id
) p 
where p.name ilike 'm%'   -- applying filter outside

/* Sub Query 2 */
select se.* -- means we are selecting data from se only
from (
select * from general_hospital.surgical_encounters
where surgical_admission_date 
between '2016-11-01' and '2016-11-30') se
inner join 
(
	select master_patient_id
	from general_hospital.patients
	where date_of_birth >='1900-01-01'
) p on se.master_patient_id = p.master_patient_id;
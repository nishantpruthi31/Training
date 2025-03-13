-- Subquery with In and not in

--Subquery 1  (simple)
select * from general_hospital.patients 
where master_patient_id in 
(
select distinct master_patient_id from general_hospital.surgical_encounters
)
order by master_patient_id

--Query 2 (joins)
select distinct p.master_patient_id from general_hospital.patients p
inner join general_hospital.surgical_encounters s
on p.master_petient_id =s.master_patient_id
order by p.master_patient_id



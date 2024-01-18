-- Full join is a combo of left join and right join 
-- full join returns records that are present in 
/* 1. Both tables
   2. Table 1 , but not table 2 (add null for table 2 values)
   3. Table 2 , but not table 1 (add null for tbale 1 values) */
   
   
   -- Useful for data quality issues and like find emp withoud dep or dep without dep without employee
   
   /* Query 1 */ -- any departments without hospital and vice versa
    select 
	d.department_id , d.department_name
	from general_hospital.departments d
	full join general_hospital.hospitals h 
	on d.hospital_id = h.hospital_id
	where h.hospital_id is null
	
/* Query 2 */  
select 
a.account_id,e.patient_encounter_id
from general_hospital.accounts a
full join general_hospital.encounters e
on a.account_id =e.hospital_account_id
where a.account_id is null or e.patient_encounter_id is null
	
   

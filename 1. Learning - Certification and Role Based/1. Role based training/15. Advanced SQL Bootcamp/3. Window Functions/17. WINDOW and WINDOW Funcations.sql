-- WINDOW clause enables us to define a reuable window after the from clause.

-- avg(col2) over w as windows avg_
-- from window w as (Partition by )

-- window fxn for groups - Rank , row_number 


/* Query 1 */
select 
s.surgeon_id,p.full_name,s.total_profit,
avg(total_profit) over w as avg_total_profit,
s.total_cost ,
sum(total_cost) over w as total_surgeon_cost
from general_hospital.surgical_encounters s
left outer join general_hospital.physicians p 
on s.surgeon_id = p.id
window w as (partition by s.surgeon_id)


/* Query 2 */

select  
s.surgery_id,p.full_name,s.total_cost,
rank() over (partition by surgeon_id order by total_cost asc) as cost_rank,
s.diagnosis_description,s.total_profit ,
row_number() over(partition by surgeon_id ,diagnosis_description order by total_profit desc) profit_row_number
from general_hospital.surgical_encounters s 
left outer join general_hospital.physicians p 
on s.surgeon_id = p.id
order by s.surgeon_id,s.diagnosis_description


/* Query 3 */

select 
patient_encounter_id,master_patient_id,patient_admission_datetime,patient_discharge_datetime,
lag(patient_discharge_datetime) over w as previous_discharge_date,  -- means for multiple occurence of discharge_time , we get the last discharge time
lead(patient_admission_Datetime) over w as next_admission_Date      -- means we get next admission time at every instance.
from general_hospital.encounters 
window w as (partition by master_patient_id order by patient_admission_datetime)
order by master_patient_id,patient_admission_datetime
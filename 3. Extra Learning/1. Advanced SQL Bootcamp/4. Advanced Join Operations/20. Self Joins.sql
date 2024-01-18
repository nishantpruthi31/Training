-- self joins , when hierarchy queries 

/* Query 1 */ -- to find all surgeries with same length
select 
se1.surgery_id as id1,
(se1.surgical_discharge_date-se1.surgical_admission_date) as los1,
se2.surgery_id as id2,
(se2.surgical_discharge_date-se2.surgical_admission_date) as los2
from general_hospital.surgical_encounters se1
inner join general_hospital.surgical_encounters se2
on (se1.surgical_discharge_date-se1.surgical_admission_date) = (se2.surgical_discharge_date-se2.surgical_admission_date)

/* Query 2 */  -- 
select 
o1.order_procedure_id,
o1.order_procedure_description,o1.order_parent_order_id,
o2.order_procedure_description
from general_hospital.orders_procedures o1
inner join general_hospital.orders_procedures o2
on o1.order_parent_order_id=o2.order_procedure_id

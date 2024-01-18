-- Union adds result of one query with other query , but cond is both queries have shoulw same no of columns
-- union will remove any duplicate values , unless used union all

select surgery_id
from general_hospital.surgical_encounters 
union  
select surgery_id
from general_hospital.surgical_costs order by surgery_id

-- intersec returns those values which are common in both tables.
-- same prop as union , i.e. remove duplicates unless intersect all is used.

select surgery_id
from general_hospital.surgical_encounters
intersect
select surgery_id
from general_hospital.surgical_costs
order by surgery_id
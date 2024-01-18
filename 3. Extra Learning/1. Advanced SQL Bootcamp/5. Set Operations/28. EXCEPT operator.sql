-- Except returns rows that are in result of 1st query but not query 2

-- duplicates values will be removed unless except all is used.

select surgery_id from general_hospital.surgical_costs
except
select surgery_id from general_hospital.surgical_encounters
order by surgery_id
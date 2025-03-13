-- Subquery 1 for comparison 
with total_cost as
(
select surgery_id , sum(resource_cost) as surgery_cost
from general_hospital.surgical_costs
group by surgery_id
)
select * from total_cost
where surgery_cost > (
select avg(surgery_cost) from total_cost
);


-- Subquery 2 

select * from general_hospital.vitals
where bp_diastolic >( select min(bp_diastolic) from general_hospital.vitals)
and bp_systolic < (select max(bp_systolic) from general_hospital.vitals)
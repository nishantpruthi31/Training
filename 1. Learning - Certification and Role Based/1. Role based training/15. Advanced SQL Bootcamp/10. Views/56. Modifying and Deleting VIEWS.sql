
/* Query 1 */
drop view if exists general_hospital.v_monthly_surgery_stats_by_department;


/* QUery 2 */
create or replace view general_hospital.v_monthly_surgery_stats AS
select 
to_char(surgical_admission_date,'YYYY-MM') as year_month,
count(surgery_id) as num_surgeries,
sum(total_cost) as total_cost,
sum(total_profit) as total_profit
from general_hospital.surgical_encounters
group by 1
order by 1

select * from general_hospital.v_monthly_surgery_stats

/* Query 3 */
alter view if exists general_hospital.v_monthly_surgery_stats  
 rename to view_monthly_surgery_stats;

-- this query won't work , we hould use create or replace in postgres sql
alter view if exists general_hospital.view_monthly_surgery_stats 
select 
to_char(surgical_admission_date,'YYYY--MM'),
unit_name,count(surgery_id) as num_surgery,
sum(total_cost) as total_cost,sum(total_profit) as total_profit

from general_hospital.surgical_encounters
group by to_char(surgical_admission_date,'YYYY--MM'),unit_name
order by unit_name,to_char(surgical_admission_date,'YYYY--MM');


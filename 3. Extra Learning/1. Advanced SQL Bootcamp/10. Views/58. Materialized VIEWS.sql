-- With materalized view , we can store underlying data in a view


/* Query 1 */
create MATERIALIZED view general_hospital.v_monthly_surgery_stats as
select
to_char(surgical_admission_date,'YYYY-MM'),
unit_name,count(surgery_id) as num_surgeries,
sum(total_cost) as total_cost,
sum(total_profit) as total_profit
from general_hospital.surgical_encounters
group by 1 ,2 
order by 2,1
with no data;  -- this means initially there will be no data when view created 

select * from general_hospital.v_monthly_surgery_stats
-- no data will be here

/* QUery 2 */
refresh MATERIALIZED view concurrently general_hospital.v_monthly_surgery_stats
-- concurrently won't work first time as there is no data yet. 
refresh MATERIALIZED view  general_hospital.v_monthly_surgery_stats
-- now we can use concurrently . 


-- we can same elter queries as alter views here also.

/* QUery 3 */
select * from pg_matviews  -- for materialized views



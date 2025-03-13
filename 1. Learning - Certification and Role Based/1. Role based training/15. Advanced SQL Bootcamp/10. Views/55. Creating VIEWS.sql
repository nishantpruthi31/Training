-- Creating views

/* Query 1 */
create view general_hospital.v_monthly_surgery_stats_by_department as
select 
to_char(surgical_admission_date,'YYYY--MM'),
unit_name,count(surgery_id) as num_surgery,
sum(total_cost) as total_cost,sum(total_profit) as total_profit

from general_hospital.surgical_encounters
group by to_char(surgical_admission_date,'YYYY--MM'),unit_name
order by unit_name,to_char(surgical_admission_date,'YYYY--MM')



select * from v_monthly_surgery_stats_by_department


/* Query 2 */
select * from information_schema.views
where table_schema='general_hospital'
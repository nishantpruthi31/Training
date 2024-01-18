-- window fxn alwys have over clause and in that we define the calculation , if not define then it applies on entire window
-- partition by determines how data is grouped, order by sort data after calculation 

-- window fxn executed after all other filters , aggregation etc . Not allowd in where having and group by clauses.

/* Query 1 */
select surgery_id , (surgical_discharge_date-surgical_admission_date) as los ,
avg(surgical_discharge_date-surgical_admission_date)
over () as avg_los
from general_hospital.surgical_encounters

/* Query 2 */
select 
account_id,primary_icd,total_account_balance,
rank() over(partition by primary_icd order by total_account_balance desc)
from general_hospital.accounts
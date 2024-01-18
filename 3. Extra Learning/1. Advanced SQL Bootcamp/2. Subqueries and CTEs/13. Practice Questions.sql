/* Ques 1 */


/* Ques 2 */
select distinct patient_encounter_id from general_hospital.orders_procedures
where order_cd in (select orders_procedures.order_cd from general_hospital.orders_procedures
group by orders_procedures.order_cd
order by count(*) desc limit 10)
-- we can also use = any(subquery)

/* Ques 3 */
--1st method 
select a.account_id,a.account_balance 
from general_hospital.accounts a
where total_account_balance>10000
and exists (select 1 from general_hospital.encounters e
		   where e.hospital_account_id=a.account_id
			and e.patient_in_icu_flag='Yes'
		   )
-- 2nd method
select a.account_id,a.account_balance 
from general_hospital.accounts a 
inner join general_hospital.encounters e
on e.hospital_account_id=a.account_id
where a.total_account_balance>10000 and e.patient_in_icu_flag='Yes' 


/* Ques 4 */

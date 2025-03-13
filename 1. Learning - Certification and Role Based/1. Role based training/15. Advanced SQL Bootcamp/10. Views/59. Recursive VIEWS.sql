-- Recursive view serve same purpose as views in general , but for recursive expressions (with statements)
-- Functionality equivalent to creating a normal view with recursive CTE

/* QUery 1 */

create recursive view general_hospital.v_fibonacci(a,b) AS
select 1 as a,1 as b  -- non recursive statement 
union all
select b,a+b   -- recursive statement
from v_fibonacci
where b<200;

select * from general_hospital.v_fibonacci

/* Query 2 */
create recursive view v_orders(order_procedure_id,order_parent_order_id,level) as
select order_procedure_id,order_parent_order_id,0 as level
from general_hospital.orders_procedures where order_parent_order_id is NULL

union all
select op.order_procedure_id,op.order_parent_order_id,
o.level+1 as level
from general_hospital.orders_procedures op
inner join v_orders o
on op.order_parent_order_id=o.order_procedure_id


select * from v_orders where order_parent_order_id is not null
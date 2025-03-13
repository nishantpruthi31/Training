-- start with non recursive base item and then union , recursive query
/* use case 
1. count up untill three
2. Finding bosses and hierarchical level
3. Finding routes between cities
4. Finding Ancestors.
*/

--Fibonacci sequence
with recursive fibonacci as
(
select 1 as a , 1 as b
	union all
	select b,a+b
	from fibonacci
)
select a,b from fibonacci limit 10

-- cte 2 -- to find hierachcy between order and it's parent
with recursive orders as 
(
select order_procedure_id , order_parent_order_id,0 as level
	from general_hospital.orders_procedures
	where order_parent_order_id is NULL
	
	union all
	
	select op.order_procedure_id , op.order_parent_order_id,o.level+1 as level
	from general_hospital.orders_procedures op
	inner join orders o on o.order_procedure_id = op.order_parent_order_id
                           -- it means the current parent order_id will be next order procedure id
	                        -- like in case of emp_id=manger_id
)

--select * from orders;

select * from orders where level<>0
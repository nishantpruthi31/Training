-- Hash partitioning - when there is no natural way yo divide data , 
--                  - based on modulor like 5 mod 3 , 13 mod 5


/* QUery 1 */
create table general_hospital.orders_procedures_partitioned
(
	order_procedure_id integer not null,
	patient_encounter_id int not null,
	ordering_provider_id int REFERENCES general_hospital.physicians,
	order_cd text,
	order_procedure_description text

) partition by hash (order_procedure_id,patient_encounter_id);


create table orders_procedures_hash0
partition of general_hospital.orders_procedures_partitioned
for values with (modulus 3,remainder 0);

create table orders_procedures_hash1
partition of general_hospital.orders_procedures_partitioned
for values with (modulus 3,remainder 1);

create table orders_procedures_hash2
partition of general_hospital.orders_procedures_partitioned
for values with (modulus 3,remainder 2);

/* Query 2 */
insert into general_hospital.orders_procedures_partitioned
select 
order_procedure_id,patient_encounter_id,ordering_provider_id,order_cd,
order_procedure_description
from general_hospital.orders_procedures


/* Query 3 */
create index on general_hospital.orders_procedures_partitioned
(order_procedure_id,patient_encounter_id)


/* Query 4 */
select 'hash0' , count(*) from orders_procedures_hash0
union
select 'hash1' , count(*) from orders_procedures_hash1
union
select 'hash2' , count(*) from orders_procedures_hash2



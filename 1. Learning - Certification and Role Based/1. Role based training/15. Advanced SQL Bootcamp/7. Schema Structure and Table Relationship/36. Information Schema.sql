-- Postgres has a "meta" schema  exposing the databse structure information_schema

-- information schema has many tables , few imp ones are tables,columns,table_constratints

/* Query 1 */
select * from information_schema."tables"
where table_schema ='general_hospital'


/* Query 2 */  -- getting details of each column in table
select * from information_schema."columns"
where table_schema ='general_hospital'
order by table_name , ordinal_position


/* QUery 3 */ -- sample query for analysi 
select table_name,data_type,count(*) from information_schema."columns"
where table_schema ='general_hospital'
group by table_name,data_type
order by table_name , 3 desc



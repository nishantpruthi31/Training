-- trigger can be disabled individually or all at once for a table

--alter table table_name disable trigger trigger_name
-- alter table table_name disable trigger all;

-- same syntax for enable

/* Query 1 */
alter table general_hospital.physicians
disable trigger all;

/* Query 2 */
alter table general_hospital.physicians
enable trigger tr_clean_physician_table;
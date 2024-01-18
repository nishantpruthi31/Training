-- the only alter we can do is change name or dependency

/* Query 1 */
alter trigger tr_clean_physician_table on general_hospital.physicians
rename to tr_clean_name;

/* Query 2 */
drop trigger if exists tr_clean_name on general_hospital.physicians;
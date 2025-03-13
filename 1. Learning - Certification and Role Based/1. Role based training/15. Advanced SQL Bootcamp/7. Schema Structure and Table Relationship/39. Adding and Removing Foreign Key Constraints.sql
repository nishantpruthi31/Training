-- Foreign Key in sql says that values of one column in child tables must be contained in column of parent table.

-- syntax to add fk constraint
--alter table child_table add constraint constraint_name FOREIGN KEY(col1) reference parent_table(col2)
-- alter table child_table drop constraint constraint_name

/* Query 1 */

alter table general_hospital.encounters
add constraint encounters_attending_provider_id_fk 
FOREIGN key(attending_provider_id)
references general_hospital.physicians(id)


alter table general_hospital.encounters
drop CONSTRAINT encounters_attending_provider_id_fk
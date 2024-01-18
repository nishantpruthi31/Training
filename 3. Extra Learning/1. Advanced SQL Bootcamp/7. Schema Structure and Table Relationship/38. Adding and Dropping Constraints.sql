-- Constraints restrict the data that can be added to ur database by specifying criteria it must meet

-- Basic Constraints UNIQUE , NOT NULL , CHECK(allows expression yo check weather data is accetible or not)
--syntax: alter table table_name add constraint constraint_name UNIQUE(col1,col2)
--      : alter table table_name drop constraint constraint_name [IF EXISTS]

-- syntax to add and drop not null is diff i.e.
-- alter table table_name alter column column_name drop/set NOT NULL


/* Query 1 */

alter table general_hospital.surgical_encounters
add constraint check_positive_cost
check(total_cost>0)

alter table general_hospital.surgical_encounters
drop constraint check_positive_cost

-- Savepoints allows us to save or undo transaction certain level.


/*  begin
....

savepoint savepoint_name
.... 

Rollback to savepoint_name
Release savepoint_name(when we need to commit entire data in 1 go )

COMMIT

*/

/* qUERY 1 */
begin;
update general_hospital.vitals set bp_diastolic=120
where patient_encounter_id=2570045;
savepoint vitals_updated;

update general_hospital.accounts
set total_account_balance=1000
where account_id=11417340;

rollback to vitals_updated;
commit;

-- accounts table won't be updated as we did a rollback till savepoint


/* Query 2 */
begin;
update general_hospital.vitals set bp_diastolic=52
where patient_encounter_id=1854663;
savepoint vitals_updated;

update general_hospital.accounts
set total_account_balance=1000
where account_id=11417340;
release SAVEPOINT vitals_updated;
commit;




-- Locks helps prevent users from  modifying data or select data that is being modified by diff transaction , once transaction is complete lock will be lifted.


-- LOCK TABLE command can be used to define manually , else it is handled backend.


BEGIN;
select now();
lock table general_hospital.physicians;
ROLLBACK;


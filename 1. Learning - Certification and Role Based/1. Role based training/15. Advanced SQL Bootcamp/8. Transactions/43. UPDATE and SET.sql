-- Update and set

select * from general_hospital.vitals where patient_encounter_id=1854663;

update general_hospital.vitals set bp_diastolic=100 
where patient_encounter_id=1854663;
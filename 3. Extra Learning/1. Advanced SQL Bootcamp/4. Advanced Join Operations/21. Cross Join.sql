-- All combinations of rows for table1 and table 2 , very slow 

/* Query 1 */ -- all combo of hospital and department name 
select 
h.hospital_name,d.department_name
from general_hospital.hospitals h 
cross join general_hospital.departments d




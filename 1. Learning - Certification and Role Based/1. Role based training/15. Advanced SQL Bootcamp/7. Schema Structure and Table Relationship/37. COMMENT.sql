-- Comments can answer to ques like what does this column mean.
-- Comments can be added to any table,schema , index etc

-- Syntax:- Comment on Table t1 is 'this is table'
-- to remove a comment set value to null


/* Query 1 */ -- Comment on table
comment on table general_hospital.vitals IS
'Patient vital sign data taken at the begining of encounter'

-- this is query used to see comment through query
select obj_description('general_hospital.vitals'::regclass)


/* Query 2 */  -- Comment on column
comment on column general_hospital.accounts.primary_icd is
'Primary International Classification of Diseases (ICD) for the accounts'

-- we need column odinal position of column to view it's comment , we need to use info schema first
select col_description('general_hospital.accounts'::regclass,1) -- this 1 is ordinal pos of primary_icd col


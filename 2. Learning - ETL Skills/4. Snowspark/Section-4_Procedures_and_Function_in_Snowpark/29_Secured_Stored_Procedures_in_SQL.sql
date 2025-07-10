use test.public;
use accountadmin;

create or replace table employees2 clone employees;
table employees2;

create or replace secure procedure increase_salary(name1 string, percent int)
    returns string
    execute as owner
as begin
    update employees2
    set salary = salary * :percent / 100
    where employee_name = :name1;
    return 'Done';
end;
call increase_salary('Bruce Ernst', 20);

grant usage on warehouse compute_wh to sysadmin;
grant usage on database test to sysadmin;
grant usage on schema test.public to sysadmin;
grant usage on procedure test.public.increase_salary(string, int) to sysadmin;

use role sysadmin;
call increase_salary('Bruce Ernst', 20);
select get_ddl('procedure', 'test.public.increase_salary(string, int)');

use accountadmin;
alter procedure test.public.increase_salary(string, int) execute as caller;

use role sysadmin;
call increase_salary('Bruce Ernst', 20);

use accountadmin;
grant select,update on table test.public.employees2 to sysadmin;

use role sysadmin;
call increase_salary('Bruce Ernst', 20);

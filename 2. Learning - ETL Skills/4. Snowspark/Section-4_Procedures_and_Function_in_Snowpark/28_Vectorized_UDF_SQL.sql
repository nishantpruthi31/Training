use test.public;

-- the employees table has been loaded before, from an employees.csv file
select employee_name, salary
from employees;

-- ==========================================================
-- scalar UDFs (in SQL/JavaScript/Python)
create or replace function add_bonus_sql(salary float, bonus float)
    returns float
as $$ salary * (1.0 + bonus / 100.0) $$;

create or replace function add_bonus_js(salary float, bonus float)
    returns float
    language javascript
as $$ return SALARY * (1.0 + BONUS / 100.0) $$;

create or replace function add_bonus(salary float, bonus float)
    returns float
    language python
    runtime_version = 3.9
    handler = 'add_bonus'
as $$
def add_bonus(salary, bonus):
    return salary * (1.0 + bonus / 100.0)
$$;

select employee_name, salary,
    add_bonus_sql(salary, 5) as sals,
    add_bonus_js(salary, 5) as saljs,
    add_bonus(salary, 5) as sal
from employees
order by 1;

select uniform(1000, 10000, random())::float salary,
    add_bonus(salary, 5) as sal
from table(generator(rowcount => 1000000));

-- ==========================================================
-- vectorized Python UDF (w/ an internal @vectorized decorator)
create or replace function add_bonus_v(salary float, bonus float)
    returns float
    language python
    runtime_version = 3.9
    packages = ('pandas')
    handler = 'add_bonus_v'
as $$
import pandas
from _snowflake import vectorized

@vectorized(input=pandas.DataFrame, max_batch_size=5)
def add_bonus_v(df):
    return df[0] * (1.0 + df[1] / 100.0)
$$;

select employee_name, salary,
    add_bonus(salary, 5) as sal,
    add_bonus_v(salary, 5) as salv
from employees
order by 1;

select uniform(1000, 10000, random())::float salary,
    add_bonus_v(salary, 5) as salv
from table(generator(rowcount => 1000000));

-- ==========================================================
-- vectorized Python UDF (w/ a function attribute)
create or replace function add_bonus_v2(salary float, bonus float)
    returns float
    language python
    runtime_version = 3.9
    packages = ('pandas')
    handler = 'add_bonus_v2'
as $$
import pandas

def add_bonus_v2(df):
    return df[0] * (1.0 + df[1] / 100.0)

add_bonus_v2._sf_vectorized_input = pandas.DataFrame
add_bonus_v2._sf_max_batch_size = 5
$$;

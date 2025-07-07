use test.public;

-- upload employees.csv --> EMPLOYEES table in TEST.PUBLIC db schema
table employees;

-- list of employees, ranked by their salaries per department, starting with the highest
select department, employee_name, salary,
    row_number() over(
        partition by department
        order by salary desc) as rank
from employees;

-- list of employees with the highest salary in their department (using CTE subquery)
with cte1 as (
    select department, employee_name, salary,
        row_number() over(
            partition by department
            order by salary desc) as rank
    from employees
    order by department)
select department, employee_name, salary
from cte1
where rank = 1;

-- list of employees with the highest salary in their department (using QUALIFY)
select department, employee_name, salary
from employees
qualify row_number() over(
    partition by department
    order by salary desc) = 1
order by department;

-- total salaries per department
select department, sum(salary) as total_salaries
from employees
group by 1;

-- employees with total salaries in their department
select employee_name,
    sum(salary) over (partition by department) as total_salaries
from employees
order by 1;

-- cumulative sum of salaries for the employees, in alphabetical order
-- (TODO: adapt per department)
select employee_name, salary,
    sum(salary) over (order by employee_name) as cum_salary
from employees
order by employee_name;

-- max salary between current employee and the next, in alphabetical order
-- (TODO: adapt per department)
select employee_name, salary,
    max(salary) over (
        order by employee_name
        rows between current row and 1 following) as max_salary
from employees
order by employee_name;

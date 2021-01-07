--1
select first_name, last_name from employees where salary > (select salary from employees where employee_id = 163)

--2
select first_name, last_name, salary, department_id, job_id from employees where department_id = (select department_id from employees where employee_id = 169)

--3
select first_name, last_name, salary, department_id, job_id from employees where salary = (select min(salary) from employees)

--4
select employee_id, first_name, last_name from employees where salary > (select avg(salary) from employees)

--5
select first_name, last_name, salary, employee_id from employees where manager_id = (select manager_id from employees where first_name = 'Payam')

--6
select * from employees where department_id = (select department_id from departments where department_name = 'Finance')

--7
select * from employees where salary = 3000 and manager_id = 121

--8
select * from employees where employee_id in (134, 159, 183)

--9
select * from employees where salary between 1000 and 3000

--10
select * from employees where salary between (select min(salary) from employees) and 2500

--11
select * from employees where department_id not in (SELECT department_id 
from departments 
where manager_id between 100 AND 200)

--12
select * from employees where salary = ( select salary from employees order by 1 desc limit 1 offset 2)

--13
select * from employees where first_name <> 'Clara' and department_id in (select department_id from employees where first_name = 'Clara')

--14
select * from employees where department_id in (select department_id from employees where first_name LIKE '%T%')

--15
select * from employees where salary > (select avg(salary) from employees) and  department_id in (select distinct(department_id) from employees where first_name LIKE '%J%')

--16
select * from employees where department_id in (select department_id from departments where location_id in (select location_id from locations where city = 'Toronto'))

--17
select * from employees where salary < any( select distinct(salary) from employees where job_id = 'MK_MAN')

--18
select * from employees where salary < any( select distinct(salary) from employees where job_id = 'MK_MAN') and job_id <> 'MK_MAN'

--19
select * from employees where salary > any( select distinct(salary) from employees where job_id = 'PU_MAN') and job_id <> 'PU_MAN'

--20
select * from employees where salary > (select avg(salary) from employees)

--21
SELECT first_name, last_name, department_id 
FROM employees 
WHERE EXISTS 
(SELECT * 
FROM employees 
WHERE salary >3700 );

--22
select department_id, sum(salary) from employees group by department_id having department_id in (select distinct(department_id) from employees)

select department_id, sum(salary) from employees group by department_id having count(employee_id) > 0

--23
select employee_id, 'SALESMAN' as modified_job_title from employees where job_id = 'ST_MAN'
UNION
select employee_id, 'DEVELOPER' as modified_job_title from employees where job_id = 'IT_PROG'

--24
select employee_id, first_name || ' ' || last_name as name, salary, 'LOW' as SalaryStatus from employees where salary < (select avg(salary) from employees)
UNION
select employee_id, first_name || ' ' || last_name as name, salary, 'HIGH' as SalaryStatus from employees where salary >= (select avg(salary) from employees)

--25
select employee_id, first_name || ' ' || last_name as name, salary as SalaryDrawn, (salary - (select avg(salary) from employees)) as AvgCompare, 'LOW' as SalaryStatus from employees where salary < (select avg(salary) from employees)

UNION

select employee_id, first_name || ' ' || last_name as name, salary as SalaryDrawn, (salary - (select avg(salary) from employees)) as AvgCompare, 'HIGH' as SalaryStatus from employees where salary >= (select avg(salary) from employees)

--26
select * from departments where department_id in (select distinct(department_id) from employees)

--27
select * from employees where department_id in (select department_id from departments where location_id in (select location_id from locations where country_id in (select country_id from countries where country_name = 'United Kingdom')))

--28
select * from employees where salary > (select avg(salary) from employees) and department_id in (select department_id from departments where department_name LIKE '%IT%')

--29
select * from employees where salary > any (select salary from employees where last_name ='Ozer')

--30
select * from employees where manager_id in (select employee_id from employees where department_id in (select distinct(department_id) from departments natural join locations where country_id = 'US'))

--31
select * from employees as e where salary > 0.5*(select sum(salary) from employees where department_id = e.department_id)

--32
select * from employees where employee_id in (select distinct(manager_id) from departments)

--33
select * from employees where employee_id in (select distinct(manager_id) from departments)
--ili alternativno
select * from employees as e where exists (select * from departments where manager_id = e.employee_id)

--34
select * from employees select * from employees where salary = (select max(salary) from employees where hire_date between '2002-01-01' and '2003-12-31')

--35
select department_id, department_name from departments natural join locations where city='London'

--36
select * from employees where salary > (select avg(salary) from employees) order by salary desc

--37
select * from employees where salary > (select max(salary) from employees where department_id = 40)

--38
select * from departments where location_id = (select location_id from departments where department_id = 30)

--39
name, salary, and department ID for all those employees who work in that department where the empl

--40
select * from employees as e where salary in (select salary from employees where department_id = 40)

--41
select * from employees natural join departments where department_name = 'Marketing'

--42
select * from employees where salary > (select min(salary) from employees where department_id = 40)

--43
select * from employees where hire_date > (select hire_date from employees where employee_id = 165)

--44
select * from employees where salary < (select min(salary) from employees where department_id = 70)

--45
select * from employees where salary < (select avg(salary) from employees) and department_id in (select department_id from employees where first_name = 'Laura')

--46
select first_name, last_name, salary, d.department_id from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id where city = 'London'

--47
select l.city from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id where e.employee_id = 134

--48
select * from departments where department_id in (select department_id from employees e where employee_id in (select employee_id from job_history group by employee_id having count(employee_id) > 1 ) group by department_id having max(salary) > 7000)

--49
select * from departments where department_id in (select distinct(department_id) from employees where salary > 8000)

--50
select * from departments where department_id in (select distinct(department_id) from employees where salary > 8000)

--51
select first_name, last_name, job_id from employees where employee_id in (select employee_id from job_history jh join jobs j on jh.job_id = j.job_id where job_title = 'Sales Representative')

--52
select * from employees where salary = (select distinct(salary) from employees order by 1 limit 1 offset 1)

--53
select * from departments where manager_id in (select employee_id from employees where first_name = 'Susan')

--54
select * from employees as e where salary = (select max(salary) from employees where department_id = e.department_id)

--55
select * from employees where employee_id not in (select employee_id from job_history)

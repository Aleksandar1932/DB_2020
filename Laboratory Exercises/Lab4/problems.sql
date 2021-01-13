--1 
select e.name, e.surname, telephone_number from Employee e JOIN Employee_numbers en on e.id = en.id

--2
select e.name, e.surname, telephone_number 
from Employee e JOIN Employee_numbers en on e.id = en.id
where telephone_number like '070%' or telephone_number like '071%' or telephone_number like '072%'

--3 (A1 e 076)
select e.* from Employee e JOIN Employee_numbers en on e.id = en.id
where telephone_number not like '076%'

--4
select ssn from AGENT_SELER intersect select ssn from agent_manager

--5
select ssn from AGENT_SELER union select ssn from agent_manager

--6
select c.ssn as customer_ssn, c.name as customer_name, c.surname as customer_surname, e.ssn as assigned_employee_ssn, e.name as assigned_employee_name, e.surname assigned_employee_surname from 
CUSTOMER c JOIN Employee e on c.assigned_agent_ssn_ = e.ssn
where c.ssn like '7%'

--7
select * from Product_Review where grade > 2

--8
select * from store_review where grade > 2

--9
select count(*) as total_number_of_talks from scheduled_talks where AGENT_SELLER_SSN Like '1%' and duration > 30

--10
select count(*) as num_seller_and_manager_agents from (select ssn from AGENT_SELER intersect select ssn from agent_manager)

--11
select count(*) as num_seller_or_manager_agents from (select ssn from AGENT_SELER intersect select ssn from agent_manager)


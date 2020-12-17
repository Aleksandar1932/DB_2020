CREATE TABLE IF NOT EXISTS salesman
(
    "salesman_id" INT   NULL,
    "name"        TEXT  NULL,
    "city"        TEXT  NULL,
    "commission"  FLOAT NULL,

    primary key (salesman_id)
);

INSERT INTO salesman
VALUES (5001, 'James Hoog', 'New York', 0.15),
       (5002, 'Nail Knite', 'Paris', 0.13),
       (5005, 'Pit Alex', 'London', 0.11),
       (5006, 'Mc Lyon', 'Paris', 0.14),
       (5007, 'Paul Adam', 'Rome', 0.13),
       (5003, 'Lauson Hen', 'San Jose', 0.12);

CREATE TABLE IF NOT EXISTS customer
(
    "customer_id" INT,
    "cust_name"   TEXT,
    "city"        TEXT,
    "grade"       TEXT,
    "salesman_id" INT,

    primary key (customer_id)
);

INSERT INTO customer
VALUES (3002, 'Nick Rimando', 'New York', '100', 5001),
       (3007, 'Brad Davis', 'New York', '200', 5001),
       (3005, 'Graham Zusi', 'California', '200', 5002),
       (3008, 'Julian Green', 'London', '300', 5002),
       (3004, 'Fabian Johnson', 'Paris', '300', 5006),
       (3009, 'Geoff Cameron', 'Berlin', '100', 5003),
       (3003, 'Jozy Altidor', 'Moscow', '200', 5007),
       (3001, 'Brad Guzan', 'London', '', 5005);

-- 1
SELECT salesman_id, commission
FROM salesman;

-- 2
SELECT name, city
FROM salesman
WHERE city = 'Paris';

--3
SELECT *
from customer
where grade = '200';

-- 4
select *
from customer
where grade > 100;

--5
select *
from customer
where city = 'New York'
  and grade > 100;

--6
select *
from customer
where city = 'New York'
   or grade > 100;

--7
select *
from customer
where city = 'New York'
   or not grade > 100;

--8
select *
from customer
where not (city = 'New York' or grade > 100);

CREATE TABLE IF NOT EXISTS orders
(
    ord_no      INT PRIMARY KEY,
    purch_amt   FLOAT,
    ord_date    DATE,
    customer_id INT,
    salesman_id INT,

    CONSTRAINT customer_fk FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    CONSTRAINT salesman_fk FOREIGN KEY (salesman_id) REFERENCES salesman (salesman_id)
);

INSERT INTO orders
VALUES (70001, 150.5, '2012-10-05', 3005, 5002),
       (70009, 270.65, '2012-09-10', 3001, 5005),
       (70002, 65.26, '2012-10-05', 3002, 5001),
       (70004, 110.5, '2012-08-17', 3009, 5003),
       (70007, 948.5, '2012-09-10', 3005, 5002),
       (70005, 2400.6, '2012-07-27', 3007, 5001),
       (70008, 5760, '2012-09-10', 3002, 5001),
       (70010, 1983.43, '2012-10-10', 3004, 5006),
       (70003, 2480.4, '2012-10-10', 3009, 5003),
       (70012, 250.45, '2012-06-27', 3008, 5002),
       (70011, 75.29, '2012-08-17', 3003, 5007),
       (70013, 3045.6, '2012-04-25', 3002, 5001);

--9
select *
from orders
where (ord_date > '2012-09-10' and salesman_id > 5005)
   or purch_amt > 1000;

--10/11
select *
from salesman
where city in ('Paris', 'Rome');

--12
select *
from salesman
where city not in ('Paris', 'Rome');

--13
select *
from customer
where customer_id in (3007, 3008, 3009);

--14/15
select salesman_id, name, city, commission
from salesman
where commission between 0.10 and 0.12;

--16
select *
from orders
where purch_amt between 500 and 4000
  and purch_amt not in (948.50, 1983.43);

--17/18
select *
from salesman
where name ~ '^[A-K]';

--19
SELECT *
from customer
where cust_name ~ '^B';

--20
SELECT *
from customer
where cust_name ~ '\w+[n]';
select *
from customer
where cust_name like '%n';

--21
select *
from salesman
where salesman.name like 'N__l%';

--22
CREATE TABLE IF NOT EXISTS "testtable"
(
    "col1" TEXT NULL
);

INSERT INTO testtable
VALUES ('A001/DJ-402\44_/100/2015'),
       ('A001_\DJ-402\44_/100/2015'),
       ('A001_DJ-402-2014-2015'),
       ('A002_DJ-401-2014-2015'),
       ('A001/DJ_401'),
       ('A001/DJ_402\44'),
       ('A001/DJ_402\44\2015'),
       ('A001/DJ-402%45\2015/200'),
       ('A001/DJ_402\45\2015%100'),
       ('A001/DJ_402%45\2015/300'),
       ('A001/DJ-402\44');

select *
from testtable
where col1 ~ '\_';

--23
select *
from testtable
where not (col1 ~ '\_');

--24
select *
from testtable
where col1 ~ '/';

--25
select *
from testtable
where not (col1 ~ '/');

--26
select *
from testtable
where col1 ~ '\_/';

--27
select *
from testtable
where not (col1 ~ '\_/');

--28
select *
from testtable
where col1 ~ '\%';

--29
select *
from testtable
where not (col1 ~ '\%');

--29
select *
from customer
where grade is null;

--30
select *
from customer
where grade is not null;

--31
select ord_no, purch_amt, (purch_amt / 6000) * 100 as "Achieved %", 1 - (purch_amt / 6000) * 100 as "Unchieved %"
from orders;

--32
select distinct(salesman_id)
from orders;

--33
select sum(purch_amt)
from orders;

--34
select avg(purch_amt)
from orders;

--35
select count(*)
from orders
where ord_date = '2012-08-17';

--36
select count(*)
from salesman
where city is not null;

--37
select count(distinct (salesman_id))
from orders;

--38
select count(*)
from customer;

--39
select count(*)
from customer
where grade is not null;

--40
select max(purch_amt)
from orders;

--41
select min(purch_amt)
from orders;

--42
select city, max(grade)
from customer
group by city;

--43
select customer_id, max(purch_amt)
from orders
group by customer_id;

--44
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date;

--45
select salesman_id, max(purch_amt) from orders where ord_date = '2012-08-17' group by salesman_id;

--46
select customer_id, ord_date, max(purch_amt) from orders group by customer_id, ord_date having max (purch_amt) > 2000;

select customer_id, ord_date, max(purch_amt) from orders where purch_amt > 2000 group by customer_id, ord_date;

--47
select salesman_id, ord_date, max(purch_amt) from orders group by salesman_id, ord_date having max(purch_amt) between  2000 and 6000;

--48
select customer_id, ord_date, max(purch_amt) from orders group by customer_id, ord_date having max(purch_amt) in(2000,3000,5760,6000);

--49
select customer_id, max(purch_amt) from orders group by customer_id having customer_id between 3002 and 3007;

--50
select customer_id, max(purch_amt) from orders where customer_id between 3002 and 3007 group by customer_id having max(purch_amt) > 1000;

--51
select salesman_id, max(purch_amt) from orders where salesman_id between 5003 and 5008 group by salesman_id;

--52
select salesman_id, ord_date from orders group by salesman_id, ord_date;

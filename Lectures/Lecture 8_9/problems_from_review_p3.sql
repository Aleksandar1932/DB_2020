--86
select *
from customer
where exists(select * from customer where city in ('London'));

--87
select *
from salesman
where salesman_id in (select distinct salesman_id
                      from customer a
                      where exists(select *
                                   from customer b
                                   where b.salesman_id = a.salesman_id
                                     and b.cust_name <> a.cust_name));

select *
from salesman
where salesman_id in (select salesman.salesman_id as num_custs
                      from salesman,
                           customer
                      where salesman.salesman_id = customer.salesman_id
                      group by salesman.salesman_id
                      having count(customer.customer_id) > 1);

--88
select *
from salesman
where salesman_id in (select salesman.salesman_id
                      from salesman,
                           customer
                      where salesman.salesman_id = customer.salesman_id
                      group by salesman.salesman_id
                      having count(customer.customer_id) = 1);

--89
select *
from salesman
where salesman_id in
      (select salesman.salesman_id
       from salesman,
            customer,
            orders
       where salesman.salesman_id = customer.salesman_id
         and customer.customer_id = orders.customer_id
       group by salesman.salesman_id, customer.customer_id
       having count(orders.customer_id) > 1
      );

--90
select *
from salesman as a
where exists(select * from customer b where a.name < b.cust_name);

--91
select *
from salesman as s
where exists(select * from customer as a where a.city = s.city);

--92
select *
from customer
where grade > (select avg(grade) from customer where city = 'New York');

--93
select *
from orders
where purch_amt > any (select purch_amt from orders where ord_date = '2012-09-10');

--94
select *
from orders
where purch_amt < any (select purch_amt
                       from orders,
                            customer
                       where orders.customer_id = customer.customer_id
                         and customer.city = 'London');

--95
select *
from orders
where purch_amt < (select max(orders.purch_amt)
                   from orders,
                        customer
                   where orders.customer_id = customer.customer_id
                     and customer.city = 'London');

--96
select *
from customer
where grade > all (select grade from customer where city = 'New York');

--97
select *
from customer
where grade <> all (select grade from customer where city = 'London');

--98
select *
from customer
where grade <> all (select grade from customer where city = 'Paris');

--99
select *
from customer
where grade <> all (select grade from customer where city = 'Dallas');

--100
select name, city, total
from (select a.salesman_id as id, sum(purch_amt) as total
      from (select * from salesman where city in (select city from customer)) as a
               join orders on a.salesman_id = orders.salesman_id
      group by a.salesman_id) as b
         join salesman on b.id = salesman.salesman_id;
         
--101
select customer_id, cust_name, 'Customer' as type
from customer
where city = 'London'
UNION
select salesman_id, name, 'Salesman' as type
from salesman
where city = 'London';

--102
select salesman_id, city
from salesman
UNION
select customer_id, city
from customer;

--103
select salesman_id as id
from salesman
UNION
select customer_id as id
from customer;

--104
select ord_no, ord_date, salesman_id, 'HIGH' as type
from orders
where purch_amt = any (select max(purch_amt) from orders group by ord_date)
union
select ord_date, salesman_id, 'LOW' as type
from orders
where purch_amt = any (select min(purch_amt) from orders group by ord_date);

--105
select *
from (
         select ord_no, ord_date, salesman_id, 'HIGH' as type
         from orders
         where purch_amt = any (select max(purch_amt) from orders group by ord_date)
         union
         select ord_no, ord_date, salesman_id, 'LOW' as type
         from orders
         where purch_amt = any (select min(purch_amt) from orders group by ord_date)
     ) as a
order by a.ord_no;

--106
select salesman.salesman_id
from salesman,
     customer
where salesman.city <> customer.city
union
select salesman.salesman_id
from salesman,
     customer
where salesman.city = customer.city

select distinct(salesman_id)
from customer;

-- 107
select salesman_id, city, 'YES' as has_customer_from_same_city
from salesman as a
where salesman_id in
      (select salesman_id from customer where customer.salesman_id = a.salesman_id and a.city = customer.city)

union
select salesman_id, city, 'NO'
from salesman as a
where salesman_id in
      (select salesman_id from customer where customer.salesman_id = a.salesman_id and a.city <> customer.city);

--108
SELECT customer_id, city, grade, 'High Rating'
FROM customer
WHERE grade >= 300
UNION
SELECT customer_id, city, grade, 'Low Rating'
FROM customer
WHERE grade < 300;

--109
select a.salesman_id, a.customer_id, salesman.name, customer.cust_name
from (select salesman_id, customer_id from orders group by salesman_id, customer_id having count(ord_no) > 1) as a
         join customer on a.customer_id = customer.customer_id
         join salesman on a.salesman_id = salesman.salesman_id;


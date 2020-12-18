--53
select salesman_id, name, city, '%', commission * 100
from salesman;

--54
select 'For', ord_date, 'there are', count(ord_no), 'orders'
from orders
group by ord_date;

--55
select *
from orders
order by ord_no;

--56
select *
from orders
order by ord_date desc;

--57
select *
from orders
order by ord_date desc, purch_amt desc;

--58
select cust_name, city, grade
from customer
order by customer_id;

--59
select salesman_id, ord_date, max(purch_amt)
from orders
group by salesman_id, ord_date
order by salesman_id asc, ord_date asc;

--60
select cust_name, city, grade
from customer
order by grade desc;

--61
select customer_id, count(ord_no), max(purch_amt)
from orders
group by customer_id
order by count(ord_no) desc, max(purch_amt) desc;

--62
select ord_date, sum(purch_amt), (sum(purch_amt) * 0.15)
from orders
group by ord_date
order by ord_date;

--63
-- od company
--64
-- od company

--65
select customer.cust_name, salesman.name, salesman.city
from customer,
     salesman
where customer.city = salesman.city;

--66
select customer.cust_name, salesman.name
from customer,
     salesman
where customer.salesman_id = salesman.salesman_id;

--67
select orders.ord_no, customer.cust_name, orders.customer_id, orders.salesman_id
from orders,
     customer,
     salesman
where orders.customer_id = customer.customer_id
  and orders.salesman_id = salesman.salesman_id
  and salesman.city <> customer.city;

--68
select orders.ord_no, customer.cust_name
from orders,
     customer
where orders.customer_id = customer.customer_id;

--69
select customer.cust_name, customer.grade
from customer,
     orders,
     salesman
where orders.customer_id = customer.customer_id
  and orders.salesman_id = salesman.salesman_id
  and customer.grade is not null
  and salesman.city is not null;

--70
select customer.cust_name, customer.city, salesman.city, salesman.commission
from customer,
     orders,
     salesman
where orders.salesman_id = salesman.salesman_id
  and orders.customer_id = customer.customer_id
  and salesman.commission between 0.12 and 0.14;

--71
select orders.ord_no,
       customer.cust_name,
       salesman.commission,
       (orders.purch_amt * salesman.commission) as "Zarabotena"
from orders,
     customer,
     salesman
where orders.salesman_id = salesman.salesman_id
  and orders.customer_id = customer.customer_id
  and CAST(customer.grade as INTEGER) > 200;

--72
select *
from customer,
     orders
where orders.customer_id = customer.customer_id
  and ord_date = '2012-10-05';

--73
select *
from orders
where orders.salesman_id in (select salesman_id from salesman where name = 'Paul Adam');

--74
select *
from orders
where orders.salesman_id in (select salesman_id from salesman where city = 'London');

--75
select *
from orders
where salesman_id = (select distinct (salesman_id) from orders where customer_id = '3007');

--76
select *
from orders
where purch_amt > (select avg(purch_amt) from orders where ord_date = '2012-10-10');

--77
select *
from orders
where salesman_id in (select salesman_id from salesman where city = 'New York');

--78
select salesman.commission
from orders,
     salesman
where orders.salesman_id = salesman.salesman_id
  and customer_id in
      (select customer_id from customer where customer.city = 'Paris');

--79
select *
from customer
where customer_id = (select salesman_id - 2001 from salesman where name = 'Mc Lyon');

--80
select customer.grade, count(*)
from customer
group by grade
having customer.grade > (select avg(grade) from customer where city = 'New York');

--81
select *
from orders
where salesman_id in (select salesman_id
                      from salesman
                      where commission = (
                          select max(commission)
                          from salesman
                      ));

--82
select salesman_id, name
from salesman
where salesman_id in (select salesman_id from customer group by salesman_id having count(*) > 1);

--83
select *
from orders as a
where purch_amt > (select avg(purch_amt) from orders as b where a.customer_id = b.customer_id);

--84
select *
from orders as a
where purch_amt >= (select avg(purch_amt) from orders as b where a.customer_id = b.customer_id);

--85
select ord_date, sum(purch_amt)
from orders as a
group by ord_date
having sum(purch_amt) > (select 1000 + max(purch_amt) from orders as b where a.ord_date = b.ord_date);

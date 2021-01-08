--126
select customer.cust_name customer_name, salesman.name salesman_name from customer join salesman on customer.salesman_id = salesman.salesman_id and customer.city = salesman.city;

--127
Select ord_no, purch_amt, cust_name, city from (select * from orders where purch_amt BETWEEN 500 and 2000) as Orders500_2000 join customer on Orders500_2000.customer_id = customer.customer_id

--128
select customer.cust_name, customer.city, salesman.name as salesman_name, salesman.commission as commission from customer join salesman on customer.salesman_id = salesman.salesman_id

--129
select * from customer where salesman_id in (select salesman_id from salesman where salesman.commission > 0.12)

--130
select * 
from customer join salesman on customer.salesman_id = salesman.salesman_id
WHERE customer.city <> salesman.city AND salesman.commission > 0.12

--131
select orders.ord_no, orders.ord_date, orders.purch_amt, customer.cust_name, salesman.name as salesman_name, salesman.commission  as salesman_commision
from orders join customer on orders.customer_id = customer.customer_id join salesman on orders.salesman_id = salesman.salesman_id

--132
select * from orders NATURAL join customer NATURAL join salesman

--133
SELECT customer.cust_name, customer.city 
from customer left OUTER join salesman on customer.salesman_id = salesman.salesman_id
order by customer.customer_id

--134
SELECT customer.cust_name, customer.city 
from customer left OUTER join salesman on customer.salesman_id = salesman.salesman_id
where customer.grade < 300
order by customer.customer_id

--135
select customer.cust_name, customer.city, orders.ord_no, orders.ord_date, orders.purch_amt
from customer left outer join orders on customer.customer_id = orders.customer_id
order by orders.ord_date

--136
select customer.cust_name, customer.city, orders.ord_no, orders.ord_date, orders.purch_amt, salesman.name, salesman.commission
from customer left outer join orders on customer.customer_id = orders.customer_id LEFT OUTER JOIN salesman on orders.salesman_id = salesman.salesman_id
order by orders.ord_date

--137
select salesman.name as salesman_name, salesman.city salesman_city, customer.cust_name customer_name
from salesman left outer join customer on salesman.salesman_id = customer.salesman_id
order by salesman.salesman_id

--138
select * FROM salesman where salesman_id in (select DISTINCT salesman.salesman_id
from salesman left outer join customer on salesman.salesman_id = customer.salesman_id left OUTer join orders on salesman.salesman_id = orders.salesman_id
order by salesman.salesman_id)

--139
select *
from customer 
right OUTer join salesman
on customer.salesman_id = salesman.salesman_id
LEFT outer join orders
on orders.customer_id = customer.customer_id
where orders.purch_amt > 2000 and customer.grade is not null

--140
select customer.cust_name, customer.city, orders.ord_no, orders.purch_amt
from customer
FULL outer join orders
on customer.customer_id = orders.customer_id

--141
select customer.cust_name, customer.city, orders.ord_no, orders.purch_amt
from customer
FULL outer join orders
on customer.customer_id = orders.customer_id
WHERE customer.grade is not null

--142
SELECT * FROM customer CROSS JOIN salesman

--143
SELECT * FROM customer CROSS JOIN (select * from salesman where city is not NULL and city <> '') as salesmans_w_city

--144
SELECT * FROM (SELECT * from customer WHERE grade is not null and grade <> '') customers_with_grade CROSS JOIN (select * from salesman where city is not NULL and city <> '') as salesmans_w_city

--145
SELECT * FROM (SELECT * from customer WHERE grade is not null and grade <> '') customers_with_grade CROSS JOIN salesman where customers_with_grade.city <> salesman.city

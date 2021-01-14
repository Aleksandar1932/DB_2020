--1
select * from scheduled_talks where duration > (select avg(duration) from scheduled_talks)


--2
select customer_ssn, count(*)
from purchase p, stock s, Store, Store_Review sr
where s.store_id = sr.store_id and
sr.grade > (select avg(grade) from Store_Review where customer_id =p.customer_ssn )
and p.product_id = s.product_code
and p.customer_ssn = sr.customer_id
group by customer_ssn

--3
create view product_sells(product_id, number_of_sells) as(
select product_id, count(*) as count from PURCHASE
group by product_id)

select p.*, c.name 
from product p  join Category c on p.category_id = c.id
where code = (select product_id from product_sells where number_of_sells = (select max(number_of_sells) from product_sells))

--4
select * from store where id in (select distinct store_id 
from STORE_REVIEW sr
where sr.grade > 1
and sr.customer_id in (select p.customer_ssn from PURCHASE p where p.customer_ssn = sr.customer_id and quantity > 1))

--5
create view agent_total_minutes(agent_ssn, total) as (
select agent_seller_ssn, sum(duration)
from SCHEDULED_TALKS
group by agent_seller_ssn)

select agent_ssn from agent_total_minutes where total = (select max(total) from agent_total_minutes)
--6
select * from stock join store on stock.store_id = store.id

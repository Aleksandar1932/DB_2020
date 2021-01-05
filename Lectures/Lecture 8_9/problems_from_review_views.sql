--110

create view NY_salesmans as

select *

from salesman

where city = 'New York';



--111

create view NY_salesmans_13 as

select *

from salesman

where city = 'New York'

  and commission > 0.13;



--112

create view NY_salesman_partial_details as

select salesman_id, city, name

from salesman;



--113

create view gradecount(grade, number) as

select grade, count(*)

from customer

group by grade;



--114

create view totalForDay(date, number_customers, total_amt, avg_amt)

as

select ord_date, count(customer_id), sum(purch_amt), avg(purch_amt)

from orders

group by ord_date;



--115

create view detailedOrder

as

select *

from orders,

     customer,

     salesman

where orders.customer_id = customer.customer_id

  and orders.salesman_id = salesman.salesman_id;



--116

create view highestGradeCustomers as

select *

from customer

where grade = (select max(grade) from customer);



--117

create view highestOrderSalesman as

select a.salesman_id, a.ord_date

from orders as a

where a.purch_amt = (select max(purch_amt) from orders b where a.ord_date = b.ord_date)



--118

create view highestOrderSalesman3Days as

select *

from highestOrderSalesman as a

where 3 <= (select count(Distinct (ord_date))

            from highestOrderSalesman as b

            where a.salesman_id = b.salesman_id)



--119

create view salesmanPerCity(city, numberSalesman) as

select city, count(distinct (salesman_id))

from salesman

group by city;



--120

create view norders as

select name, sum(purch_amt), avg(purch_amt)

from orders,

     salesman

where orders.salesman_id = salesman.salesman_id

group by name;



--121

create view mcustomer

as

select *

from salesman

where salesman_id in

      (select salesman_id from customer group by salesman_id having count(customer_id) > 1)



--122

create view citymatch(customerCity, salesmanCity) as

select customer.city, salesman.city

from customer,

     salesman

where customer.salesman_id = salesman.salesman_id;



--123

create view numberOrdersPerDate as

select ord_date, count(*)

from orders

group by ord_date;



--124

create view salesmanoct10 as

select *

from salesman

where salesman_id in (select salesman_id from orders where ord_date = '2012/10/10');



--124

create view salesmanoct10oraug as

select *

from salesman

where salesman_id in (select salesman_id from orders where ord_date = '2012/10/10' or ord_date = '2012/08/17');

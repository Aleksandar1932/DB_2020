-- 1
select * from Shipper;

-- 2
Select * from Category;

-- 3
Select * from Employee where title = "Sales Representative";

-- 4
select * from Employee  where title = "Sales Representative" and country = "USA";

--5
Select id, orderdate from "Order" WHERE employeeid = 5;

--6
select * from Supplier where ContactTitle <> 'Marketing Manager';

--7
select id as ProductID, productName from Product where productname LIKE "%queso%";

--8
select id, customerid, shipcountry from "Order" WHERE shipcountry in ("France", "Belgium");

--9
select id, customerid, shipcountry from "Order" where shipcountry in ('Brazil', 'Mexico','Argentina','Venezuela');

-- 10
select * from Employee order by birthdate;

-- 11
-- nema potreba glupavo e

-- 12
select firstname || ' ' || lastname as FullName from Employee;

--13
select *, unitprice * quantity as totalprice from OrderDetail order by (totalprice) desc;

-- 14
select Count(DISTINCT(id)) as num_customers from Customer;

-- 15
select Min(OrderDate) as date_of_frist_order from "Order";

-- 16
select DISTINCT(Country) from Customer;

--17
select Customer.ContactTitle, count(distinct(Customer.Id)) as count from Customer GROUP by Customer.ContactTitle order by 2;

--18
select Product.*, Supplier.companyname from Product Join Supplier on Product.SupplierId = Supplier.Id;

--19
SELECT o.*, Shipper.CompanyName from "Order" as o JOIN Shipper ON o.ShipVia = Shipper.Id;

--20
select Category.categoryname, count(Product.Id) from Product Join Category on Product.CategoryId = Category.Id GROUP by Category.categoryname;

--21
select Customer.City, Count(Customer.Id) from Customer Group by Customer.City order by 2 desc;
select Customer.country, count(Customer.Id) from Customer GROUP by Customer.country order by 2 desc;

--22
select id, productname, unitsinstock, reorderlevel from Product Where unitsinstock < reorderlevel;

--23
select id, productname, unitsinstock, reorderlevel from Product Where unitsinstock + unitsonorder <= reorderlevel and discontinued = 0;

--24
select * from Customer order by Region, id

--25
select shipcountry, avg(freight) from "Order" group by shipcountry order by 2 desc limit 3

--26
select ShipCountry, sum(freight) from "Order" where strftime('%Y', OrderDate) = '2015' GROUP by shipcountry order by 2 desc limit 3;

--27
select ShipCountry, sum(freight), strftime('%Y',Date('now') - OrderDate) AS DateDiff 
from "Order" where strftime('%Y', OrderDate) = '2015' GROUP by shipcountry order by 2 desc limit 3;

--28
select ShipCountry, avg(freight)
from "Order" where OrderDate BETWEEN (select date(max(orderdate), '-1 year') from "Order")  and  (select max(orderdate) from "Order")
group by ShipCountry
order by 2 desc
limit 3

--29
select employeeid, Employee.lastname, orderid, Product.productname, quantity from "Order" as o 
JOIN OrderDetail ON o.Id = OrderDetail.orderid 
JOIN Employee on o.employeeid = Employee.Id
JOIN Product on Product.Id = OrderDetail.productid 

--30
select * from Customer where not EXISTS (Select * from "Order" as o where o.customerid = Customer.Id)

--31
select * from Customer where not EXISTS (Select * from "Order" as o where o.customerid = Customer.Id and  o.employeeid = 4)

--31
select * from Customer WHERE NOT EXISTS (Select * from "Order" o where o.customerid = customer.Id and o.employeeid = 4)

--32
select DISTINCT(CustomerId),orderid, companyname, total_op FROM(
(SELECT OrderId, total_op from (select OrderId, SUM(unitprice * quantity) as total_op
from "OrderDetail" 
GROUP by OrderId)
WHERE total_op > 10000) as t1 JOIN "Order" o on t1.OrderId = o.Id
and o.orderdate BETWEEN '2016-01-01' and '2016-12-31') JOIN Customer on CustomerId = Customer.Id;

--33
select DISTINCT(CustomerId),orderid, companyname, total_op FROM(
(SELECT OrderId, total_op from (select OrderId, SUM(unitprice * quantity) as total_op
from "OrderDetail" 
GROUP by OrderId)
WHERE total_op >= 15000) as t1 JOIN "Order" o on t1.OrderId = o.Id
and o.orderdate BETWEEN '2016-01-01' and '2016-12-31') JOIN Customer on CustomerId = Customer.Id;

--34
select DISTINCT(CustomerId),orderid, companyname, total_op_disc FROM(
(SELECT OrderId, total_op_disc from (select OrderId, SUM((unitprice * quantity) * (1-discount)) as total_op_disc
from "OrderDetail" 
GROUP by OrderId)
WHERE total_op_disc >= 10000) as t1 JOIN "Order" o on t1.OrderId = o.Id
and o.orderdate BETWEEN '2016-01-01' and '2016-12-31') JOIN Customer on CustomerId = Customer.Id;

--35
select employeeid, id, orderdate from "Order"
where strftime("%d", OrderDate) = strftime("%d", date(OrderDate,'start of month','+1 month','-1 day'))
order by 1,2;

--36
select Distinct(OrderId), COUNT(*)  totalOrderItems from OrderDetail
group by OrderId
order by 2 desc

--37
SELECT *,random()  as rnd
FROM "Order"
order by rnd
LIMIT (select ROUND(count(*) * 0.2,0) from "Order")

--38
create view if not exists tmp1 as 
select * from OrderDetail od, "Order" o
where od.OrderId = o.id 
and o.employeeid  = (Select id from Employee Where firstname = 'Janet' and lastname = 'Leverling') 
and quantity > 60;

select a.orderid
FROM
tmp1 a, tmp1 b
where
a.orderid = b.orderid
and a.productid<> b.productid
and a.quantity = b.quantity

--39
-- samo join so order po orderid

--40
-- veke napraveno

--41
SELECT * FROM "Order"
where shippeddate > requireddate

--42
select * from Employee where Employee.Id in (SELECT distinct(employeeid) FROM "Order"
where shippeddate > requireddate)

--43/44/45
select * from ((SELECT EmployeeId, count(*) as totalLate
FROM "Order"
where shippeddate > requireddate
GROUP by employeeid) as total_late

NATURAL JOIN

(SELECT EmployeeId, count(*) as total_orders
FROM "Order"
GROUP by employeeid))

--46/47
select *, printf("%.4f %%",(totalLate*1.0/total_orders*1.0)*100) as missing_percentage

from ((SELECT EmployeeId, count(*) as totalLate
FROM "Order"
where shippeddate > requireddate
GROUP by employeeid) as total_late

NATURAL JOIN

(SELECT EmployeeId, count(*) as total_orders
FROM "Order"
GROUP by employeeid) )
order by 4 desc

--48
select *,
CASE  
       WHEN total_per_customer >= 0 and total_per_customer < 10000 THEN '[0-10000)' 
       wHEN total_per_customer >= 10000 and total_per_customer < 50000 THEN '[10000-50000)' 
       wHEN total_per_customer >= 50000 and total_per_customer < 100000 THEN '[50000-100000)' 
       wHEN total_per_customer >= 100000 THEN '[100000 + inf)' 
       END CustomerGroup
from 
(select customerid, sum(total_op) as total_per_customer from (
select o.id, customerid, ((od.UnitPrice*od.quantity)*(1-od.Discount)) as total_op
from "Order" o, OrderDetail od
where strftime("%Y", orderdate) = '2016'
and o.id = od.OrderId)
GROUP by customerid)
order by 1

--49/50
create view if not EXISTS tmp2  as
select *,
CASE  
       WHEN total_per_customer >= 0 and total_per_customer < 10000 THEN '[0-10000)' 
       wHEN total_per_customer >= 10000 and total_per_customer < 50000 THEN '[10000-50000)' 
       wHEN total_per_customer >= 50000 and total_per_customer < 100000 THEN '[50000-100000)' 
       wHEN total_per_customer >= 100000 THEN '[100000 + inf)' 
       END CustomerGroup
from 
(select customerid, sum(total_op) as total_per_customer from (
select o.id, customerid, ((od.UnitPrice*od.quantity)*(1-od.Discount)) as total_op
from "Order" o, OrderDetail od
where strftime("%Y", orderdate) = '2016'
and o.id = od.OrderId)
GROUP by customerid)
order by 1;


select CustomerGroup, Count(*) as clients_in_group,  printf("%.3f %%",(Count(*)*1.0/(select count(*) from tmp2))*100) as percentage
from tmp2
GROUP by CustomerGroup
order by 3 desc

--51
-- ja nemam tabelata no samo obicen join

--52
select distinct(country) from Supplier
UNION
select distinct(country) from Customer

--53
select distinct(country) from Supplier
FULL OUTER
select distinct(country) from Customer

--54
select t.Country, 
(Select count(distinct(Supplier.Id)) from Supplier where Supplier.country =t.Country) as suppliers,
(Select count(distinct(Customer.Id)) from Customer where Customer.country =t.Country) as customers
FROM
(select distinct(country) from Supplier
UNION
select distinct(country) from Customer) as t

--55
SELECT shipcountry, o.orderdate
from "Order" o
where orderdate = (select min(OrderDate) from "Order" o2 where o.shipcountry = o2.shipcountry )

--56/57
SELECT distinct(o1.customerid) FROM "Order" o1, "Order" o2
where o1.customerid = o2.customerid 
and o1.id <> o2.id
and abs(julianday(o1.orderdate) - julianday(o2.orderdate)) < 5

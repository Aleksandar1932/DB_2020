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

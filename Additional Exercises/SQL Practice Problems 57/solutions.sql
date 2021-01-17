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


-- source https://github.com/joshualloyd/chinook-sqlite/blob/master/README.md
--1
select * from Customer WHERE country <> 'USA'

--2
select * from Customer WHERE country = 'Brazil';

--3
select firstname || ' ' || lastname as full_name, invoiceid, invoice.InvoiceDate, Invoice.billingcountry
from (Select * from Customer where country='Brazil') as Customer
JOIN Invoice on Customer.CustomerId = Invoice.CustomerId;

--4
SELECT * from Employee WHERE title LIKE '%Agent%' and title LIKE '%sales%'

--5
select DISTINCT(Invoice.billingcountry) from Invoice

--6
SELECT Employee.firstname || ' ' || Employee.lastname as employee_full_name, Invoice.invoiceid from Invoice JOIN Customer on Invoice.customerid = Customer.customerid JOIN Employee ON Customer.supportrepid = Employee.EmployeeId

--7
select Customer.firstname || ' ' || Customer.lastname as customer_full_name, Invoice.total, Employee.firstname || ' ' || Employee.lastname as employee_full_name
from Invoice JOIN Customer on invoice.customerid = Customer.customerid join Employee on supportrepid = Employee.EmployeeId

--8.a
select COUNT(*) number_of_invoices from Invoice where Invoice.InvoiceDate BETWEEN '2009-01-01' AND '2011-12-31'
--8.b
Select invoice_year, COUNT(invoiceId) FROM  
(select invoiceid, strftime('%Y', invoicedate) as invoice_year  from Invoice where Invoice.InvoiceDate BETWEEN '2009-01-01' AND '2011-12-31')
GROUP By invoice_year

--9
select Count(invoicelineid) from InvoiceLine where invoiceid = 37

--10
select invoiceid, count(invoicelineid) lines_per_invoice from InvoiceLine GROUP by invoiceid

--11
select invoicelineid, name from InvoiceLine join Track on InvoiceLine.trackid = Track.TrackId

--12
select invoicelineid, name, composer from InvoiceLine join Track on InvoiceLine.trackid = Track.TrackId

--13
select billingcountry, count(invoiceid) invoices_per_country from Invoice group by  billingcountry

--14
select Playlist.playlistid, tracks_per_playlist, Playlist.name from (select playlistid, count(trackid)  as tracks_per_playlist from PlaylistTrack  GROUP BY playlistid) as p join Playlist on p.playlistid = Playlist.PlaylistId

--15
select Track.name as track_name, Album.Title as album_title, Genre.name as genre, MediaType.Name as media_type from Track join Album on Track.albumid = Album.albumid join Genre on Track.genreid = Genre.genreid JOIN MediaType on track.mediatypeid = MediaType.MediaTypeId

--16
select * from Invoice join InvoiceLine on Invoice.invoiceid = invoiceline.invoiceid

--17
select Employee.employeeid, employee.firstname || ' ' || Employee.lastname as employee_fullname, count(Invoice.invoiceid)  as number_of_sales
from invoice join Customer on Customer.customerid = invoice.customerid join Employee on Customer.supportrepid = Employee.employeeid
GROUP by Employee.employeeid

--18
select Employee.firstname || ' ' || Employee.lastname as employee_with_max_number_of_sales_in_2009
from Employee
where Employee.employeeid = 
(select employeeid from
(select employeeid, max(count_invoices) from  (select employeeid, count(invoiceid) as count_invoices from (select Invoice.invoiceid, Employee.employeeid, strftime('%Y', invoicedate) as year_date
from invoice join Customer on Customer.customerid = invoice.customerid join Employee on Customer.supportrepid = Employee.employeeid
WHERE year_date = '2009') group by employeeid)))

--19
select Employee.firstname || ' ' || Employee.lastname as employee_with_max_number_of_sales_in_2009
from Employee
where Employee.employeeid = 
(select employeeid from
(select employeeid, max(count_invoices) from  (select employeeid, count(invoiceid) as count_invoices from (select Invoice.invoiceid, Employee.employeeid, strftime('%Y', invoicedate) as year_date
from invoice join Customer on Customer.customerid = invoice.customerid join Employee on Customer.supportrepid = Employee.employeeid
WHERE year_date = '2010') group by employeeid)))

--20
select Employee.firstname || ' ' || Employee.lastname as employee_with_max_number_of_sales_in_2009
from Employee
where Employee.employeeid = 
(select employeeid from
(select employeeid, max(count_invoices) from  (select employeeid, count(invoiceid) as count_invoices from (select Invoice.invoiceid, Employee.employeeid, strftime('%Y', invoicedate) as year_date
from invoice join Customer on Customer.customerid = invoice.customerid join Employee on Customer.supportrepid = Employee.employeeid) group by employeeid)))

--21
select Employee.firstname || ' ' || Employee.lastname emp_full_name, number_of_customers from (select supportrepid, count(customerid) as number_of_customers from Customer
GROUP by supportrepid) as p join Employee on p.supportrepid = Employee.employeeid

--22
select billingcountry, COUNT(invoiceid)  as invoices_per_country from Invoice
GROUP by billingcountry
ORDER by 2 desc

--23
select * from track where trackid =  
 (select trackid from( select trackid, max(count_sales) from (select trackid, count(*) as count_sales
from InvoiceLine join Invoice on InvoiceLine.invoiceid = Invoice.invoiceid where strftime('%Y', Invoice.invoicedate) = '2013'
GROUP by trackid)))

--24
select trackid, count(*) as count_sales
from InvoiceLine join Invoice on InvoiceLine.invoiceid = Invoice.invoiceid
GROUP by trackid
ORDER by 2 desc
LIMIT 5

--25
select composer, count(invoicelineid) 
from InvoiceLine JOIN Track on InvoiceLine.trackid = Track.trackid
where composer not null
GROUP by composer
ORDER by 2 DESC
LIMIT 3

--26
select MediaType.Name from MediaType where MediaType.MediaTypeId = ( select mediatypeid from (select mediatypeid, max(count_lines) from (select mediatypeid, count(invoicelineid) as count_lines
from InvoiceLine join Track on invoiceline.trackid = track.trackid
GROUP by mediatypeid)))

--27
select InvoiceLine.invoiceid, count(*) from InvoiceLine JOIN Track on InvoiceLine.trackid = Track.trackid
GROUP by InvoiceLine.invoiceid
HAVING COUNT(genreid) > 1


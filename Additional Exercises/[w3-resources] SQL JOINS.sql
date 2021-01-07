-- https://www.w3resource.com/sql-exercises/sql-joins-exercises.php
-- 1. Write a SQL statement to prepare a list with salesman name, customer name and their cities for the salesmen and customer who belongs to the same city.
SELECT name, cust_name FROM salesman NATURAL JOIN customer;

-- 2. Write a SQL statement to make a list with order no, purchase amount, customer name and their cities for those orders which order amount between 500 and 2000.
SELECT orders.ord_no, orders.purch_amt, customer.cust_name, customer.city FROM (SELECT * FROM orders WHERE purch_amt BETWEEN 500 and 2000) as orders JOIN customer ON orders.customer_id = customer.customer_id;

-- 3. Write a SQL statement to know which salesman are working for which customer.
SELECT salesman.name, customer.cust_name FROM customer JOIN salesman ON customer.salesman_id = salesman.salesman_id;

-- 4. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12%.
SELECT cust_name FROM customer JOIN (SELECT * FROM salesman WHERE commission > 0.12) as salesman ON customer.salesman_id = salesman.salesman_id;

-- 5. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who does not live in the same city where their customer lives, and gets a commission is above 12%
SELECT cust_name FROM customer JOIN (SELECT * FROM salesman WHERE commission > 0.12) as salesman ON customer.salesman_id = salesman.salesman_id WHERE salesman.city <> customer.city;

-- 6. Write a SQL statement to find the details of a order i.e. order number, order date, amount of order, which customer gives the order and which salesman works for that customer and how much commission he gets for an order.
SELECT ord_no, ord_date, purch_amt, customer.cust_name, salesman.name, commission FROM orders JOIN customer on orders.customer_id = customer.customer_id JOIN salesman ON orders.salesman_id = salesman.salesman_id;

-- 7. Write a SQL statement to make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come.
SELECT * FROM orders JOIN salesman ON orders.salesman_id = salesman.salesman_id JOIN customer on orders.customer_id = customer.customer_id;

-- 8. Write a SQL statement to make a list in ascending order for the customer who works either through a salesman or by own.
SELECT a.cust_name,a.city,a.grade, 
b.name AS "Salesman",b.city 
FROM customer a 
LEFT JOIN salesman b 
ON a.salesman_id=b.salesman_id 
order by a.customer_id;

-- 9. Write a SQL statement to make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman or by own.
SELECT a.cust_name,a.city,a.grade, 
b.name AS "Salesman", b.city 
FROM customer a 
LEFT OUTER JOIN salesman b 
ON a.salesman_id=b.salesman_id 
WHERE a.grade<300 
ORDER BY a.customer_id;

-- 10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to find that either any of the existing customers have placed no order or placed one or more orders. 
SELECT cust_name, city, ord_no, ord_date, purch_amt FROM customer LEFT OUTER JOIN orders ON customer.customer_id = orders.customer_id ORDER BY ord_date;

-- 11. Write a SQL statement to make a report with customer name, city, order number, order date, order amount salesman name and commission to find that either any of the existing customers have placed no order or placed one or more orders by their salesman or by own.
SELECT cust_name, customer.city, ord_no, ord_date, purch_amt, salesman.name, salesman.commission FROM customer LEFT OUTER JOIN orders ON customer.customer_id = orders.customer_id LEFT OUTER JOIN salesman ON orders.salesman_id = salesman.salesman_id ORDER BY ord_date;

-- 12. Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers. 
SELECT salesman.salesman_id, salesman.name, salesman.city, salesman.commission FROM customer RIGHT OUTER JOIN salesman ON customer.salesman_id = salesman.salesman_id;

-- 13. Write a SQL statement to make a list for the salesmen who works either for one or more customer or not yet join under any of the customers who placed either one or more orders or no order to their supplier. 
SELECT salesman.salesman_id, salesman.name, salesman.city, salesman.commission FROM customer RIGHT OUTER JOIN salesman ON customer.salesman_id = salesman.salesman_id;

-- 14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
SELECT salesman.salesman_id, salesman.name, salesman.city, salesman.commission FROM (SELECT customer.salesman_id FROM customer LEFT OUTER JOIN orders ON customer.customer_id = orders.customer_id
WHERE ((ord_no IS NOT NULL AND purch_amt >= 2000 AND grade IS NOT NULL) OR TRUE )
) as customer RIGHT OUTER JOIN salesman ON customer.salesman_id = salesman.salesman_id;

-- 15. Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for those customers from the existing list who placed one or more orders or which order(s) have been placed by the customer who is not on the list.


-- 16. Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who is neither in the list not have a grade. 

-- 17. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa. 

-- 18. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for that salesman who belongs to a city.

-- 19. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who belongs to a city and the customers who must have a grade.  


-- 20. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who must belong a city which is not the same as his customer and the customers should have an own grade.

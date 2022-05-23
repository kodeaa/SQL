-- SQL Exercises 6 - Querying Multiple Tables
-- Medium post: https://medium.com/@aadata/sql-exercises-6-querying-multiple-tables-599c555c91b3

-- Tables
-- customer
-- customer_id |   cust_name    |    city    | grade | salesman_id 
---------------+----------------+------------+-------+-------------
--        3002 | Nick Rimando   | New York   |   100 |        5001
--        3007 | Brad Davis     | New York   |   200 |        5001
--        3005 | Graham Zusi    | California |   200 |        5002
--        3008 | Julian Green   | London     |   300 |        5002
--        3004 | Fabian Johnson | Paris      |   300 |        5006
--        3009 | Geoff Cameron  | Berlin     |   100 |        5003
--        3003 | Jozy Altidor   | Moscow     |   200 |        5007
--        3001 | Brad Guzan     | London     |       |        5005

-- orders
-- ord_no      purch_amt   ord_date    customer_id  salesman_id
-------------  ----------  ----------  -----------  -----------
-- 70001       150.5       2012-10-05  3005         5002
-- 70009       270.65      2012-09-10  3001         5005
-- 70002       65.26       2012-10-05  3002         5001
-- 70004       110.5       2012-08-17  3009         5003
-- 70007       948.5       2012-09-10  3005         5002
-- 70005       2400.6      2012-07-27  3007         5001
-- 70008       5760        2012-09-10  3002         5001
-- 70010       1983.43     2012-10-10  3004         5006
-- 70003       2480.4      2012-10-10  3009         5003
-- 70012       250.45      2012-06-27  3008         5002
-- 70011       75.29       2012-08-17  3003         5007
-- 70013       3045.6      2012-04-25  3002         5001

-- salesman
-- salesman_id |    name    |   city   | commission 
---------------+------------+----------+------------
--        5001 | James Hoog | New York |       0.15
--        5002 | Nail Knite | Paris    |       0.13
--        5005 | Pit Alex   | London   |       0.11
--        5006 | Mc Lyon    | Paris    |       0.14
--        5007 | Paul Adam  | Rome     |       0.13
--        5003 | Lauson Hen | San Jose |       0.12

-- Queries
-- 1. Find the salespersons and customers who live in same city. Return customer name, salesperson name and salesperson city.
SELECT c.cust_name, s.name, s.city
FROM customer AS c, salesman AS s
WHERE c.city = s.city

-- 2. Find all the customers along with the salesperson who works for them. Return customer name, and salesperson name.
SELECT c.cust_name, s.name
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id

-- 3. Find those sales people who generated orders for their customers but not located in the same city. Return ord_no, cust_name, customer_id (orders table), salesman_id (orders table).
SELECT o.ord_no, c.cust_name, o.customer_id, o.salesman_id
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
JOIN orders AS o
ON s.salesman_id = o.salesman_id
AND c.customer_id = o.customer_id
WHERE c.city <> s.city
ORDER BY o.ord_no

-- 4. Find those orders made by customers. Return order number, customer name.
SELECT o.ord_no, c.cust_name
FROM customer AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
AND c.salesman_id = o.salesman_id
ORDER BY o.ord_no

-- 5. Find those customers where each customer has a grade and served by at least a salesperson who belongs to a city. Return cust_name as “Customer”, grade as “Grade” and order_no as “Order No.”.
SELECT c.cust_name AS “Customer”, c.grade AS “Grade”, o.ord_no AS “Order No.”
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
JOIN orders AS o
ON c.customer_id = o.customer_id
AND s.salesman_id = o.salesman_id
WHERE c.grade IS NOT NULL
AND s.city IS NOT NULL

-- 6. Find those customers who served by a salesperson and the salesperson works at the commission in the range 12% to 14% (Begin and end values are included.). Return cust_name AS “Customer”, city AS “City”.
SELECT c.cust_name AS “Customer”, c.city AS “City”
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
WHERE s.commission BETWEEN 0.12 AND 0.14

-- 7. Find those orders executed by the salesperson, ordered by the customer whose grade is greater than or equal to 200. Compute purch_amt*commission as “Commission”. Return customer name, commission as “Commission%” and Commission.
SELECT o.ord_no, c.cust_name, commission AS “Commission%”, o.purch_amt*s.commission AS “Commission”
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
JOIN orders AS o
ON c.customer_id = o.customer_id
AND s.salesman_id = o.salesman_id
WHERE c.grade >= 200

-- 8. Find those customers who made orders on October 5, 2012. Return customer_id, cust_name, city, grade, salesman_id, ord_no, purch_amt, and ord_date.
SELECT *
FROM customer AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
AND c.salesman_id = o.salesman_id
WHERE o.ord_date = ‘2012–10–05’
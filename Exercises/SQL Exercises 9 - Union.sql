-- SQL Exercises 9 - Union
-- Medium post: https://medium.com/@aadata/sql-exercises-9-union-dae0c057457d

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

-- salesman
-- salesman_id |    name    |   city   | commission 
---------------+------------+----------+------------
--        5001 | James Hoog | New York |       0.15
--        5002 | Nail Knite | Paris    |       0.13
--        5005 | Pit Alex   | London   |       0.11
--        5006 | Mc Lyon    | Paris    |       0.14
--        5007 | Paul Adam  | Rome     |       0.13
--        5003 | Lauson Hen | San Jose |       0.12

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

-- Queries
-- 1. From the customer and salesman tables, find all salespersons and customer who located in ‘London’ city.
SELECT salesman_id AS id, name, city, ‘Salesman’
FROM salesman
WHERE city = ‘London’
UNION ALL
SELECT customer_id, cust_name, city, ‘Customer’
FROM customer
WHERE city = ‘London’

-- 2. From the salesman table, find distinct salesperson and their cities. Return salesperson ID and city.
SELECT salesman_id, city
FROM salesman
UNION
SELECT salesman_id, city
FROM salesman

-- 3. From the customer and orders tables, find all those salespersons and customers who involved in inventory management system. Return salesperson ID, customer ID.
SELECT salesman_id, customer_id
FROM customer
UNION
SELECT salesman_id, customer_id
FROM orders

-- 4. From the salesman and orders table, find those salespersons generated the largest and smallest orders on each date. Return salesperson ID, name, order no., highest on/ lowest on, order date.
SELECT s.salesman_id, s.name, o.ord_no, ‘highest on’, o.ord_date
FROM salesman AS s
JOIN orders AS o
ON s.salesman_id = o.salesman_id
WHERE o.purch_amt =
(
SELECT MAX(purch_amt) FROM orders AS o2 WHERE o.ord_date = o2.ord_date
)
UNION
SELECT s.salesman_id, s.name, o.ord_no, ‘lowest on’, o.ord_date
FROM salesman AS s
JOIN orders AS o
ON s.salesman_id = o.salesman_id
WHERE o.purch_amt =
(
SELECT MIN(purch_amt) FROM orders AS o2 WHERE o.ord_date = o2.ord_date
)

-- 5. From the customer and salesman table, find those salespersons who have same cities where customer lives as well as do not have customers in their cities and indicate it by ‘NO MATCH’. Sort the result set on 2nd column (i.e. name) in descending order. Return salesperson ID, name, customer name, commission.
SELECT s.salesman_id, s.name, c.cust_name, s.commission
FROM salesman AS s
CROSS JOIN customer AS c
WHERE s.city = c.city
UNION
SELECT salesman_id, name, ‘No Match’, commission
FROM salesman
WHERE city NOT IN (SELECT city FROM customer)
ORDER BY 2 DESC

-- 6. From the customer and salesman tables, appends strings to the selected fields, indicating whether a specified city of any salesperson was matched to the city of any customer. Return salesperson ID, name, city, MATCHED/NO MATCH.
SELECT s.salesman_id, s.name, s.city, ‘Matched’
FROM salesman AS s
CROSS JOIN customer AS c
WHERE s.city = c.city
UNION
SELECT salesman_id, name, city, ‘No Match’
FROM salesman
WHERE city NOT IN (SELECT city FROM customer)
ORDER BY 2 DESC

-- 7. From the customer table, create a union of two queries that shows the customer id, cities, and ratings of all customers. Those with a rating of 300 or greater will have the words ‘High Rating’, while the others will have the words ‘Low Rating’.
SELECT customer_id, city, grade, ‘High Rating’
FROM customer
WHERE grade >= 300
UNION
SELECT customer_id, city, grade, ‘Low Rating’
FROM customer
WHERE grade < 300
ORDER BY grade DESC

-- 8. From the customer, salesman and orders tables, find those salesperson and customer where more than one order executed. Sort the result-set on 2nd field. Return ID, name.
SELECT customer_id AS id, cust_name AS name
FROM customer
WHERE customer_id IN
(
SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(customer_id) > 1
)
UNION
SELECT salesman_id, name
FROM salesman
WHERE salesman_id IN
(
SELECT salesman_id FROM orders GROUP BY salesman_id HAVING COUNT(salesman_id) > 1
)
ORDER BY 2
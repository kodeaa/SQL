-- SQL Exercises 7 - Joins
-- Medium post: https://medium.com/@aadata/sql-exercises-7-joins-17c24d9bd2dd

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

-- company_mast
-- COM_ID COM_NAME
-------- -------------
--    11 Samsung
--    12 iBall
--    13 Epsion
--    14 Zebronics
--    15 Asus
--    16 Frontech

-- item_mast
-- PRO_ID PRO_NAME                       PRO_PRICE    PRO_COM
--------- ------------------------- -------------- ----------
--    101 Mother Board                    3200.00         15
--    102 Key Board                        450.00         16
--    103 ZIP drive                        250.00         14
--    104 Speaker                          550.00         16
--    105 Monitor                         5000.00         11
--    106 DVD drive                        900.00         12
--    107 CD drive                         800.00         12
--    108 Printer                         2600.00         13
--    109 Refill cartridge                 350.00         13
--    110 Mouse                            250.00         12

-- emp_department
-- DPT_CODE DPT_NAME        DPT_ALLOTMENT
---------- --------------- -------------
--      57 IT                      65000
--      63 Finance                 15000
--      47 HR                     240000
--      27 RD                      55000
--      89 QC                      75000

-- emp_details
-- EMP_IDNO EMP_FNAME       EMP_LNAME         EMP_DEPT
----------- --------------- --------------- ----------
--   127323 Michale         Robbin                  57
--   526689 Carlos          Snares                  63
--   843795 Enric           Dosio                   57
--   328717 Jhon            Snares                  63
--   444527 Joseph          Dosni                   47
--   659831 Zanifer         Emily                   47
--   847674 Kuleswar        Sitaraman               57
--   748681 Henrey          Gabriel                 47
--   555935 Alex            Manuel                  57
--   539569 George          Mardy                   27
--   733843 Mario           Saule                   63
--   631548 Alan            Snappy                  27
--   839139 Maria           Foster                  57

-- Queries
-- 1. From the customer and salesman tables, find the salesperson and customer who belongs to same city. Return Salesman, cust_name and city.
SELECT s.name, c.cust_name, c.city
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id

-- 2. From the customer and orders tables, find those orders where order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.
SELECT o.ord_no, o.purch_amt, c.cust_name, c.city
FROM customer AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
AND c.salesman_id = o.salesman_id
WHERE o.purch_amt BETWEEN 500 AND 2000

-- 3. From the customer and salesman tables, find the salesperson(s) and the customer(s) he handle. Return Customer Name, city, Salesman, commission.
SELECT c.cust_name, c.city, s.name, s.commission
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id

-- 4. From the customer and salesman tables, find those salespersons who received a commission from the company more than 12%. Return Customer Name, customer city, Salesman, commission.
SELECT c.cust_name, c.city, s.name, s.commission
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
WHERE s.commission > 0.12

-- 5. From the customer and salesman tables, find those salespersons do not live in the same city where their customers live and received a commission from the company more than 12%. Return Customer Name, customer city, Salesman, salesman city, commission.
SELECT c.cust_name, c.city, s.name, s.city, s.commission
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
WHERE c.city <> s.city
AND s.commission > 0.12

-- 6. From the customer, salesman and orders tables, find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission.
SELECT o.ord_no, o.ord_date, o.purch_amt, c.cust_name, c.grade, s.name, s.commission
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
JOIN orders AS o
ON c.customer_id = o.customer_id
AND c.salesman_id = o.salesman_id

-- 7. Make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come.
SELECT *
FROM customer
NATURAL JOIN salesman
NATURAL JOIN orders

-- 8. From the customer and salesman tables, display the cust_name, customer city, grade, Salesman, salesman city. The result should be ordered by ascending on customer_id.
SELECT c.cust_name, c.city, c.grade, s.name, s.city
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
ORDER BY c.customer_id ASC

-- 9. From the customer and salesman tables, find those customers whose grade less than 300. Return cust_name, customer city, grade, Salesman, saleman city. The result should be ordered by ascending customer_id.
SELECT c.cust_name, c.city, c.grade, s.name, s.city
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
WHERE c.grade < 300
ORDER BY c.customer_id ASC

-- 10. Make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to find that either any of the existing customers have placed no order or placed one or more orders.
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM customer AS c
LEFT OUTER JOIN orders AS o
ON c.customer_id = o.customer_id
AND c.salesman_id = o.salesman_id
ORDER BY o.ord_date ASC

-- 11. Make a report with customer name, city, order number, order date, order amount salesman name and commission to find that either any of the existing customers have placed no order or placed one or more orders by their salesman or by own.
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt, s.name, s.commission
FROM customer AS c
LEFT OUTER JOIN salesman AS s
ON c.salesman_id = s.salesman_id
LEFT OUTER JOIN orders AS o
ON c.customer_id = o.customer_id
AND c.salesman_id = o.salesman_id

-- 12. Make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers.
SELECT s.name, c.cust_name
FROM customer AS c
RIGHT OUTER JOIN salesman AS s
ON c.salesman_id = s.salesman_id
ORDER BY s.salesman_id

-- 13. From the customer, salesman and orders tables, list all salespersons along with customer name, city, grade, order number, date, and amount.
SELECT s.name, c.cust_name, c.city, c.grade, o.ord_no, o.ord_date, o.purch_amt
FROM customer AS c
RIGHT OUTER JOIN salesman AS s
ON c.salesman_id = s.salesman_id
JOIN orders AS o
ON c.customer_id = o.customer_id
AND c.salesman_id = o.salesman_id

-- 14. Make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
SELECT *
FROM customer AS c
RIGHT OUTER JOIN salesman AS s
ON c.salesman_id = s.salesman_id
LEFT OUTER JOIN orders AS o
ON c.customer_id = o.customer_id
AND c.salesman_id = o.salesman_id
WHERE o.purch_amt >= 2000
AND c.grade IS NOT NULL

-- 15. Make a report with customer name, city, order no. order date, purchase amount for those customers from the existing list who placed one or more orders or which order(s) have been placed by the customer who is not on the list.
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM customer AS c
FULL OUTER JOIN orders AS o
ON c.customer_id = o.customer_id
AND c.salesman_id = o.salesman_id

-- 16. Combine each row of salesman table with each row of customer table.
SELECT *
FROM customer AS c
CROSS JOIN salesman AS s

-- 17. Make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who must belong a city which is not the same as his customer and the customers should have an own grade.
SELECT *
FROM customer AS c
CROSS JOIN salesman AS s
WHERE s.city IS NOT NULL
AND s.city <> c.city
AND c.grade IS NOT NULL

-- 18. From the company master and item master tables, select all rows from both participating tables as long as there is a match between pro_com and com_id.
SELECT *
FROM company_mast AS c
JOIN item_mast AS i
ON c.com_id = i.pro_com

-- 19. Display the item name, price, and company name of all the products.
SELECT i.pro_name, i.pro_price, c.com_name
FROM company_mast AS c
JOIN item_mast AS i
ON c.com_id = i.pro_com

-- 20. From the company master and item master tables, calculate the average price of items of each company. Return average value and company name.
SELECT AVG(i.pro_price), c.com_name
FROM company_mast AS c
JOIN item_mast AS i
ON c.com_id = i.pro_com
GROUP BY c.com_name

-- 21. From the company master and item master tables, calculate and find the average price of items of each company higher than or equal to Rs. 350. Return average value and company name.
SELECT AVG(i.pro_price), c.com_name
FROM company_mast AS c
JOIN item_mast AS i
ON c.com_id = i.pro_com
GROUP BY c.com_name
HAVING AVG(i.pro_price) >= 350

-- 22. From the company master and item master tables, find the most expensive product of each company. Return pro_name, pro_price and com_name.
SELECT i.pro_name, MAX(i.pro_price), c.com_name
FROM company_mast AS c
JOIN item_mast AS i
ON c.com_id = i.pro_com
GROUP BY c.com_name, i.pro_name
ORDER BY MAX(i.pro_price) DESC

-- 23. From the employee department and employee details tables, display all the data of employees including their department.
SELECT *
FROM emp_department AS dpt
JOIN emp_details AS emp
ON dpt.dpt_code = emp.emp_dept

-- 24. From the employee department and employee details tables, display the first name and last name of each employee, along with the name and sanction amount for their department.
SELECT emp.emp_fname, emp.emp_lname, dpt.dpt_name, dpt.dpt_allotment
FROM emp_department AS dpt
JOIN emp_details AS emp
ON dpt.dpt_code = emp.emp_dept

-- 25. From the employee department and employee details tables, find the departments with a budget more than Rs. 50000 and display the first name and last name of employees.
SELECT emp.emp_fname, emp.emp_lname
FROM emp_department AS dpt
JOIN emp_details AS emp
ON dpt.dpt_code = emp.emp_dept
WHERE dpt.dpt_allotment > 50000

-- 26. From the employee department and employee details tables, find the names of departments where more than two employees are working. Return dpt_name.
SELECT dpt.dpt_name
FROM emp_department AS dpt
JOIN emp_details AS emp
ON dpt.dpt_code = emp.emp_dept
GROUP BY dpt.dpt_name
HAVING COUNT(emp.emp_idno) > 2
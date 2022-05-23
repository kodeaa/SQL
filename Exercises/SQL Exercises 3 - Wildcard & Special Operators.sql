-- SQL Exercises 3 - Wildcard & Special Operators
-- Medium post: https://medium.com/@aadata/sql-exercises-3-wildcard-special-operators-9984520327c0

-- Salesman Table
-- salesman_id |    name    |   city   | commission 
---------------+------------+----------+------------
--        5001 | James Hoog | New York |       0.15
--        5002 | Nail Knite | Paris    |       0.13
--        5005 | Pit Alex   | London   |       0.11
--        5006 | Mc Lyon    | Paris    |       0.14
--        5007 | Paul Adam  | Rome     |       0.13
--        5003 | Lauson Hen | San Jose |       0.12

-- 1. Find the details of those salespeople who come from the ‘Paris’ City or ‘Rome’ City. Return salesman_id, name, city, commission.
SELECT *
FROM salesman
WHERE city IN (‘Paris’, ‘Rome’)

-- 2. Find the details of those salespeople who live in cities apart from ‘Paris’ and ‘Rome’. Return salesman_id, name, city, commission.
SELECT *
FROM salesman
WHERE city NOT IN (‘Paris’, ‘Rome’)

-- 3. Find the details of salespeople who get the commission in the range from 0.12 to 0.14 (begin and end values are included). Return salesman_id, name, city, and commission.
SELECT *
FROM salesman
WHERE commission BETWEEN 0.12 AND 0.14

-- 4. Find the details of those salespeople whose name starts with any letter within ‘A’ and ‘L’. Return salesman_id, name, city, commission.
SELECT *
FROM salesman
WHERE LEFT(name, 1) BETWEEN ‘A’ AND ‘L’

-- 5. Find the details of all salespeople except whose name starts with any letter within ‘A’ and ‘L’. Return salesman_id, name, city, commission.
SELECT *
FROM salesman
WHERE LEFT(name, 1) NOT BETWEEN ‘A’ AND ‘L’

-- 6. Find the details of those salespeople whose name starts with ’N’ and the fourth character is ‘l’. Rests may be any character. Return salesman_id, name, city, commission.
SELECT *
FROM salesman
WHERE name LIKE (‘N__l%’)

-- Customer Table
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

-- 1. Find the details of the customers whose ID belongs to any of the values 3007, 3008 and 3009. Return customer_id, cust_name, city, grade, and salesman_id.
SELECT *
FROM customer
WHERE customer_id BETWEEN 3007 AND 3009

-- 2. Find the details of the customers whose name begins with the letter ‘B’. Return customer_id, cust_name, city, grade, salesman_id.
SELECT *
FROM customer
WHERE cust_name LIKE (‘B%’)

-- 3. Find the details of the customers whose names end with the letter ’n’. Return customer_id, cust_name, city, grade, salesman_id.
SELECT *
FROM customer
WHERE cust_name LIKE (‘%n’)

-- 4. Find all those customers who does not have any grade. Return customer_id, cust_name, city, grade, salesman_id.
SELECT *
FROM customer
WHERE grade IS NULL

-- 5. Find all those customers whose grade value exists. Return customer_id, cust_name, city, grade, salesman_id.
SELECT *
FROM customer
WHERE grade IS NOT NULL

-- Orders Table
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

-- 1. Select orders value within a range 500, 400 (begin and end values are included). Exclude orders amount 948.50 and 1983.43. Return ord_no, purch_amt, ord_date, customer_id, and salesman_id.
SELECT *
FROM orders
WHERE (purch_amt BETWEEN 500 AND 4000)
AND (purch_amt NOT IN (948.50, 1983.43))

-- Test Table
-- col1
-----------------------------
-- A001/DJ-402\44_/100/2015
-- A001_\DJ-402\44_/100/2015
-- A001_DJ-402-2014-2015
-- A002_DJ-401-2014-2015
-- A001/DJ_401
-- A001/DJ_402\44
-- A001/DJ_402\44\2015
-- A001/DJ-402%45\2015/200
-- A001/DJ_402\45\2015%100
-- A001/DJ_402%45\2015/300
-- A001/DJ-402\44

-- 1. Find those rows where col1 contains the escape character underscore ( _ ). Return col1.
SELECT *
FROM testtable
WHERE col1 LIKE (‘%/_%’) ESCAPE (‘/’)

-- 2. Find those rows where col1 does not contain the escape character underscore ( _ ). Return col1.
SELECT *
FROM testtable
WHERE col1 NOT LIKE (‘%/_%’) ESCAPE (‘/’)

-- 3. Find those rows where col1 contains the forward slash character ( / ). Return col1.
SELECT *
FROM testtable
WHERE col1 LIKE (‘%/%’)

-- 4. Find those rows where col1 does not contain the forward slash character ( / ). Return col1.
SELECT *
FROM testtable
WHERE col1 NOT LIKE (‘%/%’)

-- 5. Find those rows where col1 contains the string ( _/ ). Return col1.
SELECT *
FROM testtable
WHERE col1 LIKE (‘%#_/%’) ESCAPE (‘#’)

-- 6. Find those rows where col1 does not contain the string ( _/ ). Return col1.
SELECT *
FROM testtable
WHERE col1 NOT LIKE (‘%#_/%’) ESCAPE (‘#’)

-- 7. Find those rows where col1 contains the character percent ( % ). Return col1.
SELECT *
FROM testtable
WHERE col1 LIKE (‘%/%%’) ESCAPE (‘/’)

-- 8. Find those rows where col1 does not contain the character percent ( % ). Return col1.
SELECT *
FROM testtable
WHERE col1 NOT LIKE (‘%/%%’) ESCAPE (‘/’)

-- Employee Details Table
-- EMP_IDNO EMP_FNAME       EMP_LNAME         EMP_DEPT
------------ --------------- --------------- ----------
--    127323 Michale         Robbin                  57
--    526689 Carlos          Snares                  63
--    843795 Enric           Dosio                   57
--    328717 Jhon            Snares                  63
--    444527 Joseph          Dosni                   47
--    659831 Zanifer         Emily                   47
--    847674 Kuleswar        Sitaraman               57
--    748681 Henrey          Gabriel                 47
--    555935 Alex            Manuel                  57
--    539569 George          Mardy                   27
--    733843 Mario           Saule                   63
--    631548 Alan            Snappy                  27
--    839139 Maria           Foster                  57

-- 1. Find the employees whose last name begins with the character ‘D’. Return emp_idno, emp_fname, emp_lname and emp_dept.
SELECT *
FROM emp_details
WHERE emp_lname LIKE (‘D%’)
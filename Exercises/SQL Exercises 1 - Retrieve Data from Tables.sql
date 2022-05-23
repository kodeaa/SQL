-- SQL Exercises 1 - Retrieve Data from Tables
-- Medium post: https://medium.com/@aadata/sql-exercises-retrieve-data-from-tables-6102256dc43e

-- Basic Queries
-- 1. Display a string “This is aadata’s SQL Exercise”.
SELECT ‘This is aadata’’s SQL Exercise’ AS string

-- 2. Display three numbers in three columns.
SELECT 8 AS first, 7 AS second, 2 AS third

--  3. Display the sum of two numbers 10 and 15.
SELECT 10 + 15 AS result

-- 4. Display the result of an arithmetic expression.
SELECT (10 + 15) * 2 AS result

-- Salesman Table
-- salesman_id |    name    |   city   | commission 
---------------+------------+----------+------------
--        5001 | James Hoog | New York |       0.15
--        5002 | Nail Knite | Paris    |       0.13
--        5005 | Pit Alex   | London   |       0.11
--        5006 | Mc Lyon    | Paris    |       0.14
--        5007 | Paul Adam  | Rome     |       0.13
--        5003 | Lauson Hen | San Jose |       0.12

--1. Display all the information of all salesmen.
SELECT * FROM salesman

-- 2. Display specific columns like name and commission for all the salesmen
SELECT name, commission FROM salesman

-- 3. Find the salespeople who lives in the City of ‘Paris’. Return salesperson’s name, city.
SELECT name, city
FROM salesman
WHERE city = ‘Paris’

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

-- 1. Display the columns in a specific order like order date, salesman id, order number and purchase amount from for all the orders.
SELECT ord_date, salesman_id, ord_no, purch_amt FROM orders

-- 2. Find the unique salespeople ID. Return salesman_id.
SELECT DISTINCT(salesman_id) FROM orders

-- 3. Find the orders, which are delivered by a salesperson of ID. 5001. Return ord_no, ord_date, purch_amt.
SELECT ord_no, ord_date, purch_amt
FROM orders
WHERE salesman_id = 5001

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

-- 1. Find those customers whose grade is 200. Return customer_id, cust_name, city, grade, salesman_id.
SELECT *
FROM customer
WHERE grade = 200

-- Nobel Prize Winners Table
-- YEAR SUBJECT                   WINNER                                        COUNTRY                CATEGORY
------- ------------------------- --------------------------------------------- ------------------------- ------------
-- 1970 Physics                   Hannes Alfven                                 Sweden                 Scientist
-- 1970 Physics                   Louis Neel                                    France                 Scientist
-- 1970 Chemistry                 Luis Federico Leloir                          France                 Scientist
-- 1970 Physiology                Ulf von Euler                                 Sweden                 Scientist
-- 1970 Physiology                Bernard Katz                                  Germany                Scientist
-- 1970 Literature                Aleksandr Solzhenitsyn                        Russia                 Linguist
-- 1970 Economics                 Paul Samuelson                                USA                    Economist
-- 1970 Physiology                Julius Axelrod                                USA                    Scientist
-- 1971 Physics                   Dennis Gabor                                  Hungary                Scientist
-- 1971 Chemistry                 Gerhard Herzberg                              Germany                Scientist
-- 1971 Peace                     Willy Brandt                                  Germany                Chancellor
-- 1971 Literature                Pablo Neruda                                  Chile                  Linguist
-- 1971 Economics                 Simon Kuznets                                 Russia                 Economist
-- 1978 Peace                     Anwar al-Sadat                                Egypt                  President
-- 1978 Peace                     Menachem Begin                                Israel                 Prime Minister
-- 1987 Chemistry                 Donald J. Cram                                USA                    Scientist
-- 1987 Chemistry                 Jean-Marie Lehn                               France                 Scientist
-- 1987 Physiology                Susumu Tonegawa                               Japan                  Scientist
-- 1994 Economics                 Reinhard Selten                               Germany                Economist
-- 1994 Peace                     Yitzhak Rabin                                 Israel                 Prime Minister
-- 1987 Physics                   Johannes Georg Bednorz                        Germany                Scientist
-- 1987 Literature                Joseph Brodsky                                Russia                 Linguist
-- 1987 Economics                 Robert Solow                                  USA                    Economist
-- 1994 Literature                Kenzaburo Oe                                  Japan                  Linguist

-- 1. Find the Nobel Prize winner(s) in the year 1970. Return year, subject and winner.
SELECT year, subject, winner
FROM nobel_win
WHERE year = 1970

-- 2. Find the Nobel Prize winner in ‘Literature’ in the year 1971. Return winner.
SELECT winner
FROM nobel_win
WHERE subject = ‘Literature’
AND year = 1971

-- 3. Find the Nobel Prize winner ‘Dennis Gabor’. Return year, subject.
SELECT year, subject
FROM nobel_win
WHERE winner = ‘Dennis Gabor’

-- 4. Find the Nobel Prize winners in ‘Physics’ since the year 1950. Return winner.
SELECT winner
FROM nobel_win
WHERE subject = ‘Physics’
AND year >= 1950

-- 5. Find the Nobel Prize winners in ‘Chemistry’ between the years 1965 to 1975. Begin and end values are included. Return year, subject, winner, and country
SELECT year, subject, winner, country
FROM nobel_win
WHERE subject = ‘Chemistry’
AND year BETWEEN 1965 AND 1975

-- 6. Show all details of the Prime Ministerial winners after 1972 of Menachem Begin and Yitzhak Rabin.
SELECT *
FROM nobel_win
WHERE category = ‘Prime Minister’
AND year > 1972
AND winner IN (‘Menachem Begin’, ‘Yitzhak Rabin’)

-- 7. Find the details of the winners whose first name matches with the string ‘Louis’. Return year, subject, winner, country, and category.
SELECT *
FROM nobel_win
WHERE winner LIKE ‘Louis %’

-- 8. Combine the winners in Physics, 1970 and in Economics, 1971. Return year, subject, winner, country, and category.
SELECT *
FROM nobel_win
WHERE (subject = ‘Physics’ AND year = 1970)
OR (subject = ‘Economics’ AND year = 1971)

-- 9. Find the Nobel Prize winners in 1970 excluding the subjects Physiology and Economics. Return year, subject, winner, country, and category.
SELECT *
FROM nobel_win
WHERE year = 1970
AND subject NOT IN (‘Physiology’, ‘Economics’)

-- 10. Combine the winners in ‘Physiology’ before 1971 and winners in ‘Peace’ on or after 1974. Return year, subject, winner, country, and category.
SELECT *
FROM nobel_win
WHERE (subject = ‘Physiology’ AND year < 1971)
OR (subject = ‘Peace’ AND year >= 1974)

-- 11. Find the details of the Nobel Prize winner ‘Johannes Georg Bednorz’. Return year, subject, winner, country, and category.
SELECT *
FROM nobel_win
WHERE winner = ‘Johannes Georg Bednorz’

-- 12. Find the Nobel Prize winners for the subject not started with the letter ‘P’. Return year, subject, winner, country, and category. Order the result by year, descending.
SELECT *
FROM nobel_win
WHERE subject NOT LIKE ‘P%’
ORDER BY year DESC

-- 13. Find the details of 1970 Nobel Prize winners. Order the result by subject, ascending except ‘Chemistry’ and ‘Economics’ which will come at the end of result set. Return year, subject, winner, country, and category.
SELECT *
FROM nobel_win
WHERE year = 1970
ORDER BY
  CASE
    WHEN subject IN (‘Economics’, ‘Chemistry’) THEN 1
    ELSE 0
  END ASC,
subject

-- Item Master Table
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

-- 1. Select a range of products whose price is in the range Rs.200 to Rs.600. Begin and end values are included. Return pro_id, pro_name, pro_price, and pro_com.
SELECT *
FROM item_mast
WHERE pro_price BETWEEN 200 AND 600

-- 2. Calculate the average price for manufacturer code equal to 16. Return avg.
SELECT AVG(pro_price) AS avg
FROM item_mast
WHERE pro_com = 16

-- 3. Display the pro_name as ‘Item Name’ and pro_price as ‘Price in Rs.’
SELECT pro_name AS “Item Name”, pro_price AS “Price in Rs.”
FROM item_mast

-- 4. Find the items whose prices are higher than or equal to $250. Order the result by product price in descending, then product name in ascending. Return pro_name and pro_price.
SELECT pro_name, pro_price
FROM item_mast
WHERE pro_price >= 250
ORDER BY pro_price DESC, pro_name ASC

-- 5. Calculate average price of the items of each company. Return average price and company code.
SELECT AVG(pro_price), pro_com
FROM item_mast
GROUP BY pro_com

-- 6. Find the cheapest item(s). Return pro_name and, pro_price.
SELECT pro_name, pro_price
FROM item_mast
WHERE pro_price =
  (SELECT MIN(pro_price) FROM item_mast)

-- Employee Details Table
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

-- 1. Find unique last name of all employees. Return emp_lname.
SELECT DISTINCT(emp_lname)
FROM emp_details

-- 2. Find the details of employees whose last name is ‘Snares’. Return emp_idno, emp_fname, emp_lname, and emp_dept.
SELECT *
FROM emp_details
WHERE emp_lname = ‘Snares’

-- 3. Find the details of the employees who work in the department 57. Return emp_idno, emp_fname, emp_lname and emp_dept.
SELECT *
FROM emp_details
WHERE emp_dept = 57
-- SQL Project - Working on Employee Database
-- Medium post: https://medium.com/@aadata/sql-project-working-on-employee-database-6c12c5eaa65

-- Employee Database
-- https://miro.medium.com/max/1004/1*gorSjYS7Egq2ttZymsurdQ.png

-- Queries
-- 1. From the employees table return complete information about the employees.
SELECT *
FROM employees

-- 2. From the employees table, find the salaries of all employees. Return salary.
SELECT salary
FROM employees

-- 3. From the employees table, find the unique designations of the employees. Return job name.
SELECT DISTINCT job_name
FROM employees

-- 4. From the employees table, list the employees’ name, increased their salary by 15%, and expressed as number of Dollars.
SELECT emp_name, to_char(salary * 115 / 100, ‘$99,999’) AS “Salary”
FROM employees

-- 5. Produce the output of employees as follows.
-- Employee
-- JONAS(manager).
SELECT CONCAT(emp_name, ‘(‘, LOWER(job_name), ‘)’) AS “Employee”
FROM employees

-- 6. From the employees table, find those employees with hire date in the format like February 22, 1991. Return employee ID, employee name, salary, hire date.
SELECT emp_id, emp_name, salary, to_char(hire_date, ‘MONTH DD, YYYY’) AS “hire_date”
FROM employees

-- 7. From the employees table, count the number of characters except the spaces for each employee name. Return employee name length.
SELECT LENGTH(TRIM(emp_name))
FROM employees

-- 8. From the employees table, find the employee ID, salary, and commission of all the employees.
SELECT emp_id, salary, commission
FROM employees

-- 9. From the employees table, find the unique department with jobs. Return department ID, Job name.
SELECT DISTINCT dep_id, job_name
FROM employees
ORDER BY dep_id, job_name

-- 10. From the employees table, find those employees who do not belong to the department 2001. Return complete information about the employees.
SELECT *
FROM employees
WHERE dep_id <> 2001

-- 11. From the employees table, find those employees who joined before 1991. Return complete information about the employees.
SELECT *
FROM employees
WHERE hire_date < ‘1991–01–01’

-- 12. From the employees table, compute the average salary of those employees who work as ‘ANALYST’. Return average salary.
SELECT AVG(salary)
FROM employees
WHERE job_name = ‘ANALYST’

-- 13. From the employees table, find the details of the employee ‘BLAZE’.
SELECT *
FROM employees
WHERE emp_name = ‘BLAZE’

-- 14. From the employees table, find those employees whose commission is more than their salary. Return complete information about the employees.
SELECT *
FROM employees
WHERE commission > salary

-- 15. From the employees table, find those employees whose salary exceeds 3000 after giving 25% increment. Return complete information about the employees.
SELECT *
FROM employees
WHERE (salary * 1.25) > 3000

-- 16. From the employees table, find the names of the employees whose length is six. Return employee name.
SELECT emp_name
FROM employees
WHERE LENGTH(emp_name) = 6

-- 17. From the employees table, find those employees who joined in the month January. Return complete information about the employees.
SELECT *
FROM employees
WHERE TO_CHAR(hire_date, ‘MM’) = ‘01’

-- 18. From the employees table, find the name of employees and their manager separated by the string ‘WORKS FOR’.
SELECT CONCAT(t1.emp_name, ‘ WORKS FOR ‘, t2.emp_name)
FROM employees AS t1
JOIN employees AS t2
ON t1.manager_id = t2.emp_id

-- 19. From the employees table, find those employees whose designation is ‘CLERK’. Return complete information about the employees.
SELECT *
FROM employees
WHERE job_name = ‘CLERK’

-- 20. From the employees table, find those employees whose experience is more than 27 years. Return complete information about the employees.
SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) > 27

-- 21. From the employees table, find those employees whose salaries are less than 3500. Return complete information about the employees.
SELECT *
FROM employees
WHERE salary < 3500

-- 22. From the employees table, find the employee whose designation is ‘ANALYST’. Return employee name, job name and salary.
SELECT emp_name, job_name, salary
FROM employees
WHERE job_name = ‘ANALYST’

-- 23. From the employees table, find those employees who have joined in the year 1991.Return complete information about the employees.
SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1991

-- 24. From the employees table, find those employees who joined before 1st April 1991. Return employee ID, employee name, hire date and salary.
SELECT emp_id, emp_name, hire_date, salary
FROM employees
WHERE hire_date < ‘1991–04–01’

-- 25. From the employees table, find those employees who are not working under a manager. Return employee name, job name.
SELECT emp_name, job_name
FROM employees
WHERE manager_id IS NULL

-- 26. From the employees table, find those employees who joined on 1st May 91. Return complete information about the employees.
SELECT *
FROM employees
WHERE hire_date = ‘1991–05–01’

-- 27. From the employees table, find those employees working under the manger whose ID is 68319. Return employee ID, employee name, salary, and job age as “Experiences”.
SELECT emp_id, emp_name, salary, age(CURRENT_DATE, hire_date) AS “Experience”
FROM employees
WHERE manager_id = 68319

-- 28. From the employees table, find those employees who earn more than 100 as daily salary. Return employee ID, employee name, salary, and job age.
SELECT emp_id, emp_name, salary, age(CURRENT_DATE, hire_date) AS “Experience”
FROM employees
WHERE (salary / 30) > 100

-- 29. From the employees table, find those employees who retired after 31-Dec-99, completion of 8 years of service period. Return employee name.
SELECT emp_name
FROM employees
WHERE hire_date + interval ’96 months’ > ‘1999–12–31’

-- 30. From the employees table, find those employees whose salary is an odd value. Return complete information about the employees.
SELECT *
FROM employees
WHERE salary % 2 <> 0

-- 31. From the employees table, find those employees whose salary contains only three digits. Return complete information about the employees.
SELECT *
FROM employees
WHERE LENGTH(TRIM(TO_CHAR(salary, ‘9999’))) = 3

-- 32. From the employees table, find those employees who joined in the month of APRIL. Return complete information about the employees.
SELECT *
FROM employees
WHERE EXTRACT(MONTH FROM hire_date) = ‘04’

-- 33. From the employees table, find those employees who joined in the company before 19th of a month. Return complete information about the employees.
SELECT *
FROM employees
WHERE EXTRACT(DAY FROM hire_date) < ‘19’

-- 34. From the employees table, find those employees who are SALESMAN and experience more than 10 years. Return complete information about the employees.
SELECT *
FROM employees
WHERE job_name = ‘SALESMAN’
AND age(CURRENT_DATE, hire_date) > ’10 years’

-- 35. From the employees table, find those employees of department id 3001 or 1001 and joined in the year 1991. Return complete information about the employees.
SELECT *
FROM employees
WHERE dep_id IN (3001, 1001)
AND EXTRACT(YEAR FROM hire_date) = ‘1991’

-- 36. From the employees table, find those employees who are working for the department ID 1001 or 2001.Return complete information about the employees.
SELECT *
FROM employees
WHERE dep_id IN (1001, 2001)

-- 37. From the employees table, find those employees whose designation is ‘CLERK’ and work in the department ID 2001. Return complete information about the employees.
SELECT *
FROM employees
WHERE job_name = ‘CLERK’
AND dep_id = 2001

-- 38. From the employees table, find those employees where:
-- a. the employees receive some commission which should not be more than the salary and annual salary including commission is below 34000.
-- b. Designation is ‘SALESMAN’ and working in the department ‘3001’. Return employee ID, employee name, salary and job name.
SELECT emp_id, emp_name, salary, job_name
FROM employees
WHERE commission <= salary
AND (salary * 12) + commission < 34000
AND job_name = ‘SALESMAN’
AND dep_id = 3001

-- 39. From the employees table, find those employees who are either CLERK or MANAGER. Return complete information about the employees.
SELECT *
FROM employees
WHERE job_name IN (‘CLERK’, ‘MANAGER’)

-- 40. From the employees table, find those employees who joined in any year except the month of February. Return complete information about the employees.
SELECT *
FROM employees
WHERE EXTRACT(MONTH FROM hire_date) <> 02

-- 41. From the employees table, find those employees who joined in the year 91. Return complete information about the employees.
SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1991

-- 42. From the employees table, find those employees who joined in the month of June 1991. Return complete information about the employees.
SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1991
AND EXTRACT(MONTH FROM hire_date) = 06

-- 43. From the employees table, find all the employees whose annual salary is within the range 24000 and 50000 (Begin and end values are included.). Return complete information about the employees.
SELECT *
FROM employees
WHERE salary * 12 BETWEEN 24000 AND 50000

-- 44. From the employees table, find all those employees who have joined on 1st May, 20th Feb, and 3rd Dec in the year 1991. Return complete information about the employees.
SELECT *
FROM employees
WHERE TO_CHAR(hire_date, ‘DD-MM-YY’) IN (‘01–05–91’, ‘20–02–91’, ‘03–12–91’)

-- 45. From the employees table, find those employees working under the managers 63679 or 68319 or 66564 or 69000. Return complete information about the employees.
SELECT *
FROM employees
WHERE manager_id IN (63679, 68319, 66564, 69000)

-- 46. From the employees table, find those employees who joined in 90’s. Return complete information about the employees.
SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) BETWEEN 1990 AND 1999

-- 47. From the employees table, find those managers who are in the department 1001 or 2001. Return complete information about the employees.
SELECT *
FROM employees
WHERE job_name = ‘MANAGER’
AND dep_id IN (1001, 2001)

-- 48. From the employees table, find those employees who joined in the month FEBRUARY with a salary range between 1001 to 2000 (Begin and end values are included.). Return complete information about the employees.
SELECT *
FROM employees
WHERE EXTRACT(MONTH FROM hire_date) = 02
AND salary BETWEEN 1001 AND 2000

-- 49. From the employees table, find those employees who joined before or after the year 1991. Return complete information about the employees.
SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) <> 1991

-- 50. From the employees and department tables, find employees along with department name. Return employee ID, employee name, job name, manager ID, hire date, salary, commission, department ID, and department name.
SELECT e.emp_id, e.emp_name, e.job_name, e.manager_id, e.hire_date, e.salary, e.commission, e.dep_id, d.dep_name
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id

-- 51. From the employees, department, and salary_grade tables, find those employees who earn 60000 in a year or not working as an ANALYST. Return employee name, job name, (12*salary) as Annual Salary, department ID, and grade.
SELECT e.emp_name, e.job_name, salary * 12 AS “Annual Salary”, e.dep_id, d.dep_name, sg.grade
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id
JOIN salary_grade AS sg
ON e.salary BETWEEN sg.min_sal AND sg.max_sal 
WHERE salary * 12 = 60000
OR job_name <> ‘ANALYST’

-- 52. From the employees table, find those employees whose salary is higher than the salary of their managers. Return employee name, job name, salary, manager ID, manager name, manager’s salary.
SELECT e1.emp_name, e1.job_name, e1.salary, e1.manager_id, e2.emp_name AS “manager”, e2.salary AS “manager_salary”
FROM employees AS e1
JOIN employees AS e2
ON e1.manager_id = e2.emp_id
WHERE e1.salary > e2.salary

-- 53. From the employees and department tables, find those employees whose salary is between 2000 and 5000 (Begin and end values are included.) and location is PERTH. Return employee name, department ID, salary, and commission.
SELECT e.emp_name, e.dep_id, e.salary, e.commission
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id
WHERE e.salary BETWEEN 2000 AND 5000
AND d.dep_location = ‘PERTH’

-- 54. From the employees and salary_grade tables, find those employees whose department ID is 1001 or 3001 and salary grade is not 4. They joined the company before 1992–12–31. Return grade, employee name.
SELECT sg.grade, emp_name
FROM employees AS e
JOIN salary_grade AS sg
ON e.salary BETWEEN sg.min_sal AND sg.max_sal
WHERE e.dep_id IN (1001, 3001)
AND sg.grade <> 4
AND hire_date < ‘1992–12–31’

-- 55. From the employees table, find those employees whose manager name is JONAS. Return employee id, employee name, job name, manager ID, hire date, salary, department ID, employee name.
SELECT e1.emp_id, e1.emp_name, e1.job_name, e1.hire_date, e1.salary, e1.dep_id, e1.manager_id, e2.emp_name AS “manager_name”
FROM employees AS e1
JOIN employees AS e2
ON e1.manager_id = e2.emp_id
WHERE e2.emp_name = ‘JONAS’

-- 56. From the employees and salary_grade tables, find the name and salary of the employee FRANK. Salary should be equal to the maximum salary within his or her salary group.
SELECT e.emp_name, e.salary
FROM employees AS e
JOIN salary_grade AS sg
ON e.salary BETWEEN sg.min_sal AND sg.max_sal
WHERE e.emp_name = ‘FRANK’
AND e.salary = sg.max_sal

-- 57. From the employees table, find those employees who are working either as a MANAGER or an ANALYST with a salary in the range 2000, 5000 (Begin and end values are included.) without any commission. Return complete information about the employees.
SELECT *
FROM employees
WHERE job_name IN (‘MANAGER’, ‘ANALYST’)
AND salary BETWEEN 2000 AND 5000
AND commission IS NULL

-- 58. From the employees and department tables, find those employees working at PERTH, or MELBOURNE with an experience over 10 years. Return employee ID, employee name, department ID, salary, and department location.
SELECT e.emp_id, e.emp_name, e.salary, e.dep_id, d.dep_location
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id
WHERE d.dep_location IN (‘PERTH’, ‘MELBOURNE’)
AND EXTRACT(YEAR FROM age(CURRENT_DATE, e.hire_date)) >= 10

-- 59. From the employees and department tables, find those employees whose department location is SYDNEY or MELBOURNE with a salary range of 2000, 5000 (Begin and end values are included.) and joined in 1991. Return employee ID, employee name, department ID, salary, and department location.
SELECT e.emp_id, e.emp_name, e.salary, e.dep_id, d.dep_location
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id
WHERE d.dep_location IN (‘SYDNEY’, ‘MELBOURNE’)
AND e.salary BETWEEN 2000 AND 5000
AND EXTRACT(YEAR FROM e.hire_date) = 1991

-- 60. From the employees, department, and salary_grade tables, find those employees of MARKETING department come from MELBOURNE or PERTH within the grade 3 ,4, and 5 and experience over 25 years. Return employee ID, employee name, salary, grade, department ID, department name, and department location.
SELECT e.emp_id, e.emp_name, e.salary, sg.grade, e.dep_id, d.dep_name, d.dep_location
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id
JOIN salary_grade AS sg
ON e.salary BETWEEN sg.min_sal AND sg.max_sal
WHERE d.dep_name = ‘MARKETING’
AND d.dep_location IN (‘MELBOURNE’, ‘PERTH’)
AND sg.grade IN (3, 4, 5)
AND EXTRACT(YEAR FROM age(CURRENT_DATE, hire_date)) >= 25

-- 61. From the employees table, list employees in ascending order on department ID and descending order on jobs. Return complete information about the employees.
SELECT *
FROM employees
ORDER BY dep_id ASC, job_name DESC

-- 62. From the employees table, find the entire unique jobs in descending order. Return job name.
SELECT DISTINCT(job_name)
FROM employees
ORDER BY job_name DESC

-- 63. From the employees table, find the employees in the ascending order of their annual salary. Return employee ID, employee name, monthly salary, salary/30 as Daily_Salary, and 12*salary as Anual_Salary.
SELECT emp_id, emp_name, salary AS “Monthly_Salary”, salary / 30 AS “Daily_Salary”, 12 * salary AS “Annual_Salary”
FROM employees
ORDER BY 12 * salary ASC

-- 64. From the employees table, find those employees who are either ‘CLERK’ or ‘ANALYST’. Sort the result set in descending order on job_name. Return complete information about the employees.
SELECT *
FROM employees
WHERE job_name IN (‘CLERK’, ‘ANALYST’)
ORDER BY job_name DESC

-- 65. From the department and employees tables, find the department location of employee ‘CLARE’. Return department location.
SELECT d.dep_location
FROM department AS d
JOIN employees AS e
ON d.dep_id = e.dep_id
WHERE e.emp_name = ‘CLARE’

-- 66. From the employees table, find those employees who joined on 01-MAY-91, or 03-DEC-91, or 19-JAN-90. Sort the result-set in ascending order by hire date. Return complete information about the employees.
SELECT *
FROM employees
WHERE TO_CHAR(hire_date, ‘DD-MON-YY’) IN (‘01-MAY-91’, ‘03-DEC-91’, ‘19-JAN-90’)
ORDER BY hire_date ASC

-- 67. From the employees table, find those employees who draw salary less than 1000. Sort the result-set in ascending order by salary. Return complete information about the employees.
SELECT *
FROM employees
WHERE salary < 1000
ORDER BY salary ASC

-- 68. From the employees table, list the employees in the ascending order on job name and descending order on employee id. Return complete information about the employees.
SELECT *
FROM employees
ORDER BY job_name ASC, emp_id DESC

-- 69. From the employees table, list the unique jobs of department 2001 and 3001 in descending order. Return job name.
SELECT DISTINCT(job_name)
FROM employees
WHERE dep_id IN (2001, 3001)
ORDER BY job_name DESC

-- 70. From the employees table, list all the employees except PRESIDENT and MANAGER in ascending order of salaries. Return complete information about the employees.
SELECT *
FROM employees
WHERE job_name NOT IN (‘PRESIDENT’, ‘MANAGER’)
ORDER BY salary ASC

-- 71. From the employees table, find the employees whose annual salary is below 25000. Sort the result set in ascending order of the salary. Return complete information about the employees.
SELECT *
FROM employees
WHERE (salary * 12) < 25000
ORDER BY salary ASC

-- 72. From the employees table, list the employees who works as a SALESMAN. Sort the result set in ascending order of annual salary. Return employee id, name, annual salary, daily salary of all the employees.
SELECT emp_id, emp_name, salary * 12 AS “Annual Salary”, salary / 30 AS “Daily Salary”
FROM employees
WHERE job_name = ‘SALESMAN’
ORDER BY salary * 12 ASC

-- 73. From the employees table, list the employee ID, name, hire date, current date and experience of the employees in ascending order on their experiences.
SELECT emp_id, emp_name, hire_date, CURRENT_DATE, AGE(CURRENT_DATE, hire_date) AS “experience”
FROM employees
ORDER BY AGE(CURRENT_DATE, hire_date) ASC

-- 74. From the employees and department tables, find the location of all the employees working in FINANCE or AUDIT department. Sort the result-set in ascending order by department ID. Return complete information about the employees.
SELECT *
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id
WHERE d.dep_name IN (‘FINANCE’, ‘AUDIT’)
ORDER BY e.dep_id ASC

-- 75. From the employees and salary_grade tables, find the employees along with grades in ascending order. Return complete information about the employees.
SELECT *
FROM employees AS e
JOIN salary_grade AS sg
ON e.salary BETWEEN sg.min_sal AND sg.max_sal
ORDER BY sg.grade ASC

-- 76. From the employees, department, and salary_grade tables, find the employees according to the department in ascending order. Return name, job name, department, salary, and grade.
SELECT e.emp_name, e.job_name, d.dep_name, e.salary, sg.grade
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id
JOIN salary_grade AS sg
ON e.salary BETWEEN sg.min_sal AND sg.max_sal
ORDER BY e.dep_id ASC

-- 77. From the employees, department, and salary_grade tables, find all employees except CLERK and sort the result-set in descending order by salary. Return employee name, job name, salary, grade and department name.
SELECT e.emp_name, e.job_name, d.dep_name, e.salary, sg.grade
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id
JOIN salary_grade AS sg
ON e.salary BETWEEN sg.min_sal AND sg.max_sal
WHERE e.job_name <> ‘CLERK’
ORDER BY e.salary DESC

-- 78. From the employees, department, and salary_grade tables, find those employees work in the department 1001 or 2001. Return employee ID, name, salary, department, grade, experience, and annual salary.
SELECT e.emp_id, e.emp_name, e.salary, d.dep_name, sg.grade, AGE(CURRENT_DATE, e.hire_date) AS “experience”, e.salary * 12 AS “annual_salary”
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id
JOIN salary_grade AS sg
ON e.salary BETWEEN sg.min_sal AND sg.max_sal
WHERE e.dep_id IN (1001, 2001)

-- 79. From the employees table, find the highest salary. Return highest salary.
SELECT MAX(salary)
FROM employees

-- 80. From the employees table, find the average salary and average total remuneration (salary and commission) for each type of job. Return name, average salary and average total remuneration.
SELECT job_name, AVG(salary) AS “average_salary”, AVG(salary + commission) AS “average_remuneration_salary”
FROM employees
GROUP BY job_name

-- 81. From the employees table, compute the total annual salary distributed against each job in the year 1991. Return job name, total annual salary.
SELECT job_name, SUM(salary * 12)
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1991
GROUP BY job_name

-- 82. From the employees and department tables, list the employee id, name, department id, location of all the employees.
SELECT e.emp_id, e.emp_name, e.dep_id, d.dep_location
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id

-- 83. From the employees and department tables, find those employees who work in the department ID 1001 or 2001. Return employee ID, employee name, department ID, department location, and department name.
SELECT e.emp_id, e.emp_name, e.dep_id, d.dep_location, d.dep_name
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id
WHERE e.dep_id IN (1001, 2001)

-- 84. From the employees table, count the number of employees of each designation in each department. Return department id, job name and number of employees.
SELECT dep_id, job_name, COUNT(emp_id)
FROM employees
GROUP BY dep_id,job_name

-- 85. From the employees and salary_grade tables, list the grade, number of employees, and maximum salary of each grade.
SELECT sg.grade, COUNT(e.emp_id), MAX(e.salary)
FROM employees AS e
JOIN salary_grade AS sg
ON e.salary BETWEEN sg.min_sal AND sg.max_sal
GROUP BY sg.grade
ORDER BY sg.grade

-- 86. From the employees, salary_grade, and department tables, find those departments where at least two employees work as a SALESMAN in each grade. Return department name, grade and number of employees.
SELECT d.dep_name, sg.grade, COUNT(e.emp_id)
FROM employees AS e
JOIN salary_grade AS sg
ON e.salary BETWEEN sg.min_sal AND sg.max_sal
JOIN department AS d
ON e.dep_id = d.dep_id
WHERE e.job_name = ‘SALESMAN’
GROUP BY d.dep_name, sg.grade
HAVING COUNT(e.emp_id) >= 2

-- 87. From the employees and department tables, find those departments where less than four employees work. Return department ID, number of employees.
SELECT d.dep_id, COUNT(e.emp_id)
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id
GROUP BY d.dep_id
HAVING COUNT(e.emp_id) < 4

-- 88. From the employees and department tables, find those departments where at least two employees work. Return department name, number of employees.
SELECT d.dep_name, COUNT(e.emp_id)
FROM employees AS e
JOIN department AS d
ON e.dep_id = d.dep_id
GROUP BY d.dep_name
HAVING COUNT(e.emp_id) >= 2

-- 89. From the employees table, check whether the employees ID are unique or not. Return employee id, number of employees.
SELECT emp_id, COUNT(emp_id)
FROM employees
GROUP BY emp_id
ORDER BY COUNT(emp_id) DESC

-- 90. From the employees table, find number of employees and average salary. Group the result set on department id and job name. Return number of employees, average salary, department ID, and job name.
SELECT COUNT(emp_id), AVG(salary), dep_id, job_name
FROM employees
GROUP BY dep_id, job_name

-- 91. From the employees table, find those employees whose name start with ‘A’ and six characters in length. Return employee name.
SELECT emp_name
FROM employees
WHERE emp_name LIKE ‘A%’
AND LENGTH(emp_name) = 6

-- 92. From the employees table, find those employees whose name is six characters in length and the third character must be ‘R’. Return complete information about the employees.
SELECT *
FROM employees
WHERE emp_name LIKE ‘__R%’
AND LENGTH(emp_name) = 6

-- 93. From the employees table, find those employees whose name is six characters in length, starting with ‘A’ and ending with ’N’. Return number of employees.
SELECT *
FROM employees
WHERE emp_name LIKE ‘A%N’
AND LENGTH(emp_name) = 6

-- 94. From the employees table, find those employees who joined in the month of where the second letter is ‘A’. Return number of employees.
SELECT *
FROM employees
WHERE TO_CHAR(hire_date, ‘MONTH’) LIKE ‘_A%’

-- 95. From the employees table, find those employees whose names contain the character set ‘AR’ together. Return complete information about the employees.
SELECT *
FROM employees
WHERE emp_name LIKE ‘%AR%’

-- 96. From the employees table, find those employees whose ID not start with the digit 68. Return employee ID.
SELECT emp_id
FROM employees
WHERE CAST(emp_id AS VARCHAR) NOT LIKE ‘68%’

-- 97. From the employees table, find those employees whose names contain the letter ‘A’. Return complete information about the employees.
SELECT *
FROM employees
WHERE emp_name LIKE ‘%A%’

-- 98. From the employees table, find those employees whose name ends with ‘S’ and six characters long. Return complete information about the employees.
SELECT *
FROM employees
WHERE emp_name LIKE ‘%S’
AND LENGTH(emp_name) = 6

-- 99. From the employees table, find those employees who joined in any month, but the month name contain the character ‘A’. Return complete information about the employees.
SELECT *
FROM employees
WHERE TO_CHAR(hire_date, ‘MONTH’) LIKE ‘%A%’

-- 100. From the employees table, find those employees who joined in any month, but the name of the month contain the character ‘A’ in second position. Return complete information about the employees.
SELECT *
FROM employees
WHERE TO_CHAR(hire_date, ‘MONTH’) LIKE ‘_A%’
-- SQL Project - Working on HR Database
-- Medium post: https://medium.com/@aadata/sql-project-working-on-hr-database-155cf3f42757

-- HR Database
-- https://miro.medium.com/max/1400/1*EdoSIf2_FIIEykVjlpO30Q.jpeg

-- Queries
-- 1. From the employees table, find those employees whose salary is less than 6000. Return full name (first and last name), and salary.
SELECT CONCAT(first_name, ‘ ‘, last_name) AS full_name, salary
FROM employees
WHERE salary < 6000

-- 2. From the employees table, find those employees whose salary is higher than 8000. Return first name, last name and department number and salary.
SELECT first_name, last_name, department_id, salary
FROM employees
WHERE salary > 8000

-- 3. From the employees table, find those employees whose last name is “McEwen”. Return first name, last name and department ID.
SELECT first_name, last_name, department_id
FROM employees
WHERE last_name = ‘McEwen’

-- 4. From the departments table, find the details of ‘Marketing’ department. Return all fields.
SELECT *
FROM departments
WHERE department_name = ‘Marketing’

-- 5. From the employees table, find those employees whose first name does not contain the letter ‘M’. Sort the result-set in ascending order by department ID. Return full name (first and last name together), hire_date, salary and department_id.
SELECT CONCAT(first_name, ‘ ‘, last_name) AS full_name, hire_date, salary, department_id
FROM employees
WHERE first_name NOT LIKE ‘%M%’
ORDER BY department_id ASC

-- 6. From the employees table, find those employees who falls in the following criteria : 1. whose salary is in the range of 8000, 12000 (Begin and end values are included.) and get some commission. 2. : those employees who joined before ‘2003–06–05’ and not included in the department number 40, 120 and 70. Return all fields.
SELECT *
FROM employees
WHERE salary BETWEEN 8000 AND 12000
AND commission_pct <> 0
OR hire_date < ‘2003–06–05’
AND department_id NOT IN (40, 120, 70)

-- 7. From the employees table, find those employees who do not earn any commission. Return full name (first and last name), and salary.
SELECT CONCAT(first_name, ‘ ‘, last_name), salary
FROM employees
WHERE commission_pct = 0

-- 8. From the employees table, find those employees whose salary is in the range 9000,17000 (Begin and end values are included). Return full name, contact details and salary.
SELECT CONCAT(first_name, ‘ ‘, last_name) AS full_name, email, phone_number, salary
FROM employees
WHERE salary BETWEEN 9000 AND 17000

-- 9. From the employees table, find those employees whose first name ends with the letter ‘m’. Return the first and last name, and salary.
SELECT first_name, last_name, salary
FROM employees
WHERE first_name LIKE ‘%m’

-- 10. From the employees table, find those employees whose salary is not in the range 7000 and 15000 (Begin and end values are included). Sort the result-set in ascending order by the full name (first and last). Return full name and salary.
SELECT CONCAT(first_name, ‘ ‘, last_name) AS full_name, salary
FROM employees
WHERE salary NOT BETWEEN 7000 AND 15000
ORDER BY first_name ASC, last_name ASC

-- 11. From the employees table, find those employees who were hired during November 5th, 2007 and July 5th, 2009. Return full name (first and last), job id and hire date.
SELECT CONCAT(first_name, ‘ ‘, last_name) AS full_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN ‘2007–11–05’ AND ‘2009–07–05’

-- 12. From the employees table, find those employees who works either in department 70 or 90. Return full name (first and last name), department id.
SELECT CONCAT(first_name, ‘ ‘, last_name) AS full_name, department_id
FROM employees
WHERE department_id IN (70, 90)

-- 13. From the employees table, find those employees who work under a manager. Return full name (first and last name), salary, and manager ID.
SELECT CONCAT(first_name, ‘ ‘, last_name) AS full_name, salary, manager_id
FROM employees
WHERE manager_id <> 0

-- 14. From the employees table, find those employees who were hired before June 21st, 2002. Return all fields.
SELECT *
FROM employees
WHERE hire_date < ‘2002–06–21’

-- 15. From the employees table, find those employees whose managers hold the ID 120 or 103 or 145. Return first name, last name, email, salary and manager ID.
SELECT first_name, last_name, email, salary, manager_id
FROM employees
WHERE manager_id IN (120, 103, 145)

-- 16. From the employees table, find those employees whose first name contains the letters D, S, or N. Return all fields.
SELECT *
FROM employees
WHERE first_name LIKE ‘%D%’
OR first_name LIKE ‘%S%’
OR first_name LIKE ‘%N%’

-- 17. From the employees table, find those employees whose first name contains a character ‘s’ in 3rd position. Return first name, last name and department id.
SELECT first_name, last_name, department_id
FROM employees
WHERE first_name LIKE ‘__s%’

-- 18. From the employees table, find those employees who are working in the departments, which are not included in the department number 50 or 30 or 80. Return employee_id, first_name, job_id, department_id.
SELECT employee_id, first_name, job_id, department_id
FROM employees
WHERE department_id NOT IN (50, 30, 80)

-- 19. From the employees table, find those employees whose department numbers are included in 30 or 40 or 90. Return employee id, first name, job id, department id.
SELECT employee_id, first_name, job_id, department_id
FROM employees
WHERE department_id IN (30, 40, 90)

-- 20. From the job history table, find those employees who worked more than two jobs in the past. Return employee id.
SELECT employee_id
FROM job_history
GROUP BY employee_id
HAVING COUNT(employee_id) > 1
ORDER BY employee_id

-- 21. From the employees table, count the number of employees, sum of all salary, and difference between the highest salary and lowest salary by each job id. Return job_id, count, sum, salary_difference.
SELECT job_id, COUNT(DISTINCT(employee_id)), SUM(salary), MAX(salary) — MIN(salary) AS salary_difference
FROM employees
GROUP BY job_id

-- 22. From the job history table, find each job ids where two or more employees worked for more than 300 days. Return job id.
SELECT job_id
FROM job_history
WHERE end_date — start_date > 300
GROUP BY job_id
HAVING COUNT(job_id) > 1
ORDER job_id

-- 23. From the locations table, count the number of cities in each country has. Return country ID and number of cities.
SELECT country_id, COUNT(city)
FROM locations
GROUP BY country_id
ORDER BY country_id

-- 24. From the employees table, count the number of employees worked under each manager. Return manager ID and number of employees.
SELECT manager_id, COUNT(employee_id)
FROM employees
GROUP BY manager_id
HAVING manager_id <> 0
ORDER BY COUNT(employee_id) DESC

-- 25. From the jobs table, find all jobs. Sort the result-set in descending order by job title. Return all fields.
SELECT *
FROM jobs
ORDER BY job_title DESC

-- 26. From the employees table, find all those employees who are either Sales Representative or Salesman. Return first name, last name and hire date.
SELECT first_name, last_name, hire_date
FROM employees
WHERE job_id IN (‘SA_REP’, ‘SA_MAN’)

-- 27. From the employees table, calculate average salary of those employees for each department who get a commission percentage. Return department id, average salary.
SELECT department_id, AVG(salary)
FROM employees
WHERE commission_pct > 0
GROUP BY department_id

-- 28. From the employees table, find those departments where a manager can manage four or more employees. Return department_id.
SELECT DISTINCT(department_id)
FROM employees
GROUP BY manager_id, department_id
HAVING COUNT(employee_id) > 3
ORDER BY department_id

-- 29. From the employees table, find those departments where more than ten employees work, who got a commission percentage. Return department id.
SELECT department_id
FROM employees
WHERE commission_pct > 0
GROUP BY department_id
HAVING COUNT(DISTINCT(employee_id)) > 10

-- 30. From the job history table, find those employees who have completed their previous jobs. Return employee ID, end_date.
SELECT employee_id, MAX(end_date)
FROM job_history
GROUP BY employee_id
HAVING COUNT(employee_id) > 1

-- 31. From the employees table, find those employees who have no commission percentage and salary within the range 7000, 12000 (Begin and end values are included.) and works in the department number 50. Return all the fields of employees.
SELECT *
FROM employees
WHERE commission_pct = 0
AND salary BETWEEN 7000 AND 12000
AND department_id = 50

-- 32. From the employees table, compute the average salary of each job ID. Exclude those records where average salary is higher than 8000. Return job ID, average salary.
SELECT job_id, AVG(salary)
FROM employees
GROUP BY job_id
HAVING AVG(salary) <= 8000
ORDER BY AVG(salary)

-- 33. From the jobs table, find those job titles where the difference between minimum and maximum salaries is in the range the range 12000, 18000 (Begin and end values are included.). Return job_title, max_salary-min_salary.
SELECT job_title, max_salary — min_salary AS salary_differences
FROM jobs
WHERE max_salary — min_salary BETWEEN 12000 AND 18000

-- 34. From the employees table, find those employees whose first name or last name starts with the letter ‘D’. Return first name, last name.
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE ‘D%’
OR last_name LIKE ‘D%’

-- 35. From the jobs table, find details of those jobs where minimum salary exceeds 9000. Return all the fields of jobs.
SELECT *
FROM jobs
WHERE min_salary > 9000

-- 36. From the employees table, find those employees who joined after 7th September 1987. Return all the fields.
SELECT *
FROM employees
WHERE hire_date > ‘1987–09–07’

-- 37. From the employees and departments tables, find the first name, last name, department number, and department name for each employee.
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id

-- 38. From the employees, departments, and locations tables, find the first name, last name, department, city, and state province for each employee.
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
JOIN locations AS l
ON d.location_id = l.location_id

-- 39. From the employees and job grades tables, find the first name, last name, salary, and job grade for all employees.
SELECT e.first_name, e.last_name, e.salary, jg.grade_level
FROM employees AS e
JOIN job_grades AS jg
ON e.salary BETWEEN jg.lowest_sal AND highest_sal

-- 40. From the employees and departments tables, find all those employees who work in department ID 80 or 40. Return first name, last name, department number and department name.
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE e.department_id IN (40, 80)
ORDER BY e.department_id

-- 41. From the employees, departments, and locations tables, find those employees whose first name contains a letter ‘z’. Return first name, last name, department, city, and state province.
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
JOIN locations AS l
ON d.location_id = l.location_id
WHERE e.first_name LIKE ‘%z%’

-- 42. From the employees and departments tables, find all departments including those without any employee. Return first name, last name, department ID, department name.
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees AS e
RIGHT OUTER JOIN departments AS d
ON e.department_id = d.department_id
ORDER BY d.department_name

-- 43. From the employees table, find those employees who earn less than the employee of ID 182. Return first name, last name and salary.
SELECT first_name, last_name, salary
FROM employees
WHERE salary < (SELECT salary FROM employees WHERE employee_id = 182)

-- 44. From the employees table, find the employees and their managers. Return the first name of the employee and manager.
SELECT e1.first_name AS “Employee”, e2.first_name AS “Manager”
FROM employees AS e1
JOIN employees AS e2
ON e1.manager_id = e2.employee_id

-- 45. From the departments and locations tables, display the department name, city, and state province for each department.
SELECT d.department_name, l.city, l.state_province
FROM departments AS d
JOIN locations AS l
ON d.location_id = l.location_id
ORDER BY l.state_province, l.city

-- 46. From the employees and departments tables, find those employees who have or not any department. Return first name, last name, department ID, department name.
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees AS e
LEFT OUTER JOIN departments AS d
ON e.department_id = d.department_id
ORDER BY e.department_id

-- 47. From the employees table, find the employees and their managers. These managers do not work under any manager. Return the first name of the employee and manager.
SELECT e1.first_name AS “Employee”, e2.first_name AS “Manager”
FROM employees AS e1
RIGHT OUTER JOIN employees AS e2
ON e1.manager_id = e2.employee_id
WHERE e2.manager_id = 0

-- 48. From the employees table, find those employees who work in a department where the employee of last name ‘Taylor’ works. Return first name, last name and department ID.
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id IN (SELECT department_id FROM employees WHERE last_name = ‘Taylor’)
ORDER BY first_name, last_name

-- 49. From the employees, departments, jobs, and job history tables, find those employees who joined on or after 1st January 1993 and leave on or before 31 August 2007. Return job title, department name, employee name, and joining date of the job.
SELECT j.job_title, d.department_name, CONCAT(e.first_name, ‘ ‘, e.last_name) AS “Employee”, jh.start_date
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
JOIN jobs AS j
ON e.job_id = j.job_id
JOIN job_history AS jh
ON e.employee_id = jh.employee_id
WHERE jh.start_date >= ‘1993–01–01’
AND jh.end_date <= ‘2007–08–31’

-- 50. From the employees and jobs tables, find the difference between maximum salary of the job and salary of the employees. Return job title, employee name, and salary difference.
SELECT j.job_title, CONCAT(e.first_name, ‘ ‘, e.last_name) AS “Employee”, j.max_salary — e.salary AS “Salary Difference”
FROM employees AS e
JOIN jobs AS j
ON e.job_id = j.job_id

-- 51. From the employees and departments table, compute the average salary, number of employees received commission in that department. Return department name, average salary and number of employees.
SELECT d.department_name, AVG(e.salary) AS “Average Salary”, COUNT(e.employee_id) AS “Number of Employees”
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY AVG(e.salary) DESC

-- 52. From the employees and jobs tables, compute the difference between maximum salary and salary of all the employees who works the department of ID 80. Return job title, employee name and salary difference.
SELECT j.job_title, CONCAT(e.first_name, ‘ ‘, e.last_name) AS “Employee”, j.max_salary — e.salary AS “Salary Difference”
FROM employees AS e
JOIN jobs AS j
ON e.job_id = j.job_id
WHERE e.department_id = 80

-- 53. From the departments, locations, and countries tables, find the name of the country, city, and departments, which are running there.
SELECT c.country_name, l.city, d.department_name
FROM departments AS d
JOIN locations AS l
ON d.location_id = l.location_id
JOIN countries AS c
ON l.country_id = c.country_id
ORDER BY d.department_name

-- 54. From the employees and departments tables, find the department name and the full name (first and last name) of the manager.
SELECT d.department_name, CONCAT(e.first_name, ‘ ‘, e.last_name) AS “Manager”
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.manager_id = e.employee_id
ORDER BY d.department_id

-- 55. From the employees and jobs tables, compute the average salary of employees for each job title.
SELECT j.job_title, AVG(e.salary)
FROM employees AS e
JOIN jobs AS j
ON e.job_id = j.job_id
GROUP BY j.job_title
ORDER BY AVG(e.salary) DESC

-- 56. From the employees and job history tables, find those employees who earn $12000 and above. Return employee ID, starting date, end date, job ID and department ID.
SELECT jh.*
FROM employees AS e
JOIN job_history AS jh
ON e.employee_id = jh.employee_id
WHERE e.salary > 12000

-- 57. From the employees, departments, locations, countries tables, find those departments where at least 2 employees work. Group the result set on country name and city. Return country name, city, and number of departments.
SELECT c.country_name, l.city, COUNT(DISTINCT(e.department_id))
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
JOIN locations AS l
ON d.location_id = l.location_id
JOIN countries AS c
ON l.country_id = c.country_id
WHERE e.department_id IN (SELECT department_id FROM employees GROUP BY department_id HAVING COUNT(department_id) > 1)
GROUP BY c.country_name, l.city

-- 58. From the employees, departments, and locations tables, find the department name, full name (first and last name) of the manager and their city.
SELECT d.department_name, CONCAT(e.first_name, ‘ ‘, e.last_name) AS “Manager”, l.city
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
JOIN locations AS l
ON d.location_id = l.location_id
WHERE d.manager_id = e.employee_id
ORDER BY d.department_id

-- 59. From the jobs and job history tables, compute the number of days worked by employees in a department of ID 80. Return employee ID, job title, number of days worked.
SELECT jh.employee_id, j.job_title, jh.end_date — jh.start_date AS days_worked
FROM jobs AS j
JOIN job_history AS jh
ON j.job_id = jh.job_id
WHERE jh.department_id = 80

-- 60. From the employees, departments, and locations tables, find full name (first and last name), and salary of those employees who work in any department located in ‘London’ city.
SELECT CONCAT(e.first_name, ‘ ‘, e.last_name) AS employee, e.salary
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
JOIN locations AS l
ON d.location_id = l.location_id
WHERE l.city = ‘London’

-- 61. From the jobs and job history tables, find full name (first and last name), job title, starting and ending date of last jobs of employees who worked without a commission percentage.
SELECT CONCAT(e.first_name, ‘ ‘, e.last_name) AS employee, j.job_title, jh.start_date, jh.end_date
FROM employees AS e
JOIN jobs AS j
ON e.job_id = j.job_id
JOIN job_history AS jh
ON e.employee_id = jh.employee_id
WHERE e.commission_pct = 0
AND jh.start_date IN (SELECT MAX(jh.start_date) FROM employees AS e JOIN job_history AS jh ON e.employee_id = jh.employee_id GROUP BY e.employee_id)

-- 62. From the employees and departments tables, find the department name, department ID, and number of employees in each department.
SELECT d.department_name, d.department_id, COUNT(DISTINCT(e.employee_id))
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_id

-- 63. From the employees, departments, locations, countries tables, find the full name (first and last name) of the employee with ID and name of the country presently where he/she is working.
SELECT CONCAT(e.first_name, ‘ ‘, e.last_name) AS employee, c.country_id, c.country_name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
JOIN locations AS l
ON d.location_id = l.location_id
JOIN countries AS c
ON l.country_id = c.country_id
ORDER BY c.country_id, e.first_name, e.last_name

-- 64. From the employees table, find those employees who get higher salary than the employee whose ID is 163. Return first name, last name.
SELECT first_name, last_name
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE employee_id = 163)

-- 65. From the employees table, find those employees whose designation is the same as the employee whose ID is 169. Return first name, last name, department ID and job ID.
SELECT first_name, last_name, department_id, job_id
FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id = 169)

-- 66. From the employees table, find those employees whose salary matches the smallest salary of any of the departments. Return first name, last name and department ID.
SELECT first_name, last_name, department_id
FROM employees
WHERE salary IN (SELECT MIN(salary) FROM employees GROUP BY department_id)

-- 67. From the employees table, find those employees who earn more than the average salary. Return employee ID, first name, last name.
SELECT employee_id, first_name, last_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)

-- 68. From the employees table, find those employees who report that manager whose first name is ‘Payam’. Return first name, last name, employee ID and salary.
SELECT first_name, last_name, employee_id, salary
FROM employees
WHERE manager_id IN (SELECT employee_id FROM employees WHERE first_name = ‘Payam’)

-- 69. From the employees and departments tables, find all those employees who work in the Finance department. Return department ID, name (first), job ID and department name.
SELECT e.department_id, e.first_name, e.job_id, (SELECT department_name FROM departments AS d WHERE e.department_id = d.department_id)
FROM employees AS e
WHERE e.department_id = (SELECT department_id FROM departments WHERE department_name = ‘Finance’)

-- 70. From the employees table, find the employee whose salary is 3000 and reporting person’s ID is 121. Return all fields.
SELECT *
FROM employees
WHERE (salary, manager_id) = (SELECT 3000, 121)

-- 71. From the employees table, find those employees whose salary is in the range of smallest salary, and 2500. Return all the fields.
SELECT *
FROM employees
WHERE salary BETWEEN (SELECT MIN(salary) FROM employees) AND 2500

-- 72. From the employees and departments tables, find those employees who do not work in those departments where manager ids are in the range 100, 200 (Begin and end values are included.) Return all the fields of the employees.
SELECT *
FROM employees
WHERE department_id NOT IN (SELECT department_id FROM departments WHERE manager_id BETWEEN 100 AND 200)

-- 73. From the employees table, find those employees who get second-highest salary. Return all the fields of the employees.
SELECT *
FROM employees
WHERE employee_id IN
(SELECT employee_id FROM employees WHERE salary =
(
SELECT MIN(temp.salary) FROM
(
SELECT salary FROM employees ORDER BY salary DESC LIMIT 2
) AS temp
)
)

-- 74. From the employees table, find those employees who work in the same department where ‘Clara’ works. Exclude all those records where first name is ‘Clara’. Return first name, last name and hire date.
SELECT first_name, last_name, hire_date
FROM employees
WHERE department_id IN
(
SELECT department_id FROM employees WHERE first_name = ‘Clara’
)
AND first_name <> ‘Clara’

-- 75. From the employees table, find those employees who work in a department where the employee’s first name contains a letter ‘T’. Return employee ID, first name and last name.
SELECT employee_id, first_name, last_name
FROM employees
WHERE department_id IN
(
SELECT department_id FROM employees WHERE first_name LIKE ‘%T%’
)

-- 76. From the employees table, find those employees who earn more than the average salary and work in a department with any employee whose first name contains a character a ‘J’. Return employee ID, first name and salary.
SELECT employee_id, first_name, salary
FROM employees
WHERE salary >
(
SELECT AVG(salary) FROM employees
)
AND department_id IN
(
SELECT department_id FROM employees WHERE first_name LIKE ‘%J%’
)

-- 77. From the employees, departments, and locations tables, find those employees whose department located at ‘Toronto’. Return first name, last name, employee ID, job ID.
SELECT first_name, last_name, employee_id, job_id
FROM employees
WHERE department_id IN
(
SELECT department_id FROM departments WHERE location_id =
(
SELECT location_id FROM locations WHERE city = ‘Toronto’
)
)

-- 78. From the employees table, find those employees whose salary is lower than any salary of those employees whose job title is ‘MK_MAN’. Return employee ID, first name, last name, job ID.
SELECT employee_id, first_name, last_name, job_id
FROM employees
WHERE salary <
ANY(
SELECT salary FROM employees WHERE job_id = ‘MK_MAN’
)

-- 79. From the employees table, find those employees whose salary is more than any salary of those employees whose job title is ‘PU_MAN’. Exclude job title ‘PU_MAN’. Return employee ID, first name, last name, job ID.
SELECT employee_id, first_name, last_name, job_id
FROM employees
WHERE salary >
ANY(
SELECT salary FROM employees WHERE job_id = ‘PU_MAN’
)
AND job_id <> ‘PU_MAN’

-- 80. From the employees table, find those employees whose salary is more than average salary of any department. Return employee ID, first name, last name, job ID.
SELECT employee_id, first_name, last_name, job_id
FROM employees
WHERE salary >
ANY(
SELECT AVG(salary) FROM employees GROUP BY department_id
)

-- 81. Display the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT employee_id, CONCAT(first_name, ‘ ‘, last_name), salary,
CASE
WHEN salary > (SELECT AVG(salary) FROM employees) THEN ‘High’
ELSE ‘Low’
END AS SalaryStatus
FROM employees

-- 82. Display the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary — the average salary of all employees) and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT employee_id, CONCAT(first_name, ‘ ‘, last_name), salary AS SalaryDrawn, ROUND(salary — (SELECT AVG(salary) FROM employees)) AS AvgCompare,
CASE
WHEN salary > (SELECT AVG(salary) FROM employees) THEN ‘High’
ELSE ‘Low’
END AS SalaryStatus
FROM employees

-- 83. From the employees and departments tables, find all those departments where at least one or more employees work. Return department name.
SELECT department_name
FROM departments
WHERE department_id IN
(
SELECT DISTINCT(department_id) FROM employees
)

-- 84. From the employees, departments, locations, countries tables, find those employees who work in departments located at ‘United Kingdom’. Return first name.
SELECT first_name
FROM employees
WHERE department_id IN
(
SELECT department_id FROM departments WHERE location_id IN
(
SELECT location_id FROM locations WHERE country_id =
(
SELECT country_id FROM countries WHERE country_name = ‘United Kingdom’
)
)
)

-- 85. From the employees table, find those employees who earn more than average salary and who work in any of the ‘IT’ departments. Return last name.
SELECT last_name
FROM employees
WHERE salary >
(
SELECT AVG(salary) FROM employees
)
AND job_id LIKE ‘IT_%’

-- 86. From the employees table, find all those employees who earn more than an employee whose last name is ‘Ozer’. Sort the result in ascending order by last name. Return first name, last name and salary.
SELECT first_name, last_name, salary
FROM employees
WHERE salary >
(
SELECT salary FROM employees WHERE last_name = ‘Ozer’
)
ORDER BY last_name ASC

-- 87. From the employees, departments, and locations tables, find those employees who work under a manager based in ‘US’. Return first name, last name.
SELECT first_name, last_name
FROM employees
WHERE manager_id IN
(
SELECT manager_id FROM departments WHERE location_id IN
(
SELECT location_id FROM locations WHERE country_id = ‘US’
)
AND manager_id <> 0
)

-- 88. From the employees table, find those employees whose salary is greater than 50% of their department’s total salary bill. Return first name, last name.
SELECT first_name, last_name
FROM employees AS e
JOIN
(
SELECT department_id, SUM(salary)*0.5 AS HalfSum
FROM employees
GROUP BY department_id
) AS hs
ON e.department_id = hs.department_id
WHERE salary > hs.halfsum

-- 89. From the employees and departments tables, find those employees who are managers. Return all the fields of employees table.
SELECT *
FROM employees
WHERE employee_id IN
(
SELECT manager_id FROM departments
)

-- 90. From the employees, departments, and locations tables, find those employees who get such a salary, which is the maximum of salaried employee, joining within January 1st, 2002 and December 31st, 2003. Return employee ID, first name, last name, salary, department name and city.
SELECT e.employee_id, e.first_name, e.last_name, e.salary, d.department_name, l.city
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
JOIN locations AS l
ON d.location_id = l.location_id
WHERE e.salary = 
(
SELECT MAX(salary) FROM employees WHERE hire_date BETWEEN ‘2002–01–01’ AND ‘2003–12–31’
)

-- 91. From the departments and locations tables, find those departments, located in the city ‘London’. Return department ID, department name.
SELECT department_id, department_name
FROM departments
WHERE location_id IN
(
SELECT location_id FROM locations WHERE city = ‘London’
)

-- 92. From the employees table, find those employees who earn more than the maximum salary of a department of ID 40. Return first name, last name and department ID.
SELECT first_name, last_name, department_id
FROM employees
WHERE salary >
(
SELECT MAX(salary) FROM employees WHERE department_id = 40
)

-- 93. From the departments table, find departments for a particular location. The location matches the location of the department of ID 30. Return department name and department ID.
SELECT department_name, department_id
FROM departments
WHERE location_id =
(
SELECT location_id FROM departments WHERE department_id = 30
)

-- 94. From the employees table, find those employees who work in that department where the employee works of ID 201. Return first name, last name, salary, and department ID.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id =
(
SELECT department_id FROM employees WHERE employee_id = 201
)

-- 95. From the employees table, find those employees whose salary matches to the salary of the employee who works in that department of ID 40. Return first name, last name, salary, and department ID.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary IN
(
SELECT salary FROM employees WHERE department_id = 40
)

-- 96. From the employees and departments tables, find those employees who work in the department ‘Marketing’. Return first name, last name and department ID.
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id =
(
SELECT department_id FROM departments WHERE department_name = ‘Marketing’
)

-- 97. From the employees table, find those employees who earn more than the minimum salary of a department of ID 40. Return first name, last name, salary, and department ID.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary >
(
SELECT MIN(salary) FROM employees WHERE department_id = 40
)

-- 98. From the employees table, find those employees who joined after the employee whose ID is 165. Return first name, last name and hire date.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >
(
SELECT hire_date FROM employees WHERE employee_id = 165
)

-- 99. From the employees table, find those employees who earn less than the minimum salary of a department of ID 70. Return first name, last name, salary, and department ID.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary <
(
SELECT MIN(salary) FROM employees WHERE department_id = 70
)

-- 100. From the employees table, find those employees who earn less than the average salary, and work at the department where the employee ‘Laura’ (first name) works. Return first name, last name, salary, and department ID.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary <
(
SELECT AVG(salary) FROM employees
)
AND department_id =
(
SELECT department_id FROM employees WHERE first_name = ‘Laura’
)

-- 101. From the employees, departments, and locations tables, find those employees whose department is located in the city ‘London’. Return first name, last name, salary, and department ID.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id IN
(
SELECT department_id FROM departments WHERE location_id IN
(
SELECT location_id FROM locations WHERE city = ‘London’
)
)

-- 102. From the employees, departments, and locations tables, find the city of the employee of ID 134. Return city.
SELECT city
FROM locations
WHERE location_id =
(
SELECT location_id FROM departments WHERE department_id =
(
SELECT department_id FROM employees WHERE employee_id = 134
)
)

-- 103. From the employees, departments, and job history tables, find those departments where maximum salary is 7000 and above. The employees worked in those departments have already completed one or more jobs. Return all the fields of the departments.
SELECT *
FROM departments
WHERE department_id IN
(
SELECT department_id FROM employees GROUP BY department_id HAVING MAX(salary) >= 7000
)
AND department_id IN
(
SELECT department_id FROM job_history
)

-- 104. From the employees and departments tables, write a SQL query to find those departments where starting salary is at least 8000. Return all the fields of departments.
SELECT *
FROM departments
WHERE department_id IN
(
SELECT department_id FROM employees GROUP BY department_id HAVING MIN(salary) >= 8000
)

-- 105. From the employees table, find those managers who supervise four or more employees. Return manager name, department ID.
SELECT CONCAT(first_name, ‘ ‘, last_name) AS Manager, department_id
FROM employees
WHERE employee_id IN
(
SELECT manager_id FROM employees GROUP BY manager_id HAVING COUNT(manager_id) >= 4
)

-- 106. From the employees table, find those employees who earn second-lowest salary of all the employees. Return all the fields of employees.
SELECT *
FROM employees
WHERE salary =
(
SELECT MAX(temp.salary) FROM
(
SELECT salary FROM employees ORDER BY salary ASC LIMIT 2
) AS temp
)

-- 107. From the employees and departments tables, find those departments managed by ‘Susan’. Return all the fields of departments.
SELECT *
FROM departments
WHERE manager_id IN
(
SELECT employee_id FROM employees WHERE first_name = ‘Susan’
)

-- 108. From the employees table, find those employees who earn highest salary in a department. Return department ID, employee name, and salary.
SELECT e.department_id, CONCAT(e.first_name, ‘ ‘, e.last_name) AS employee, e.salary
FROM employees AS e
JOIN
(
SELECT department_id, MAX(salary) AS dept_max_salary FROM employees GROUP BY department_id
) AS ms
ON e.department_id = ms.department_id
WHERE e.salary = ms.dept_max_salary
ORDER BY e.department_id

-- 109. From the employees and job history tables, find those employees who did not have any job in the past. Return all the fields of employees.
SELECT *
FROM employees
WHERE employee_id NOT IN
(
SELECT employee_id FROM job_history
)
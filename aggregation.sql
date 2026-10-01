USE employer_database;
-- Section 1 — Basic Aggregate Functions

-- Q1 — Find the total number of employees in the company.
SELECT COUNT(DISTINCT(employee_id)) AS Total_Employees
FROM employees;

-- Q2 — Find how many employees have a manager assigned.
SELECT COUNT(*) AS Employees_W_manager
FROM employees
WHERE manager_id IS NOT NULL;

SELECT COUNT(manager_id) 
FROM employees;

-- Q3 — Understanding COUNT(*) vs COUNT(column) vs COUNT(1)
-- COUNT(*): counts everything, every rows with NULL values.
-- COUNT(column): Counts rows without NULL values.
-- COUNT(1): Counts rows without NULL values. Same as COUNT(*), JUST ALTERNATIVE SYNTAX.

-- Q4 — Find the total salary expense of the company.
SELECT SUM(salary) as Total_Salary_Expence 
FROM employees;

-- Q5 — Find the average salary of employees.
SELECT ROUND(AVG(salary),2) as AVG_Salary_
FROM employees;

-- Q6 — Find the highest and lowest salary in the company.
SELECT ROUND(MAX(salary)) as Max_salary, ROUND(MIN(salary)) as Min_salary
FROM employees;

-- Section 2 — GROUP BY
-- Q7 — Find the total number of employees in each department.
SELECT department, COUNT(employee_id) AS employee_count
FROM employees
WHERE department IS NOT NULL
GROUP BY department;

-- Q8 — Find the average salary of employees in each city.
SELECT city, CONCAT(ROUND(AVG(salary))," Rs")
FROM employees
GROUP BY city;

-- Q9 — Find the total number of Active employees in each department.
SELECT department, COUNT(employee_id) AS Actvie_employee
FROM employees
WHERE employment_status = "Active"
GROUP BY department;

-- Q10 — Find the total salary expense of employees working in Mumbai for each department.
SELECT department, SUM(salary) 
FROM employees
WHERE city = "Mumbai"
GROUP BY department;

-- Section 3 — HAVING
-- Q11 — Find departments having more than 5 employees.
SELECT department, COUNT(employee_id)
FROM employees
GROUP BY department
HAVING COUNT(employee_id)>5;
SELECT department, COUNT(employee_id) AS total_employees
FROM employees
GROUP BY department
HAVING total_employees > 5;

-- Q12 — Find cities whose average salary is greater than ₹70,000.
SELECT city, ROUND(AVG(salary),2)
FROM employees
GROUP BY city
HAVING ROUND(AVG(salary),2) > 70000
ORDER BY ROUND(AVG(salary),2) DESC;

-- Q13 — Find departments whose average salary lies between ₹60,000 and ₹80,000.
SELECT department, AVG(salary) AS average_salary
FROM employees 
GROUP BY department
HAVING AVG(salary) BETWEEN 60000 AND 80000;



-- Q14 — Find departments having at least 4 employees who are currently Active.
SELECT department, COUNT(employee_id)
FROM employees
WHERE employment_status="active"
GROUP BY department
HAVING COUNT(employee_id) >= 4


-- Section 4 — Finding Duplicates
-- Q15 — Find Duplicate Records By Email
SELECT email, COUNT(employee_id)
FROM employees
GROUP BY email
HAVING COUNT(employee_id) > 1;
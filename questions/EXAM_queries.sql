USE employer_database;

SELECT *
FROM employees;


-- Section C: Query Writing (60 marks)
-- Write one MySQL query per question. Use the tables and columns from your question sheets.
-- 16.	(4) Show the top 3 highest-paid Active employees whose name starts with 'S' and who have an email on record.
SELECT *
FROM employees
WHERE employee_name LIKE "S%"
ORDER BY salary DESC
LIMIT 3;

-- 17.	(5) For each department, show the headcount and average salary. Include only departments with at least 3 Active employees and an average salary above ₹70,000, sorted by average salary, highest first.
SELECT AVG(salary), department, COUNT(employee_id)
FROM employees
GROUP BY department
HAVING AVG(salary) >70000;

-- 18.	(4) Find duplicate emails, along with how many times each appears.
SELECT employee_name, count(email), email
FROM employees
GROUP BY employee_name, email
HAVING COUNT(email) > 1

-- 19.	(6) Show the employee name, project name and role for employees working on Ongoing projects.
SELECT e.employee_name, p.project_name, ep.role
FROM employees e
JOIN employee_projects ep 
ON e.employee_id = ep.employee_id
JOIN projects p
ON p.project_id = ep.project_id
WHERE p.status = "Ongoing";

-- 20.	(6) Show every client with their total number of orders, including clients with zero orders.
SELECT DISTINCT c.client_name, SUM(c.client_id) AS total_order
FROM clients c
JOIN orders_data od
ON c.client_id = od.client_id
GROUP BY od.order_id
ORDER BY total_order DESC;


-- 21.	(6) Find employees who earn more than their manager. Show the employee name, manager name and both salaries.
SELECT
e.employee_name AS manager, e.salary AS manager_salary, ep.employee_name AS employee, ep.salary AS emp_salary
FROM employees e
join employees ep
ON e.employee_id = ep.manager_id
WHERE e.salary < ep.salary;


-- 22.	(7) Using a correlated subquery, find employees who earn more than the average salary of their own department.
SELECT * 
FROM (
    SELECT employee_id, employee_name, department, salary,
    avg(salary) OVER(PARTITION BY department) as avg_salary
    FROM employees
    WHERE department IS NOT NULL 
) t
WHERE salary > avg_salary
ORDER BY employee_id;

-- 23.	(7) Using a CTE and DENSE_RANK(), find the top 2 highest-paid employees in each department.
SELECT *
FROM (select *,
DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS ranking
FROM employees
WHERE department IS NOT NULL) t
WHERE ranking <=2;
-- 24.	(6) For each employee, show the name in uppercase, the years of experience, and an experience band from a CASE expression: 0–2 years is 'Junior', 3–5 years is 'Mid Level', and more than 5 years is 'Senior'.
SELECT UPPER(employee_name), TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS Experience,
CASE 
    WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) BETWEEN 0 AND 2 THEN "Junior"
    WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) BETWEEN 3 AND 5 THEN "Mid Level"
    ELSE "Senior"
END AS Experience_Band
FROM employees;


-- 25.	(3) Create a view named active_dept_summary that shows the number of Active employees in each department.

CREATE VIEW active_dept_summary AS (
        SELECT department, COUNT(employee_id) AS Active_employees
    FROM (SELECT *
        FROM employees
        WHERE employment_status = "Active") AS active_emp
    GROUP BY department
);

SELECT *
FROM active_dept_summary;


-- 26.	(3) Create a stored procedure raise_salary that takes a department name, adds ₹1,000 to every employee in that department, then displays the updated rows.
DELIMITER //
CREATE PROCEDURE raise_salary AS
BEGIN
    



END //
DELIMITER ;

CALL raise_salary;
-- 27.	(3) Write the statements to (a) create a composite index on department and salary, (b) check how a query uses it with EXPLAIN, and (c) drop the index.

-- a
CREATE INDEX dept_salary 
ON employees(department, salary);
-- b
EXPLAIN
SELECT *
FROM employees
WHERE department = "IT" AND salary = 150000;

-- c
DROP INDEX dept_salary
ON employees;



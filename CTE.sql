USE employer_database;

-- Common Table Expressions (CTEs) in MySQL
SELECT *
FROM employees;

SELECT employee_id, employee_name, department, salary AS Current_salary,
LAG(salary) OVER(ORDER BY employee_id) AS prev_salary
FROM employees;

SELECT *
FROM (SELECT employee_id, employee_name, department, salary AS Current_salary,
      LAG(salary) OVER(ORDER BY employee_id) AS prev_salary
      FROM employees) AS inner_table
WHERE current_salary > prev_salary;


WITH temp_table AS (
    SELECT employee_id, employee_name, department, salary AS Current_Salary,
    LAG(salary) OVER(ORDER BY employee_id) AS prev_salary
    FROM employees
)
    SELECT *
    FROM temp_table
    WHERE Current_Salary > prev_salary;

-- Q1 — Using a CTE, find departments having more than 5 employees.
WITH temp_table AS (
    SELECT employee_id, employee_name, department, salary, employment_status
    FROM employees
)
SELECT department, COUNT(employee_id) AS employees
FROM temp_table
GROUP BY department
HAVING employees > 5;

-- Q2 — Using Multiple CTEs, find departments whose average salary is greater than the company average salary.

WITH department_avg AS (
    SELECT department, AVG(salary) as d_avg
    FROM employees
    GROUP BY department
),
company_avg AS(
    SELECT AVG(salary) AS c_avg
    FROM employees
)

SELECT *
FROM company_avg
CROSS JOIN department_avg
WHERE c_avg < d_avg;


-- Q3 — Using a CTE, find employees who have received more than one bonus.
WITH emp AS(
    SELECT employee_id, employee_name, department, salary
    FROM employees
),
bonus AS (
        SELECT b.employee_id, COUNT(bonus_amount) AS bonus_received
        FROM bonuses b
        GROUP BY employee_id
        HAVING bonus_received > 1
)
SELECT *
FROM emp e
JOIN bonus b
ON e.employee_id = b.employee_id;

SELECT e.employee_id, e.employee_name, e.department, e.salary, COUNT(bonus_amount) AS bonus_received
FROM employees e
JOIN bonuses b
ON e.employee_id = b.employee_id
GROUP BY e.employee_id
HAVING bonus_received > 1;

-- Q4 — Using a CTE, find the top 2 highest-paid employees from each department.
WITH temp_table AS (
    SELECT e.employee_id, e.employee_name, e.department, e.salary,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS ranking
    FROM employees e
)
SELECT * FROM temp_table
WHERE salary IS NOT NULL AND department IS NOT NULL AND
ranking IN (1, 2);
WITH temp_table AS (
    SELECT e.employee_id, e.employee_name, e.department, e.salary,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS ranking
    FROM employees e
)
SELECT * FROM temp_table
WHERE salary IS NOT NULL AND department IS NOT NULL AND
ranking <= 2;

SELECT *
FROM (SELECT e.employee_id, e.employee_name, e.department, e.salary,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS ranking
    FROM employees e) AS temp_table
WHERE ranking <=2;

-- Q5 — Using Multiple CTEs, find employees whose salary is greater than the average salary of their department, and display their department rank.

WITH dept_avg_salary AS (
    SELECT *,
    AVG(salary) OVER(PARTITION BY department) AS das
    FROM employees
    WHERE department IS NOT NULL
),
temp_table AS (
    SELECT *, RANK() OVER(PARTITION BY department ORDER BY salary DESC) as ranking
    FROM dept_avg_salary
)

SELECT employee_id, employee_name, department, salary, das
FROM temp_table
WHERE salary > das;

-- Find employees whose salary is greater than the average salary of their department, and display their department rank.
-- Subquery version
SELECT employee_name, department, salary, avg_salary
FROM (SELECT *,
    AVG(salary) OVER(PARTITION BY department) AS avg_salary
    FROM employees
    WHERE department IS NOT NULL) AS temp_table
WHERE salary > avg_salary; 

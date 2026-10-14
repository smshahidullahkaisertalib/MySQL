USE employer_database;

SELECT *
FROM employees;

-- SQL Views & Advanced Patterns
-- Q1 — Create a view to display all Active employees.
CREATE VIEW talib AS (
    SELECT *
    FROM employees
    WHERE employment_status = "Active"
);

SELECT COUNT(*)
FROM talib;

DROP VIEW talib;
SHOW FULL TABLES;

-- Q2 — Create a view to display employee name, department, and salary of employees earning more than ₹70,000.
CREATE VIEW emp_virtual AS (
    SELECT employee_name, department, salary
    FROM employees
    WHERE salary > 70000
);
SELECT *
FROM emp_virtual;

-- Q3 — Create a view to display each employee along with their manager's name.
SELECT *
FROM employees;
CREATE VIEW manager_employee_assign AS (
SELECT e.employee_id, e.employee_name AS employee, mgr.employee_id AS manager_employee_id, mgr.employee_name AS manager
FROM employees e
JOIN employees mgr
ON mgr.employee_id = e.manager_id
);
SELECT *
FROM manager_employee_assign;

SELECT *
FROM employees;

-- Q4 — Create a view to display the total number of employees in each department.
ALTER VIEW department_employee AS 
SELECT department, COUNT(*) AS employees
FROM employees
GROUP BY department
HAVING department IS NOT NULL;

SELECT *
FROM department_employee;


-- Q5 — Create a view to display the highest-paid employee from each department.
SELECT department, MAX(salary) AS highest_salary
FROM employees
GROUP BY department;

CREATE VIEW highest_paid_employees AS 
(SELECT *
FROM (SELECT employee_name, department,salary, 
      RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS ranking
      FROM employees) t
WHERE ranking = 1 AND department IS NOT NULL);

SELECT *
FROM highest_paid_employees;
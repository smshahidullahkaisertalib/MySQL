USE employer_database;

-- Q1 — Find employees whose salary is greater than the average salary of the company
SELECT employee_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Q2 — Find employees earning the highest salary in the company
SELECT employee_name, salary AS highest_salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- Q3 — Find employees who work in the same department as 'Aarav Sharma'
SELECT *
FROM employees
WHERE department IN (SELECT department 
                    FROM employees 
                    WHERE employee_name = "Aarav Sharma")


-- Q4 — Find employees whose salary is greater than all employees in the Support department
SELECT employee_name, salary
FROM employees
WHERE salary > ALL (SELECT salary
                FROM employees 
                WHERE department = "Support")



-- Q5 — Find employees working in departments where at least one employee is currently on leave
SELECT *
FROM employees
WHERE department IN (
    SELECT department
    FROM employees 
    WHERE employment_status = "On Leave"
);

-- Q6 — Find employees who have received bonuses - using subquery

SELECT *
FROM bonuses;
SELECT *
FROM employees;
SELECT e.employee_name, e.department, b.bonus_amount
FROM employees e
JOIN bonuses b
ON e.employee_id = b.employee_id;
-- --------------------------

SELECT employee_name, department, salary 
FROM employees
WHERE employee_id IN(
    SELECT employee_id
    FROM bonuses
);
-- --------------------------
SELECT employee_name, department, salary
FROM employees e
WHERE EXISTS(
    SELECT 1 
    FROM bonuses b
    WHERE e.employee_id = b.employee_id
)


-- Q7 — Find employees who never received any bonus
SELECT employee_name, department, salary
FROM employees 
WHERE employee_id NOT IN(
    SELECT employee_id
    FROM bonuses
);
-- --------------------------
SELECT employee_name, department, salary
FROM employees e
WHERE NOT EXISTS(
    SELECT 1
    FROM bonuses b
    WHERE b.employee_id = e.employee_id
)
    

-- Q8 — Find employees whose salary is greater than the average salary of their own department
SELECT *
FROM employees
WHERE salary > (
    SELECT employee_name, AVG(salary)
    FROM employees
    GROUP BY department
    HAVING salary > AVG(salary)
)

SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees ep
    WHERE e.department = ep.department
)


-- Q9 — Find employees who are assigned to at least one project
SELECT * FROM employees;
SELECT * FROM employee_projects;
SELECT *
FROM employees
WHERE employee_id IN(
    SELECT employee_id
    FROM employee_projects
);

SELECT *
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employee_projects ep
    WHERE ep.employee_id = e.employee_id
)

-- Q10 — Find employees who earn more than their manager

USE employer_database;

SELECT *
FROM employees AS e
WHERE salary > (
    SELECT m.salary
    FROM employees AS m
    WHERE m.employee_id = e.manager_id
)



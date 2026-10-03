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

-- Q6 — Find employees who have received bonuses

-- Q7 — Find employees who never received any bonus

-- Q8 — Find employees whose salary is greater than the average salary of their own department

-- Q9 — Find employees who are assigned to at least one project

-- Q10 — Find employees who earn more than their manager
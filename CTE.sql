USE employer_database;

-- Common Table Expressions (CTEs) in MySQL
SELECT *
FROM employees;

WITH first_CTE AS(
    SELECT * FROM employees
)

SELECT salary as ranking
FROM first_CTE
WHERE 
ORDER BY ranking DESC;

-- Q1 — Using a CTE, find departments having more than 5 employees.

-- Q2 — Using Multiple CTEs, find departments whose average salary is greater than the company average salary.

-- Q3 — Using a CTE, find employees who have received more than one bonus.

-- Q4 — Using a CTE, find the top 2 highest-paid employees from each department.

-- Q5 — Using Multiple CTEs, find employees whose salary is greater than the average salary of their department, and display their department rank.
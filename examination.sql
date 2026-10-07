USE employer_database;

-- Find Duplicate Records By Email
SELECT employee_name, COUNT(email)
FROM employees
GROUP BY employee_name
HAVING COUNT(email) > 1;

-- Active employees whose name starts with 'S' (Pattern Matching / Filtering)

-- Find departments having at least 4 employees who are currently Active (HAVING & WHERE combination)

-- Employees Who Never Received a Bonus (LEFT JOIN & IS NULL / Anti-Join Pattern)

-- Find employees whose salary is greater than the average salary of their own department (Correlated Subquery)
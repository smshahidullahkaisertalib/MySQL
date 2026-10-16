USE employer_database;

-- Q1. Display all employee IDs who have received either a bonus or taken a leave.
SELECT employee_id AS `id`
FROM bonuses
UNION
SELECT employee_id AS `id`
FROM leaves_data;
-- Q2. Display the names of all employees and all clients in a single result set.

SHOW FULL TABLEs

SELECT employee_name, 'Employee' AS Type
FROM employees
UNION ALL
SELECT client_name, "Client" AS Type 
FROM clients;
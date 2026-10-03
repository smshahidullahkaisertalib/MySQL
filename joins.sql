USE employer_database;

-- SQL Joins & Advanced Queries
-- Q1 — Employee Name, Bonus Amount & Bonus Date
SELECT employee_name, bonus_amount, bonus_date
FROM employees AS e
INNER JOIN bonuses AS b
ON e.employee_id = b.employee_id;

-- Q2 — Employee Name, Project Name & Role
SELECT employee_Name, project_name, role
FROM employees e
JOIN employee_projects ep
ON e.employee_id = ep.employee_id
JOIN projects p
ON p.project_id = ep.project_id;

-- Q3 — Employees with Bonus Greater than ₹10,000
SELECT employee_name, bonus_amount
FROM employees AS e
JOIN bonuses AS b
ON e.employee_id = b.employee_id
WHERE bonus_amount > 10000; 

-- Q4 — Employees On Leave with Their Manager Names
SELECT e.employee_name, m.employee_id
FROM employees AS e
JOIN employees AS m 
ON e.manager_id = m.employee_id
WHERE e.employment_status = "On Leave";


-- Q5 — Employees Who Never Received a Bonus
SELECT e.employee_id, e.employee_name, b.bonus_amount
FROM employees AS e
LEFT JOIN bonuses AS b
ON e.employee_id = b.employee_id
WHERE b.bonus_amount IS NULL;

SELECT *
FROM bonuses;

-- Q6 — All Managers with Their Direct Reports (Including Managers with No Reports)
-- Display all the manager with the employees they manage including manager who manages no employee
SELECT e.employee_name AS Employee, m.employee_name AS manager_name
FROM employees AS e
LEFT JOIN employees AS m 
ON e.manager_id = m.employee_id;

-- Q7 — Employees Working on More Than One Project
SELECT e.employee_name, COUNT(ep.project_id) AS running_project
FROM employees e
JOIN employee_projects ep
ON e.employee_id = ep.employee_id
GROUP BY e.employee_name
HAVING running_project > 1;

-- Q8 — Employees Not Assigned to Any Project
SELECT e.employee_name, ep.project_id AS running_project
FROM employees e
LEFT JOIN employee_projects ep
ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL;

-- Q9 — Projects with No Employees Assigned
SELECT p.project_id, p.project_name
FROM projects p
LEFT JOIN employee_projects ep 
ON p.project_id = ep.project_id
WHERE ep.employee_id IS NULL;


-- Q10 — Clients with Total Number of Orders
--we use LEFT JOIN here so that we could find out company which even didn't order

SELECT c.client_name, COUNT(od.order_id) AS total_order
FROM orders_data od
LEFT JOIN clients c 
ON od.client_id = c.client_id
GROUP BY client_name
ORDER BY total_order;





USE employer_database;

-- Basic SELECT
-- Q1 — Retrieve all employee details
SELECT * FROM employees;

-- Q2 — Retrieve name, department, and salary only
SELECT employee_name, department, salary FROM employees;

-- Q3 — Find all unique departments
SELECT DISTINCT(department) FROM employees
WHERE department IS NOT NULL;

-- Filtering with WHERE
-- Q4 — Employees in the IT department
SELECT * FROM employees WHERE department = "IT";

-- Q5 — Employees earning more than ₹80,000
SELECT * FROM employees WHERE salary> 80000;

-- Q6 — IT employees earning more than ₹80,000
SELECT * FROM employees WHERE department="IT" AND salary>80000;

-- Q7 — Employees in IT or Finance
SELECT * FROM employees WHERE department="IT" OR department="finance";
SELECT * FROM employees WHERE department="IT" OR department="finance" AND salary>80000;
SELECT * FROM employees WHERE department IN ("finance","IT") AND Salary>80000;

-- Q8 — Employees who are NOT Active
SELECT * FROM employees WHERE employment_status !="active";
SELECT * FROM employees WHERE employment_status <> "active";

-- Q9 — Employees in IT, HR, or Finance
SELECT * FROM employees WHERE department in("IT", "HR", "Finance");

-- Q10 — Employees with salary between ₹50,000 and ₹80,000
SELECT * FROM employees WHERE salary BETWEEN 50000 AND 80000;
SELECT * FROM employees WHERE salary >= 50000 AND salary <= 80000;

-- Pattern Matching with LIKE
-- Q11 — Employees whose name starts with 'A'
SELECT * FROM employees WHERE employee_name LIKE "A%"

-- Q12 — Employees with a Gmail address
SELECT * FROM employees WHERE email LIKE "%gmail.com";

-- Q13 — Active employees whose name starts with 'S'
SELECT * FROM employees WHERE employee_name LIKE "S%" AND employment_status="Active";

-- NULL Checks
-- Q14 — Employees with no manager assigned
SELECT * FROM employees WHERE manager_id IS NULL;

-- Q15 — Employees with an email on record(is available)
SELECT * FROM employees WHERE email IS NULL;

-- Sorting with ORDER BY
-- Q16 — Sort by salary (lowest to highest)
select employee_name, department, salary FROM employees ORDER BY salary ASC;

-- Q17 — Sort by salary (highest to lowest)
select employee_name, department, salary FROM employees ORDER BY salary DESC;

-- Q18 — Sort by department, then salary descending
SELECT employee_name, department, salary FROM employees ORDER BY department, salary DESC;
SELECT employee_name, department, salary FROM employees
WHERE department IS NOT NULL ORDER BY department, salary DESC;

-- Limiting Results & Combined Queries
-- Q19 — Top 5 highest-paid employees
SELECT employee_name, department, salary FROM employees ORDER BY salary DESC LIMIT 5;

-- Q20 — Top 3 highest-paid IT/Finance employees earning ₹70K–₹1L
SELECT employee_name, department, salary 
FROM employees 
WHERE salary BETWEEN 70000 AND 100000 AND department IN("IT", "Finance")
ORDER BY salary DESC
LIMIT 3;


 SELECT * FROM employees;

UPDATE employees
SET employee_name = "Null Employee"
WHERE employee_id = 47;
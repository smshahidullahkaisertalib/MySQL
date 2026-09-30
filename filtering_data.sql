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
select * from employees where department = 'IT';

Q5 — Employees earning more than ₹80,000

Q6 — IT employees earning more than ₹80,000

Q7 — Employees in IT or Finance

Q8 — Employees who are NOT Active

Q9 — Employees in IT, HR, or Finance

Q10 — Employees with salary between ₹50,000 and ₹80,000

Pattern Matching with LIKE
Q11 — Employees whose name starts with 'A'

Q12 — Employees with a Gmail address

Q13 — Active employees whose name starts with 'S'

NULL Checks
Q14 — Employees with no manager assigned

Q15 — Employees with an email on record

Sorting with ORDER BY
Q16 — Sort by salary (lowest to highest)

Q17 — Sort by salary (highest to lowest)

Q18 — Sort by department, then salary descending

Limiting Results & Combined Queries
Q19 — Top 5 highest-paid employees

Q20 — Top 3 highest-paid IT/Finance employees earning ₹70K–₹1L



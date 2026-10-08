USE employer_database;

SELECT *
FROM employees;

-- Window Functions & Advanced Analytical Queries
-- Q1 — Assign a unique row number to each employee based on salary
SELECT employee_name, salary, ROW_NUMBER() OVER(ORDER BY salary DESC) AS rank_salary
FROM employees;

-- Q2 — Rank employees based on salary using RANK()
SELECT employee_name, salary, RANK() OVER(ORDER BY salary DESC) AS salary_ranking
FROM employees;

-- Q3 — Rank employees based on salary using DENSE_RANK()
SELECT employee_name, salary, DENSE_RANK() OVER(ORDER BY salary DESC) AS salary_ranking
FROM employees;

-- Q4 — Compare ROW_NUMBER vs RANK vs DENSE_RANK side by side

-- Q5 — Find the employee with the 2nd highest salary
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

SELECT *
FROM (SELECT *, DENSE_RANK() OVER(ORDER BY salary DESC) AS highest_salary
      FROM employees) AS salary_table
WHERE highest_salary = 2;

SELECT *
FROM
    (SELECT *, Dense_RANK() OVER(ORDER BY salary DESC) AS highest_salary
    FROM employees) AS salary_table
WHERE highest_salary = 1;


-- Q6 — Display each employee's rank within their department based on salary
SELECT employee_name,department, salary, DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS salary_rank,
        ROW_NUMBER() OVER() AS row_count
FROM employees
WHERE department IS NOT NULL;

-- Q7 — Find the highest-paid employee from each department

SELECT *
FROM (SELECT employee_name,department, salary, DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS HR
    FROM employees
    WHERE department IS NOT NULL) AS st
WHERE HR = 1;

SELECT *
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees ep
    WHERE ep.department = e.department
)
ORDER BY salary DESC;

-- Q8 — Find employees earning more than the previous employee
SELECT * 
FROM 
    (SELECT employee_id, employee_name, salary,LAG(employee_id) OVER(ORDER BY employee_id) as prev_person_id, LAG(employee_name) OVER(ORDER BY employee_id) as prev_person_name, LAG(salary) OVER(ORDER BY employee_id) as prev_person_salary
    FROM employees) AS salary_table
WHERE salary > prev_person_salary;
-- Q9 — Find employees earning less than the next employee
SELECT *
FROM 
    (SELECT employee_id, employee_name, salary, LEAD(employee_name) OVER(ORDER BY employee_id) AS                 next_person_name, LEAD(salary) OVER(ORDER BY employee_id) AS next_person_salary
    FROM employees) as salary_table
WHERE salary < next_person_salary;

-- Q10 — Display the salary difference between each employee and the previous employee
SELECT employee_id, employee_name, salary, salary - LAG(salary) OVER(ORDER BY employee_id) As salary_diff
FROM employees;
-- Q11 — LAG vs LEAD — side-by-side comparison

-- Q12 — GROUP BY vs PARTITION BY — side-by-side comparison

-- Q13 — Find departments where multiple employees share the same salary rank
WITH ranked AS 
            (SELECT employee_id, employee_name, department, salary, DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS salary_rank
            FROM employees
            WHERE department IS NOT NULL)
            
SELECT department, salary_rank, COUNT(*) FROM ranked
GROUP BY department, salary_rank
HAVING COUNT(*) > 1;

-- Q14 — Display each employee along with the total salary expense of their department
SELECT employee_name,department,salary, SUM(salary) OVER(PARTITION BY department) AS salary_expence
FROM employees
WHERE department IS NOT NULL AND salary IS NOT NULL;

-- Q15 — Display a running total of salaries within each department
SELECT employee_id,employee_name, department,salary, SUM(salary) OVER(PARTITION BY department ORDER BY employee_id) AS running_total
FROM employees
WHERE department IS NOT NULL AND salary IS NOT NULL;

-- Q16 — Find employees earning more than the average salary of their department
SELECT *
FROM (SELECT employee_name,department, salary, AVG(salary) OVER(PARTITION BY department) AS avg_salary
      FROM employees 
WHERE department IS NOT NULL) AS salary_table
WHERE salary > avg_salary;

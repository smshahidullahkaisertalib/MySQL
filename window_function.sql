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

-- Q8 — Find employees earning more than the previous employee

-- Q9 — Find employees earning less than the next employee

-- Q10 — Display the salary difference between each employee and the previous employee

-- Q11 — LAG vs LEAD — side-by-side comparison

-- Q12 — GROUP BY vs PARTITION BY — side-by-side comparison

-- Q13 — Find departments where multiple employees share the same salary rank

-- Q14 — Display each employee along with the total salary expense of their department

-- Q15 — Display a running total of salaries within each department

-- Q16 — Find employees earning more than the average salary of their department
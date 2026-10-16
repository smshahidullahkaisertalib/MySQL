USE employer_database;

-- Indexes in MySQL
-- SQL Indexes & Performance
-- Q1 — Create a Single-Column Index
CREATE INDEX email_index
ON employees(email);

SHOW INDEXES FROM employees;
DROP INDEX email_index
ON employees;

-- Q2 — Create a Composite Index
CREATE INDEX name_index
ON employees(employee_name, department);

-- In composite index, (one or more conditions)
-- if I look data only by the name, it will run name_index cause composite index prefers LEFT MOST CONDITIONS as well
-- If I look for data with all conditions, it also run INDEX
-- but if I look data with other condition(not the left most one for example: department) it will run a filter


-- runs composite INDEX
EXPLAIN ANALYZE
SELECT *
FROM employees
WHERE employee_name = "SM Talib" AND department = "IT";

-> Index lookup on employees using name_index (employee_name='SM Talib', department='IT')  (cost=0.35 rows=1) (actual time=0.0811..0.0876 rows=1 loops=1)


-- runs composite INDEX
EXPLAIN ANALYZE
SELECT *
FROM employees
WHERE employee_name = "SM Talib";

-> Index lookup on employees using name_index (employee_name='SM Talib')  (cost=0.35 rows=1) (actual time=0.0728..0.0783 rows=1 loops=1)


-- runs filter
EXPLAIN ANALYZE
SELECT *
FROM employees
WHERE department = "IT";

-> Filter: (employees.department = 'IT')  (cost=5.45 rows=5.2) (actual time=0.145..0.248 rows=17 loops=1)
    -> Table scan on employees  (cost=5.45 rows=52) (actual time=0.135..0.226 rows=53 loops=1)


DROP INDEX name_index
ON employees;
-- Q3 — Create a UNIQUE Index
CREATE INDEX index_unique
ON employees(employee_id)

SELECT *
FROM employees
WHERE employee_id = 53

-- Q4 — Create a Prefix Index
-- A prefix index indexes only the first N characters of a column — here, the first 5 characters of email.

-- When to use it

-- Large text columns (VARCHAR(1000), TEXT) where a full-column index would be huge.
-- Saves storage — the index only stores a slice of each value.
-- Faster index creation and updates — less data to maintain.

CREATE INDEX email_index
ON employees(email(5));

EXPLAIN ANALYZE
SELECT *
FROM employees
WHERE email = "reignoftalib@gmail.com";

-- Q5 — Remove an Index
DROP INDEX name_index ON employees;

-- Q6 — Check Existing Indexes
SHOW INDEXES FROM employees;

-- Q7 — Check Query Performance with EXPLAIN
EXPLAIN
SELECT *
FROM employees
WHERE employee_name = "SM Talib";


-- Q8 — Measure Real Performance with EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT *
FROM employees
WHERE employee_name = "SM Talib";


USE employer_database;

CREATE TABLE organization (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(1000),
    designation   VARCHAR(50),
    manager_id    INT
);

INSERT INTO organization VALUES
(1, 'Raj Sharma',    'CEO',                 NULL),
(2, 'Sneha Kapoor',  'CTO',                 1),
(3, 'Amit Patel',    'HR Head',             1),
(4, 'Aarav Sharma',  'Engineering Manager', 2),
(5, 'Priya Mehta',   'Senior Developer',    4),
(6, 'Rohit Jain',    'Developer',           5),
(7, 'Anjali Verma',  'HR Executive',        3);

SELECT *
FROM organization;

WITH ct as (
    SELECT *
    FROM organization
)

SELECT *
FROM ct;

-- Q1. Generate the numbers 1 to 10 using a Recursive CTE.
WITH RECURSIVE ct AS (
    SELECT 1 AS num
    union all
    SELECT num + 1
    FROM ct
    WHERE num < 10
)

SELECT * FROM ct;

-- Q2. Display the complete employee hierarchy.
WITH RECURSIVE organization_hierarchy AS (

    SELECT employee_id, employee_name, designation, 1 AS LEVEL, employee_name AS hierarchy_path
    FROM organization
    WHERE manager_id IS NULL  

    UNION ALL

    SELECT o.employee_id, o.employee_name, o.designation, oh.level + 1,
           CONCAT(oh.hierarchy_path, ' -> ', o.employee_name)
    FROM organization o
    JOIN organization_hierarchy oh 
      ON o.manager_id = oh.employee_id
)
SELECT * FROM organization_hierarchy;

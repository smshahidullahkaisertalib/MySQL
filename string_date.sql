-- String, Date Functions & CASE Statements
-- Q1 — Display employee name in uppercase along with the length of the employee name.
SELECT UPPER(employee_name), LENGTH(employee_name)
FROM employees;

-- Q2 — Display employee details in the format: Raj Sharma (raj.sharma@company.com) - Mumbai
SELECT CONCAT(employee_name, "(", email, ")", " - ", state)
FROM employees;
SELECT *
FROM employees;

-- Q3 — Extract the username from employee email addresses.
SELECT SUBSTRING_INDEX(email,'@',1)
FROM employees;

-- Q4 — Find employees whose email domain is gmail.com.
SELECT email 
FROM employees
WHERE email LIKE "%gmail.com";

SELECT *
FROM employees
WHERE SUBSTRING_INDEX(email,'@', -1) = 'gmail.com';

-- Q5 — Display employee initials. e.g., Raj Sharma → RS, Priya Mehta → PM
SELECT LEFT(employee_name, 1), LEFT(SUBSTRING_INDEX(employee_name, " ", -1), 1)
FROM employees;
SELECT CONCAT(LEFT(employee_name, 1),"", LEFT(SUBSTRING_INDEX(employee_name, " ", -1), 1)) AS Short_Form
FROM employees;

-- Q6 — Find employees who joined in the last 30 days.
-- interview question
SELECT *
FROM employees
WHERE hire_date BETWEEN CURDATE() - INTERVAL 30 DAY AND CURDATE();
-- "hire_date >=" means "hire_date" theke baa "hire_date" theke pore
-- "hire_date <=" means "hire_date" theke baa "hire_date" theke age
SELECT *
FROM employees
WHERE hire_date >= CURDATE() - INTERVAL 30 DAY;
SELECT *
FROM employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT MIN(hire_date)
FROM employees;
SELECT MAX(hire_date)
FROM employees;

SELECT CURDATE()

-- Q7 — Find employees who have completed more than 5 years in the company.
SELECT *, TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS working_year
FROM employees
WHERE TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 5


-- Q8 — Display employee name, joining year, joining month name, and total years of experience.
SELECT employee_name, YEAR(hire_date) AS joining_year, 
        MONTHNAME(hire_date) joining_month_name, 
        TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) As working_year
FROM employees;


-- Q9 — Display bonus details along with the day name on which the bonus was awarded.
SELECT *, DAYNAME(bonus_date)
FROM bonuses;

-- Q10 — Display all projects along with their start date in the format: 01-Jan-2025
SELECT project_name, DATE_FORMAT(start_date, "%d-%b-%Y") AS start_date
FROM projects;


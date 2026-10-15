USE employer_database;

SELECT *
FROM employees;
-- Stored Procedures & Advanced Patterns
-- Q1 — Create a Stored Procedure to display all Active employees.

DELIMITER //
CREATE PROCEDURE active_employee()
BEGIN
    SELECT *
    FROM employees
    WHERE employment_status = 'Active';
END //
DELIMITER ;

CALL active_employee();
-- Q2 — Create a Stored Procedure that accepts a department name and displays employees of that department.
DELIMITER //
CREATE PROCEDURE department_names(IN department_name VARCHAR(100))
    BEGIN
        SELECT *
        FROM employees
        WHERE department = department_name;
    END //
DELIMITER ;

CALL department_names("support");

SELECT *
        FROM employees
        WHERE department = "IT";

-- Q3 — Create a Stored Procedure to add ₹1,000 to the salary of all employees in a department, then display the updated rows.
DROP PROCEDURE IF EXISTS update_salary;
DELIMITER //
CREATE PROCEDURE update_salary(IN department_name VARCHAR(100))
begin
    UPDATE employees
    SET salary = salary + 1000
    WHERE department = department_name;

    SELECT *
    FROM employees
    WHERE department = department_name;
END //
DELIMITER ;
CALL update_salary("IT");
update employees
SET salary = salary - 1000
WHERE department = "IT"



SELECT * FROM employees;
-- Q4 — Create a Stored Procedure to return the total number of employees.

DELIMITER //
CREATE PROCEDURE total_employees()
BEGIN
    SELECT COUNT(employee_id)
    FROM employees;
END
DELIMITER ;
CALL total_employees();
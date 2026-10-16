USE employer_database;

SELECT *
FROM employees;

-- Q. Whenever an employee's salary is updated, automatically store the employee ID, old salary, new salary, increment date, and increment percentage in a salary_history table.

DELIMITER //
CREATE TRIGGER updatedSalary
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_history(
            employee_id,
            old_salary,
            new_salary,
            increment_date,
            increment_pct
        )
        VALUES(
            OLD.employee_id,
            OLD.salary,
            NEW.salary,
            CURDATE(),
            ROUND(((NEW.salary - OLD.salary) / OLD.salary * 100), 2)
        );
    END IF;
END //

DELIMITER ;


SELECT * FROM salary_history;
SELECT * FROM employees;

UPDATE employees
SET salary = 150000
WHERE employee_id = 53;
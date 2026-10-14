-- Q11. Categorize employees based on salary.
--      Conditions:
--      - Salary >= 100000 -> 'High Salary'
--      - Salary BETWEEN 60000 AND 99999 -> 'Medium Salary'
--      - Else -> 'Low Salary'

SELECT *,
CASE 
        WHEN salary >= 100000 THEN CONCAT("high salary - ", salary)
        WHEN salary BETWEEN 60000 AND 99999 THEN CONCAT("medium salary - ", salary) 
        ELSE CONCAT("Low Salary - ", salary)
END
FROM employees;

-- Q12. Categorize employees based on experience.
--      Conditions:
--      - 0 to 2 Years -> 'Junior'
--      - 3 to 5 Years -> 'Mid Level'
--      - More than 5 Years -> 'Senior'
WITH employee_group AS (
        SELECT *, TIMESTAMPDIFF(YEAR,hire_date, CURDATE()) AS experience
        FROM employees
)
SELECT *,
        CASE 
                WHEN experience BETWEEN 0 AND 2 THEN "Junior"
                WHEN experience BETWEEN 3 AND 5 THEN "Medium"
                ELSE "Senior"
        END AS Employee_Group
FROM employee_group;

SELECT *, 
CASE 
        WHEN TIMESTAMPDIFF(YEAR,hire_date, CURDATE()) <=2 THEN "Junior"
        WHEN TIMESTAMPDIFF(YEAR,hire_date, CURDATE()) BETWEEN 3 AND 5 THEN "Medium"
        ELSE "Senior"
END AS employee_group
FROM employees


-- Q13. Find the total number of Active employees using CASE statement.
SELECT
        CASE 
                WHEN employment_status = "Active" THEN COUNT(employee_id)
        END AS Active_Employees 
FROM employees
GROUP BY employment_status
HAVING Active_Employees IS NOT NULL;

-- Q14. Display project status with business-friendly labels.
--      Conditions:
--      - 'Ongoing' -> 'In Progress'
--      - 'Completed' -> 'Successfully Delivered'
--      - 'On Hold' -> 'Awaiting Approval'

SELECT project_id, project_name,
CASE 
        WHEN status = "Ongoing" THEN "In Progress" 
        WHEN status = "Completed" THEN "Successfully Delivered" 
        WHEN status = "On Hold" THEN "Awaiting Approval" 
 
END AS project_status
FROM projects;

-- Q15. Display employee names along with a custom message.
--      Conditions:
--      - Active AND Salary > 100000 -> 'Star Employee'
--      - Active -> 'Active Employee'
--      - Else -> 'Needs Attention'
SELECT employee_name,
CASE 
        WHEN employment_status="Active" AND salary > 100000 THEN "Star Employee" 
        WHEN employment_status="Active" THEN "Active Employee" 
        ELSE "Need Attention"
END
FROM employees;
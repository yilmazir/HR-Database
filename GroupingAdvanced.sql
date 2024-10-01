USE humanresources;
-- Create 3 queries with GROUP BY clause
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

SELECT job_id, COUNT(*) AS job_count
FROM employees
GROUP BY job_id;

SELECT YEAR(hire_date) AS hire_year, SUM(salary) AS total_salary
FROM employees
GROUP BY hire_year;

-- Create 3 queries with aggregate functions(COUNT, MIN, MAX, SUM, AVG)
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;

SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary
FROM employees;

SELECT department_id, SUM(salary) AS total_salary, AVG(salary) AS avg_salary
FROM employees
WHERE department_id = 8
GROUP BY department_id;

-- Create 3 queries with HAVING clause
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING avg_salary > 9000;

SELECT job_id, COUNT(*) AS job_count
FROM employees
GROUP BY job_id
HAVING job_count > 5;

SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
HAVING total_salary > 50000;

-- Create a query by LEFT JOIN
SELECT employees.employee_id, employees.first_name, employees.last_name, departments.department_name
FROM employees
LEFT JOIN departments ON employees.department_id = departments.department_id;

-- Create a query by RIGHT JOIN
SELECT employees.employee_id, employees.first_name, employees.last_name, departments.department_name
FROM employees
RIGHT JOIN departments ON employees.department_id = departments.department_id;

-- Create 3 queries with Joining 2 tables
SELECT employees.employee_id, employees.first_name, employees.last_name, jobs.job_title
FROM employees
JOIN jobs ON employees.job_id = jobs.job_id;

SELECT employees.employee_id, employees.first_name, employees.last_name, departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id;

SELECT employees.employee_id, employees.first_name, employees.last_name, dependents.dependent_id, dependents.first_name AS dependent_first_name
FROM employees
JOIN dependents ON employees.employee_id = dependents.employee_id;

-- Create 3 queries with Joining 3 tables
SELECT employees.employee_id, employees.first_name, employees.last_name, jobs.job_title, departments.department_name
FROM employees
JOIN jobs ON employees.job_id = jobs.job_id
JOIN departments ON employees.department_id = departments.department_id;

SELECT employees.employee_id, employees.first_name, employees.last_name, managers.first_name AS manager_first_name, jobs.job_title
FROM employees
JOIN employees AS managers ON employees.manager_id = managers.employee_id
JOIN jobs ON employees.job_id = jobs.job_id;

SELECT employees.employee_id, employees.first_name, employees.last_name, dependents.dependent_id, dependents.first_name AS dependent_first_name
FROM employees
JOIN dependents ON employees.employee_id = dependents.employee_id
JOIN jobs ON employees.job_id = jobs.job_id;

-- Create 3 queries with subquery in WHERE clause
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE hire_date > (SELECT MIN(hire_date) FROM employees);

SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE department_id = 8 AND salary > (SELECT AVG(salary) FROM employees);

-- Create 3 queries with subquery in SELECT columns
SELECT employee_id, first_name, last_name, job_id,
  (SELECT MIN(salary) FROM employees WHERE job_id = e.job_id) AS min_salary_for_job
FROM employees e;

SELECT employee_id, first_name, last_name, department_id,
  (SELECT COUNT(*) FROM employees WHERE department_id = e.department_id) AS employee_count_for_department
FROM employees e;

SELECT employee_id, first_name, last_name, job_id,
  (SELECT SUM(salary) FROM employees WHERE job_id = e.job_id) AS total_salary_for_job
FROM employees e;

-- Copy one table structure and data to new table
CREATE TABLE employees_copy AS
SELECT * FROM employees;

-- Create a VIEW
CREATE VIEW employee_details AS
SELECT employees.employee_id, employees.first_name, employees.last_name, jobs.job_title, departments.department_name
FROM employees
JOIN jobs ON employees.job_id = jobs.job_id
JOIN departments ON employees.department_id = departments.department_id;

-- Create a stored procedure and call it
DELIMITER //

CREATE PROCEDURE GetEmployeeByDepartment(IN departmentName VARCHAR(50))
BEGIN
    SELECT * FROM employees
    WHERE department_id = (SELECT department_id FROM departments WHERE department_name = departmentName);
END //

DELIMITER ;

CALL GetEmployeeByDepartment('IT');

-- Create 3 triggers and use it, give examples in order to execute trigger

CREATE TABLE employee_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(255),
    log_date TIMESTAMP,
    employee_id INT
);

CREATE TRIGGER log_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
INSERT INTO employee_log (action, log_date, employee_id)
VALUES ('INSERT', NOW(), NEW.employee_id);

DELIMITER //
CREATE TRIGGER log_employee_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary <> OLD.salary THEN
        INSERT INTO employee_log (action, log_date, employee_id)
        VALUES ('UPDATE_SALARY', NOW(), NEW.employee_id);
    END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER log_employee_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_log (action, log_date, employeGetEmployeeByDepartmente_id)
    VALUES ('DELETE', NOW(), OLD.employee_id);
END;
//
DELIMITER ;

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, manager_id, department_id)
VALUES (300, 'John', 'Doe', 'john.doe@example.com', '2023-01-01', 6, 8000, 108, 10);

UPDATE employees SET salary = 9000 WHERE employee_id = 300;

DELETE FROM employees WHERE employee_id = 300;


USE HumanResources;

-- INSERT 3 tuples to different tables
INSERT INTO dependents(dependent_id, first_name, last_name, relationship, employee_id) 
VALUES (31, 'Alice', 'Gietz', 'Child', 206);

INSERT INTO jobs(job_id, job_title, min_salary, max_salary) 
VALUES (20, 'Data Analyst', 5000.00, 10000.00);

INSERT INTO locations(location_id, street_address, postal_code, city, state_province, country_id) 
VALUES (2800, '123 Main St', '12345', 'Anytown', 'AnyState', 'US');

-- INSERT 5 tuples to same table
INSERT INTO jobs(job_id, job_title, min_salary, max_salary) VALUES (21, 'Software Engineer', 6000.00, 12000.00),
                                                                   (22, 'Database Administrator', 7000.00, 13000.00),
                                                                   (23, 'Network Administrator', 6500.00, 12500.00),
                                                                   (24, 'UI/UX Designer', 5500.00, 11000.00),
                                                                   (25, 'Project Manager', 8000.00, 15000.00);

-- UPDATE 3 tuples in different tables
UPDATE employees SET salary = 25000.00 
WHERE employee_id = 100;

UPDATE jobs SET max_salary = 11000.00 
WHERE job_id = 20;

UPDATE locations SET postal_code = '54321' 
WHERE location_id = 2800;

-- DELETE 3 tuples in different tables
DELETE FROM dependents 
WHERE dependent_id = 31;

DELETE FROM jobs 
WHERE job_id = 24;

DELETE FROM locations 
WHERE location_id = 2800;

-- Add CHECK constraint
ALTER TABLE employees ADD CONSTRAINT chk_salary 
CHECK (salary > 0);

-- Create 3 queries with WHERE clause and comparison operators
SELECT * FROM employees 
WHERE salary > 12000;

SELECT * FROM jobs 
WHERE max_salary < 11000;

SELECT * FROM locations 
WHERE country_id = 'US';

-- Create 3 queries with WHERE clause and arithmetic operators
SELECT * FROM employees 
WHERE salary = (max_salary / 2);

SELECT * FROM jobs 
WHERE (max_salary - min_salary) >= 1.5 * min_salary;

SELECT * FROM employees 
WHERE salary > (min_salary + 2000);

-- Create 3 queries with WHERE clause and logical operators
SELECT * FROM employees 
WHERE hire_date > '1995-01-01' AND salary > 8000;

SELECT * FROM departments 
WHERE location_id = 1700 OR location_id = 1800;

SELECT * FROM employees 
WHERE salary < 6000 OR department_id = 5;

-- Create 3 queries with special operators (BETWEEN, IS NULL, LIKE, IN, EXISTS)
SELECT * FROM employees 
WHERE hire_date BETWEEN '1996-01-01' AND '1997-01-01';

SELECT * FROM employees 
WHERE manager_id IS NULL;

SELECT * FROM employees 
WHERE last_name LIKE '%an%';

SELECT * FROM countries 
WHERE country_id IN ('US', 'CA', 'UK');

SELECT * FROM employees 
WHERE EXISTS (SELECT 1 FROM dependents WHERE employee_id = employees.employee_id);

-- Create 3 queries with ORDER BY clause
SELECT * FROM employees 
ORDER BY hire_date DESC;

SELECT * FROM jobs 
ORDER BY min_salary;

SELECT * FROM locations 
ORDER BY country_id, state_province;

-- Create 3 queries with DISTINCT clause
SELECT DISTINCT job_id 
FROM employees;

SELECT DISTINCT department_name 
FROM departments;

SELECT DISTINCT country_name 
FROM countries;

-- Create 3 queries with String Functions
SELECT * FROM employees 
WHERE UPPER(last_name) = 'SMITH';

SELECT * FROM employees 
WHERE LOWER(first_name) = 'steven';

SELECT last_name || ', ' || first_name AS full_name FROM employees;

-- Create 3 queries with Numeric Functions
SELECT employee_id, salary, salary * 1.1 AS increased_salary 
FROM employees;

SELECT employee_id, salary, salary * 4 AS quarter_salary 
FROM employees;

SELECT employee_id, salary, salary * 12 AS annual_salary 
FROM employees;

-- Create 3 queries with Date Functions
SELECT * FROM employees 
WHERE EXTRACT(YEAR FROM hire_date) = 1997;

SELECT * FROM employees 
WHERE hire_date = CURRENT_DATE;

SELECT * FROM employees 
WHERE EXTRACT(MONTH FROM hire_date) = 1;

-- Create 3 queries with aggregate functions(COUNT, MIN, MAX, SUM, AVG)
SELECT department_id, COUNT(*) AS employee_count 
FROM employees GROUP BY department_id;

SELECT job_id, MIN(salary) AS min_salary, MAX(salary) AS max_salary, AVG(salary) AS avg_salary 
FROM employees GROUP BY job_id;

SELECT department_id, SUM(salary) AS total_salary 
FROM employees GROUP BY department_id;

-- Use LIMIT clause
SELECT * FROM employees 
ORDER BY employee_id LIMIT 5;

-- Use ROLLUP
SELECT department_id, SUM(salary) AS total_salary 
FROM employees GROUP BY ROLLUP(department_id);

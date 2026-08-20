create database foreign_keys_and_inner_joins;
use foreign_keys_and_inner_joins;
  -- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  -- Create Department Table
CREATE TABLE Department_8 (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create Employee Table
CREATE TABLE Employee_8 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department_8(dept_id)
);

-- Insert Data into Department
INSERT INTO Department_8 VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Marketing'),
(105, 'Sales');

-- Insert Data into Employee
INSERT INTO Employee_8 VALUES
(1, 'Rahul', 50000, 101),
(2, 'Sneha', 65000, 102),
(3, 'Amit', 70000, 102),
(4, 'Priya', 55000, 103),
(5, 'Kiran', 48000, NULL),
(6, 'Anjali', 62000, 105),
(7, 'Ravi', 58000, NULL);

-- **************************************************************************************************
-- inner join

SELECT 
    e.emp_name, d.dept_name
FROM
    Employee_8 e
        INNER JOIN
    Department_8 d ON e.dept_id = d.dept_id;

SELECT 
    e.emp_id, e.emp_name, d.dept_name
FROM
    Employee_8 e
        INNER JOIN
    Department_8 d ON e.dept_id = d.dept_id;

SELECT 
    e.emp_name, d.dept_name
FROM
    Employee_8 e
        INNER JOIN
    Department_8 d ON e.dept_id = d.dept_id
WHERE
    d.dept_name = 'IT';

SELECT 
    e.emp_name, e.salary, d.dept_name
FROM
    Employee_8 e
        INNER JOIN
    Department_8 d ON e.dept_id = d.dept_id
WHERE
    e.salary > 55000;

SELECT 
    d.dept_name, COUNT(e.emp_id) AS total_employees
FROM
    Employee_8 e
        INNER JOIN
    Department_8 d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- left join

SELECT 
    e.emp_name, d.dept_name
FROM
    Employee_8 e
        LEFT JOIN
    Department_8 d ON e.dept_id = d.dept_id;

SELECT 
    e.emp_name
FROM
    Employee_8 e
        LEFT JOIN
    Department_8 d ON e.dept_id = d.dept_id
WHERE
    d.dept_id IS NULL;

SELECT 
    e.emp_id, e.emp_name, d.dept_name
FROM
    Employee_8 e
        LEFT JOIN
    Department_8 d ON e.dept_id = d.dept_id;

SELECT 
    d.dept_name, e.emp_name
FROM
    Department_8 d
        LEFT JOIN
    Employee_8 e ON d.dept_id = e.dept_id;


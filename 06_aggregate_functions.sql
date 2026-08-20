create database aggregate_functions;
use aggregate_functions;
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(30),
    Salary DECIMAL(10 , 2 )
);
INSERT INTO Employee VALUES
(101, 'Alice', 'HR', 35000),
(102, 'Bob', 'IT', 50000),
(103, 'Charlie', 'Finance', 45000),
(104, 'David', 'IT', 60000),
(105, 'Eva', 'HR', 40000);


CREATE TABLE Stock (
    StockID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Quantity INT
);
INSERT INTO Stock VALUES
(1, 'Laptop', 25),
(2, 'Mouse', 150),
(3, 'Keyboard', 80),
(4, 'Monitor', 40),
(5, 'Printer', 15);


CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Marks INT
);
INSERT INTO Student VALUES
(1, 'Rahul', 85),
(2, 'Sneha', 92),
(3, 'Amit', 78),
(4, 'Priya', 88),
(5, 'Kiran', 95);
-- ***************************************************************************************
-- day 6
-- Aggregate Functions

SELECT 
    SUM(salary)
FROM
    employee;

SELECT 
    salary
FROM
    employee
WHERE
    salary < (SELECT 
            MAX(salary)
        FROM
            employee)
ORDER BY salary DESC
LIMIT 1;

SELECT 
    MIN(salary)
FROM
    employee;

SELECT 
    empname, salary
FROM
    employee
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employee);

SELECT 
    COUNT(*)
FROM
    employee;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Stock Queries
SELECT 
    COUNT(1)
FROM
    stock;

SELECT 
    SUM(quantity)
FROM
    stock
WHERE
    ProductName = 'Laptop';

SELECT 
    MAX(quantity)
FROM
    stock;

SELECT 
    MIN(quantity)
FROM
    stock;

SELECT 
    quantity, productname
FROM
    stock
WHERE
    quantity > (SELECT 
            AVG(quantity)
        FROM
            stock);

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- student queries 
SELECT 
    COUNT(- 1)
FROM
    student;

SELECT 
    MAX(Marks)
FROM
    student
WHERE
    Marks > 80;

SELECT 
    MIN(marks)
FROM
    student
WHERE
    marks > 50;

SELECT 
    AVG(marks)
FROM
    student
WHERE
    marks > 90;

SELECT 
    marks,
    (SELECT 
            SUM(marks)
        FROM
            student) AS sum_marks
FROM
    student
WHERE
    marks > 80;

SELECT 
    studentname, marks AS min_marks_student
FROM
    student
WHERE
    marks = (SELECT 
            MIN(marks) AS min_marks
        FROM
            student);

SELECT 
    StudentID, StudentName
FROM
    student
WHERE
    LENGTH(StudentName) > 4;


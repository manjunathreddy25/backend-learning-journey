create database day_4;
use day_4;


CREATE TABLE Employees (
    EmployeeName VARCHAR(100),
    EmployeeID INT PRIMARY KEY,
    Age INT,
    Salary DECIMAL(10 , 2 ),
    DeptID INT
);

CREATE TABLE Department (
    DeptID INT AUTO_INCREMENT PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);
 
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10 , 2 ),
    Category VARCHAR(50)
);
  
  insert into Employees
  values
  ('Naruto',101,25,25000,2),
  ('Sasuke',102,25,28000,1),
  ('Sakura',103,23,30000,5),
  ('Minato',104,20,50000,3),
  ('Shikamaru',105,27,40000,4),
  ('Tanjiro',106,18,32000,5),
  ('Inosuke',107,19,33000,2),
  ('Zenitsu',108,20,35000,4),
  ('Riyu',109,30,60000,5),
  ('Reingoku',110,35,85000,1);
  
  insert into Department(DeptName,Location)
  values
  ('IT','Hyderabad'),
  ('HR','Banglore'),
  ('BusinessControl','Mumbai'),
  ('Support','Pune'),
  ('Sales','Banglore');
  
  insert into Product
  values
  (1,'Laptop',85000,'Electronics'),
  (2,'Mouse',2500,'Electronics'),
  (3,'Phone',50000,'Electronics'),
  (4,'Bag',5000,'Accessories'),
  (5,'Notebook',100,'Stationery');
-- Day 4
-- Update Queries
UPDATE employees 
SET 
    salary = 55000
WHERE
    employeeid = 105;

UPDATE employees 
SET 
    salary = 55555,
    deptid = 1
WHERE
    employeeid = 101;

set sql_safe_updates = 0;
UPDATE employees 
SET 
    salary = salary + 2500
WHERE
    deptid = (SELECT 
            deptid
        FROM
            department
        WHERE
            deptname = 'IT');

UPDATE employees 
SET 
    salary = CASE
        WHEN age > 25 THEN salary + 10000
        ELSE salary + 5000
    END;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Delete Queries
DELETE FROM employees 
WHERE
    emp_id = 101;

DELETE FROM employees;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- soft delete
UPDATE employees 
SET 
    is_deleted = 1
WHERE
    emp_id = 101;

UPDATE employees 
SET 
    deleted_at = NOW()
WHERE
    emp_id = 101;

UPDATE employees 
SET 
    is_deleted = 1,
    deleted_at = NOW()
WHERE
    emp_id = 101;


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- String Functions 
SELECT 
    UPPER(employeename)
FROM
    employees;

SELECT 
    LOWER(location)
FROM
    department;

SELECT 
    CONCAT(employeename, ' ', employeeid) AS Name_ID
FROM
    employees;

SELECT 
    employeename, LENGTH(employeename)
FROM
    employees;

SELECT TRIM('   Backend   ');

SELECT LTRIM('   Java');

SELECT RTRIM('SQL   ');

SELECT 
    SUBSTRING(employeename, 1, 3) AS First_3_Letters
FROM
    employees;

SELECT 
    REPLACE(employeename, 'a', '@')
FROM
    employees
WHERE
    employeeid = 101;

SELECT 
    REVERSE(employeename)
FROM
    employees;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Example --
SELECT 
    UPPER(employeename)
FROM
    employees;

SELECT 
    UPPER(employeename) AS Name
FROM
    employees;

SELECT 
    UPPER(employeename)
FROM
    employees
WHERE
    deptid = 1;

-- Example End --


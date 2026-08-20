create database day_3;
use day_3;
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
  -- *******************************************************************************************************************
SELECT 
    *
FROM
    Employees;

SELECT 
    *
FROM
    Department;

SELECT 
    *
FROM
    Product;
    
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
-- 20 Filtering Queries
-- 1
SELECT 
    *
FROM
    Employees
WHERE
    Salary > 33000;
-- 2
SELECT 
    *
FROM
    Employees
WHERE
    Salary < 30500;
-- 3
SELECT 
    ProductName
FROM
    Product
WHERE
    Price BETWEEN 1000 AND 15000;
-- 4
SELECT 
    DeptName
FROM
    Department
WHERE
    Location IN ('Hyderabad' , 'Banglore');
-- 5
SELECT 
    EmployeeName
FROM
    employees
WHERE
    Age > 18 OR Age < 22;
-- 6
SELECT 
    EmployeeName, Salary
FROM
    employees
ORDER BY Salary DESC;
-- 7
-- set sql_safe_updates = 0;
UPDATE employees 
SET 
    Salary = 33000
WHERE
    EmployeeID = 108;
-- 8
SELECT DISTINCT
    Salary
FROM
    Employees
ORDER BY Salary DESC;
-- 9
SELECT 
    Salary, COUNT(Salary) AS repeated_salaries
FROM
    Employees
GROUP BY Salary
HAVING repeated_salaries > 1;
-- 10
SELECT 
    EmployeeName, Age, Salary
FROM
    Employees
WHERE
    Age > 25 AND Salary > 50000;
-- 11
SELECT 
    e.EmployeeName, d.DeptName, e.Salary
FROM
    Employees AS e
        JOIN
    Department AS d ON e.DeptID = d.DeptID;
-- 12
SELECT 
    EmployeeName
FROM
    Employees AS e
        JOIN
    Department AS d ON e.DeptID = d.DeptID
WHERE
    DeptName <> 'IT';
-- 13
SELECT 
    employeename AS Name, salary AS 'Monthly Salary'
FROM
    employees;
-- 14
SELECT 
    employeename, age
FROM
    employees
WHERE
    salary > 45000 AND age < 25;
-- 15
SELECT 
    MAX(Price) AS AvgPrice, Category
FROM
    product
GROUP BY Category
HAVING AvgPrice > 25000;
-- 16
SELECT 
    salary, employeename
FROM
    employees
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employees);
-- 17
SELECT 
    salary, employeename
FROM
    employees
WHERE
    salary > (SELECT 
            MIN(salary)
        FROM
            employees);
-- 18
SELECT 
    EmployeeName,
    Salary,
    (SELECT 
            DeptName
        FROM
            Department
        WHERE
            Department.DeptID = Employees.DeptID) AS DeptName
FROM
    Employees
WHERE
    DeptID = (SELECT 
            DeptID
        FROM
            Department
        WHERE
            DeptName = 'IT'); 

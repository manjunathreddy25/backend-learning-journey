create database day_7;
use day_7;
CREATE TABLE Employees_7 (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(30),
    Category VARCHAR(20),
    Salary DECIMAL(10,2),
    Age INT,
    Experience INT
);
INSERT INTO Employees_7 VALUES
(101,'Rahul','IT','Permanent',65000,28,4),
(102,'Priya','IT','Contract',45000,25,2),
(103,'Amit','HR','Permanent',50000,30,6),
(104,'Sneha','HR','Permanent',55000,29,5),
(105,'Kiran','Sales','Contract',40000,26,3),
(106,'Anjali','Sales','Permanent',70000,32,8),
(107,'Vijay','Finance','Permanent',80000,35,10),
(108,'Meena','Finance','Contract',42000,27,2),
(109,'Ravi','IT','Permanent',72000,31,7),
(110,'Pooja','Sales','Permanent',68000,30,6),
(111,'Arun','Finance','Permanent',75000,34,9),
(112,'Divya','HR','Contract',43000,24,1),
(113,'Nikhil','IT','Permanent',61000,29,5),
(114,'Neha','Sales','Contract',39000,23,1),
(115,'Suresh','Finance','Permanent',82000,38,12);

-- ************************************************************************************************
-- group by 
SELECT 
    COUNT(*) AS total_employees, Department
FROM
    employees_7
GROUP BY Department;

SELECT 
    Department, AVG(Salary) AS Avg_Salary
FROM
    employees_7
GROUP BY Department;

SELECT 
    Department, MAX(salary) AS max_salary
FROM
    employees_7
GROUP BY Department;

SELECT 
    department, MIN(salary) AS min_salary
FROM
    employees_7
GROUP BY department;

SELECT 
    department, SUM(salary) AS total_salary
FROM
    employees_7
GROUP BY department;

SELECT 
    COUNT(*) AS total_emps, category
FROM
    employees_7
GROUP BY Category;

SELECT 
    department, category, COUNT(*) AS total_emps
FROM
    employees_7
GROUP BY department , category;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- having

SELECT 
    Department, COUNT(*) AS TotalEmployees
FROM
    employees_7
GROUP BY Department
HAVING COUNT(*) > 3;

SELECT 
    department, AVG(salary) AS avg_salary
FROM
    employees_7
GROUP BY department
HAVING avg_salary > 60000;

SELECT 
    category, COUNT(*) AS emps
FROM
    employees_7
GROUP BY category
HAVING emps > 5;

SELECT 
    Department, SUM(Salary) AS TotalSalary
FROM
    Employees_7
GROUP BY Department
HAVING SUM(Salary) > 180000;

SELECT 
    Department, AVG(Age) AS AvgAge
FROM
    Employees_7
GROUP BY Department
HAVING AVG(Age) > 29;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- group by - having - order by 

SELECT 
    Department, AVG(Salary) AS AvgSalary
FROM
    Employees_7
GROUP BY Department
HAVING AVG(Salary) > 50000
ORDER BY AvgSalary DESC;


SELECT 
    Department, Category, COUNT(*) AS Employees
FROM
    Employees_7
GROUP BY Department , Category
HAVING COUNT(*) >= 2
ORDER BY Employees DESC;


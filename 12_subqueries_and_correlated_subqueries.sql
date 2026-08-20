create database day_12;
use day_12;

-- ===========================================================================================================================================================================
-- CREATE TABLES
-- =====================================

CREATE TABLE Sorcerers (
    SorcererID INT PRIMARY KEY,
    Name VARCHAR(50),
    Grade VARCHAR(20),
    Salary INT,
    TeamID INT
);

CREATE TABLE Teams (
    TeamID INT PRIMARY KEY,
    TeamName VARCHAR(50),
    Leader VARCHAR(50)
);

-- =====================================
-- INSERT DATA
-- =====================================

INSERT INTO Teams VALUES
(1,'Tokyo First Years','Gojo'),
(2,'Tokyo Second Years','Yaga'),
(3,'Kyoto School','Gakuganji');

INSERT INTO Sorcerers VALUES
(101,'Yuji Itadori','Grade 1',50000,1),
(102,'Megumi Fushiguro','Grade 1',65000,1),
(103,'Nobara Kugisaki','Grade 2',45000,1),
(104,'Satoru Gojo','Special Grade',120000,2),
(105,'Maki Zenin','Grade 1',70000,2),
(106,'Toge Inumaki','Grade 2',55000,2),
(107,'Panda','Grade 2',52000,2),
(108,'Yuta Okkotsu','Special Grade',110000,3),
(109,'Aoi Todo','Grade 1',75000,3),
(110,'Mai Zenin','Grade 3',40000,3);

-- ===========================================================================================================================================================================


-- Types of Subqueries

-- Scalar Subquery
-- Single Row Subquery
-- Multirow Subquery
-- Correlated Subqueries 
-- Derived Table Subquery 

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Scalar Subqueries
-- A scalar subquery returns one single value.

-- 1: Find sorcerers earning above average salary 
SELECT Name, Salary
FROM Sorcerers
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Sorcerers
);

-- 2: Find sorcerer with highest salary
SELECT Name, Salary
FROM Sorcerers
WHERE Salary =
(
    SELECT MAX(Salary)
    FROM Sorcerers
);

-- 3: Find sorcerers earning less than company average
SELECT Name, Salary
FROM Sorcerers
WHERE Salary <
(
    SELECT AVG(Salary)
    FROM Sorcerers
);

-- 4: Display every sorcerer with company average salary
SELECT 
Name,
Salary,
(
 SELECT AVG(Salary)
 FROM Sorcerers
) AS Company_Avg
FROM Sorcerers;

-- 5: Find the difference between salary and highest salary
SELECT 
Name,
Salary,
(
 SELECT MAX(Salary)
 FROM Sorcerers
)-Salary AS Difference
FROM Sorcerers;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Single Row Subqueries
-- Single row means: Subquery returns exactly one row.


-- 1: Find sorcerers having maximum salary
SELECT Name, Salary
FROM Sorcerers
WHERE Salary =
(
 SELECT MAX(Salary)
 FROM Sorcerers
);

-- 2: Find team of Gojo
SELECT TeamName
FROM Teams
WHERE TeamID =
(
 SELECT TeamID
 FROM Sorcerers
 WHERE Name='Satoru Gojo'
);


-- 3: Find sorcerers in Gojo's team
SELECT Name
FROM Sorcerers
WHERE TeamID =
(
 SELECT TeamID
 FROM Sorcerers
 WHERE Name='Satoru Gojo'
);


-- 4: Find grade of Yuji
SELECT Grade
FROM Sorcerers
WHERE (SorcererID,Name) =
(
 SELECT SorcererID,Name
 FROM Sorcerers
 WHERE Name= 'Satoru Gojo'
);


-- 5: Find leader of Yuta's team
SELECT Leader
FROM Teams
WHERE TeamID =
( 
 SELECT TeamID
 FROM Sorcerers
 WHERE Name='Yuta Okkotsu'
);
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Multiple Row Subqueries 
-- Returns many values.
-- Usually uses:
-- IN
-- ANY
-- ALL

-- 1: Find sorcerers from Tokyo teams
SELECT Name,TeamID
FROM Sorcerers
WHERE TeamID in
(
 SELECT TeamID
 FROM Teams
 WHERE TeamName LIKE 'Tokyo%'
);

-- 2: Find teams that have Special Grade sorcerers
SELECT TeamName
FROM Teams
WHERE TeamID IN
(
 SELECT TeamID
 FROM Sorcerers
 WHERE Grade='Special Grade'
);

-- 3: Find sorcerers whose salary matches any Grade 1 salary
SELECT Name,Salary
FROM Sorcerers
WHERE Salary IN
(
 SELECT Salary
 FROM Sorcerers
 WHERE Grade='Grade 1'
);

-- 4: Find sorcerers earning more than ANY Kyoto sorcerer
SELECT Name,Salary
FROM Sorcerers
WHERE Salary >
ANY
(
 SELECT Salary
 FROM Sorcerers
 WHERE TeamID=3
);


-- 5: Find sorcerers earning more than ALL Grade 2 sorcerers
SELECT Name,Salary
FROM Sorcerers
WHERE Salary >
ALL
(
 SELECT Salary
 FROM Sorcerers
 WHERE Grade='Grade 2'
);

                                          
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 4. Correlated Subqueries 
-- The inner query depends on the outer query.

-- 1: Sorcerers earning above their team average
SELECT 
Name,
Salary,
TeamID
FROM Sorcerers s
WHERE Salary >
(
 SELECT AVG(Salary)
 FROM Sorcerers
 WHERE TeamID=s.TeamID
);

-- 2: Find highest paid sorcerer in each team
SELECT Name,Salary,TeamID
FROM Sorcerers s
WHERE Salary =
(
 SELECT MAX(Salary)
 FROM Sorcerers
 WHERE TeamID=s.TeamID
);

-- 3: Find lowest paid sorcerer in each team
SELECT Name,Salary,TeamID
FROM Sorcerers s
WHERE Salary =
(
 SELECT MIN(Salary)
 FROM Sorcerers
 WHERE TeamID=s.TeamID
);

-- 4: Find sorcerers whose salary is greater than team average
SELECT Name
FROM Sorcerers s
WHERE Salary >
(
 SELECT AVG(Salary)
 FROM Sorcerers
 WHERE TeamID=s.TeamID
);

-- 5: Find teams having more than 3 sorcerers
SELECT TeamName
FROM Teams t
WHERE
(
 SELECT COUNT(*)
 FROM Sorcerers s
 WHERE s.TeamID=t.TeamID
)>3;


-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 5. Derived Table / FROM Subquery 
-- The subquery creates a temporary table.

-- 1: Find team average salaries
SELECT *
FROM
(
 SELECT TeamID,
 AVG(Salary) AS AvgSalary
 FROM Sorcerers
 GROUP BY TeamID
) AS TeamSalary;

-- 2: Find team with highest average salary
SELECT *
FROM
(
 SELECT TeamID,
 AVG(Salary) AvgSalary
 FROM Sorcerers
 GROUP BY TeamID
) x
WHERE AvgSalary =
(
 SELECT MAX(AvgSalary)
 FROM
 (
  SELECT AVG(Salary) AvgSalary
  FROM Sorcerers
  GROUP BY TeamID
 ) y
);

-- 3: Count sorcerers in each team
SELECT *
FROM
(
 SELECT TeamID,
 COUNT(*) AS TotalSorcerers
 FROM Sorcerers
 GROUP BY TeamID
) x;

-- 4: Show team name with average salary
SELECT 
t.TeamName,
x.AvgSalary
FROM Teams t
JOIN
(
 SELECT TeamID,
 AVG(Salary) AvgSalary
 FROM Sorcerers
 GROUP BY TeamID
) x
ON t.TeamID=x.TeamID;


-- 5: Find teams whose average salary is above company average
SELECT *
FROM
(
 SELECT TeamID,
 AVG(Salary) AvgSalary
 FROM Sorcerers
 GROUP BY TeamID
) x
WHERE AvgSalary >
(
 SELECT AVG(Salary)
 FROM Sorcerers
);



-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Subqueries based on location


-- 1. WHERE Subquery
SELECT
    Name,
    Salary
FROM Sorcerers
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Sorcerers
);

-- 2. SELECT Subquery
SELECT
    Name,
    Salary,
    (
        SELECT AVG(Salary)
        FROM Sorcerers
    ) AS CompanyAverage
FROM Sorcerers;

-- 3. FROM Subquery
SELECT *
FROM
(
    SELECT
        TeamID,
        AVG(Salary) AS AvgSalary
    FROM Sorcerers
    GROUP BY TeamID
) AS TeamAverage;

-- 4. EXISTS Subquery
SELECT
    TeamName
FROM Teams t
WHERE EXISTS
(
    SELECT 1
    FROM Sorcerers s
    WHERE s.TeamID=t.TeamID
);

-- 5. NOT EXISTS
SELECT
    TeamName
FROM Teams t
WHERE NOT EXISTS
(
    SELECT 1
    FROM Sorcerers s
    WHERE s.TeamID=t.TeamID
);
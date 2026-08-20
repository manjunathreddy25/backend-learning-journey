create database outer_cross_and_self_joins;
 use outer_cross_and_self_joins;
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE managers (
    manager_id INT PRIMARY KEY,
    manager_name VARCHAR(50),
    department VARCHAR(30)
);

CREATE TABLE developers (
    developer_id INT PRIMARY KEY,
    developer_name VARCHAR(50),
    technology VARCHAR(30),
    salary DECIMAL(10,2),
    manager_id INT
);

INSERT INTO managers VALUES
(1,'Rahul Sharma','Java'),
(2,'Priya Reddy','Python'),
(3,'Kiran Kumar','Data Engineering'),
(4,'Sneha Patel','DevOps'),
(5,'Arun Rao','Testing');

INSERT INTO developers VALUES
(101,'Amit','Java',65000,1),
(102,'Neha','Spring Boot',70000,1),
(103,'Vijay','Python',68000,2),
(104,'Anjali','Django',72000,2),
(105,'Rakesh','Spark',85000,3),
(106,'Suresh','AWS',75000,4),
(107,'Divya','React',60000,NULL),
(108,'Keerthi','Automation',58000,6);
-- *****************************************************************************************
SELECT 
    *
FROM
    managers;

SELECT 
    *
FROM
    developers;
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Right Join --

SELECT 
    m.department, d.manager_id
FROM
    managers AS m
        RIGHT JOIN
    developers AS d ON m.manager_id = d.manager_id;

SELECT 
    m.manager_name, d.technology
FROM
    managers AS m
        RIGHT JOIN
    developers AS d ON m.manager_id = d.manager_id;

SELECT 
    d.salary, m.department
FROM
    managers AS m
        RIGHT JOIN
    developers AS d ON m.manager_id = d.manager_id;

SELECT 
    d.developer_id, m.manager_name
FROM
    managers AS m
        RIGHT JOIN
    developers AS d ON m.manager_id = d.manager_id;

SELECT 
    d.developer_name, m.manager_name, m.department
FROM
    managers AS m
        RIGHT JOIN
    developers AS d ON m.manager_id = d.manager_id
WHERE
    m.department IS NOT NULL;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

-- (cross join (It is cartesian product example: table A * table B)) --
SELECT 
    *
FROM
    managers m
        CROSS JOIN
    developers d;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Full Join -- 

SELECT 
    m.manager_id, m.manager_name, d.developer_name
FROM
    managers m
        LEFT JOIN
    developers d ON m.manager_id = d.manager_id 
UNION SELECT 
    m.manager_id, m.manager_name, d.developer_name
FROM
    managers m
        RIGHT JOIN
    developers d ON m.manager_id = d.manager_id;



SELECT 
    m.manager_id, m.manager_name, d.developer_name
FROM
    managers m
        LEFT JOIN
    developers d ON m.manager_id = d.manager_id
WHERE
    m.manager_id IS NULL
        OR d.manager_id IS NULL 
UNION SELECT 
    m.manager_id, m.manager_name, d.developer_name
FROM
    managers m
        RIGHT JOIN
    developers d ON m.manager_id = d.manager_id
WHERE
    m.manager_id IS NULL
        OR d.manager_id IS NULL;


SELECT 
    m.department, m.manager_name, d.developer_name
FROM
    managers AS m
        LEFT JOIN
    developers AS d ON m.manager_id = d.manager_id 
UNION SELECT 
    m.department, m.manager_name, d.developer_name
FROM
    managers AS m
        RIGHT JOIN
    developers AS d ON m.manager_id = d.manager_id;


SELECT 
    m.manager_name, d.developer_name, d.technology
FROM
    managers AS m
        LEFT JOIN
    developers AS d ON m.manager_id = d.manager_id 
UNION SELECT 
    m.manager_name, d.developer_name, d.technology
FROM
    managers AS m
        RIGHT JOIN
    developers AS d ON m.manager_id = d.manager_id;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Self join (employees_9)-- 

SELECT 
    *
FROM
    employees_9;

SELECT 
    e.emp_name AS Employee, m.emp_name AS Manager
FROM
    employees_9 e
        LEFT JOIN
    employees_9 m ON e.manager_id = m.emp_id;

SELECT 
    e.emp_name
FROM
    employees_9 e
        LEFT JOIN
    employees_9 m ON e.manager_id = m.emp_id
WHERE
    m.emp_id IS NULL;

SELECT 
    e.emp_name
FROM
    employees_9 e
        JOIN
    employees_9 m ON e.manager_id = m.emp_id
WHERE
    m.emp_name = 'Priya';

SELECT 
    e.emp_name, e.designation, m.emp_name AS Manager
FROM
    employees_9 e
        LEFT JOIN
    employees_9 m ON e.manager_id = m.emp_id;


SELECT 
    m.emp_name AS manager, COUNT(*) AS employees_count
FROM
    employees_9 AS e
        JOIN
    employees_9 AS m ON e.manager_id = m.emp_id
GROUP BY m.emp_name; 

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- task --
select m.manager_name,d.developer_name
from managers as m
left join developers as d 
on m.manager_id = d.manager_id

union 

select m.manager_name,d.developer_name
from managers as m
right join developers as d 
on m.manager_id = d.manager_id;
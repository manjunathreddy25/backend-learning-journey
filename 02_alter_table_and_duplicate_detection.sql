create database alter_table_and_duplicate_detection;
use alter_table_and_duplicate_detection;
CREATE TABLE TeamMembers (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Domain VARCHAR(50)
);

insert into TeamMembers
(EmployeeName,Domain
)
values
('Praveen Kumar','Backend'),
('Manjunath Reddy','Backend'),
('Hareesh Reddy','Backend'),
('Surekha','Frontend'),
('Uday Kiran',Null),
('Pavan Amara','Frontend');

SELECT 
    *
FROM
    TeamMembers;

SELECT 
    Domain, COUNT(*)
FROM
    TeamMembers
GROUP BY Domain;


alter table TeamMembers
rename column EmployeeName to EmployeeNames;

describe TeamMembers;

SELECT 
    EmployeeNames, Domain, COUNT(*)
FROM
    TeamMembers
GROUP BY EmployeeNames , Domain
HAVING COUNT(*) > 1;

SELECT 
    t1.*
FROM
    TeamMembers t1
        INNER JOIN
    TeamMembers t2 ON t1.EmployeeNames = t2.EmployeeNames
        AND ((t1.Domain = t2.Domain)
        OR (t1.Domain IS NULL AND t2.Domain IS NULL))
        AND t1.ID > t2.ID;
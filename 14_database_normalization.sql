create database database_normalization;
use database_normalization;

-- 1NF  
-- Each column should contain only one value.
CREATE TABLE employee_skills_bad (
    emp_id INT,
    emp_name VARCHAR(50),
    skills VARCHAR(100)
);
INSERT INTO employee_skills_bad VALUES
(101,'John','SQL,Python,Power BI'),
(102,'David','Excel,Tableau'),
(103,'Manjunath','Python,SQL');

SELECT *
FROM employee_skills_bad
WHERE skills LIKE '%Python%';


-- Coverting Into 1NF
CREATE TABLE employee_skills (
    emp_id INT,
    emp_name VARCHAR(50),
    skill VARCHAR(50)
);
INSERT INTO employee_skills VALUES
(101,'John','SQL'),
(101,'John','Python'),
(101,'John','Power BI'),
(102,'David','Excel'),
(102,'David','Tableau'),
(103,'Manjunath','Python'),
(103,'Manjunath','SQL');


-- Find SQL developers:
SELECT *
FROM employee_skills
WHERE skill='SQL';

-- ==========================================================================================================================================================================


-- 2NF
-- Does every column depend on the WHOLE key?
-- Does every column need BOTH key columns?
CREATE TABLE player_tournament_bad(
    player_id INT PRIMARY KEY,
    tournament_id VARCHAR(10),
    player_name VARCHAR(50),
    tournament_name VARCHAR(50)
);
INSERT INTO player_tournament_bad VALUES
(1,'T1','Jonathan','PMGC'),  -- duplicate row
(2,'T1','Scout','PMGC'),     -- duplicate row
(3,'T2','Mortal','PMSL'),
(4,'T2','Snax','PMSL'),
(5,'T3','Goblin','BGIS');

-- Coverting Into 2NF
CREATE TABLE players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(50)
);
INSERT INTO players VALUES
(1,'Jonathan'),
(2,'Scout'),
(3,'Mortal'),
(4,'Snax'),
(5,'Goblin');

CREATE TABLE tournaments (
    tournament_id VARCHAR(10) PRIMARY KEY,
    tournament_name VARCHAR(50)
);
INSERT INTO tournaments VALUES
('T1','PMGC'),
('T2','PMSL'),
('T3','BGIS');


CREATE TABLE participation (
    player_id INT,
    tournament_id VARCHAR(10)
);
INSERT INTO participation VALUES
(1,'T1'),
(2,'T1'),
(3,'T2'),
(4,'T2'),
(5,'T3');

-- ==========================================================================================================================================================================

-- 3NF
-- Is one non-key column determining another non-key column?
CREATE TABLE players_bad (
    player_id INT,
    player_name VARCHAR(50),
    team_id VARCHAR(10),
    team_name VARCHAR(50)
);
INSERT INTO players_bad VALUES
(1,'Jonathan','T1','GodLike'),
(2,'Neyoo','T1','GodLike'),
(3,'Scout','T2','XSpark'),
(4,'Mortal','T3','Soul');



-- Covert Into 3NF
CREATE TABLE players_3 (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(50),
    team_id VARCHAR(10)
);
INSERT INTO players_3 VALUES
(1,'Jonathan','T1'),
(2,'Neyoo','T1'),
(3,'Scout','T2'),
(4,'Mortal','T3');

CREATE TABLE teams (
    team_id VARCHAR(10) PRIMARY KEY,
    team_name VARCHAR(50)
);
INSERT INTO teams VALUES
('T1','GodLike'),
('T2','XSpark'),
('T3','Soul');


-- another example which not solving 3nf problem but solved 2nf 
CREATE TABLE employee_bad (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id VARCHAR(10),
    department_name VARCHAR(50)
);
INSERT INTO employee_bad VALUES
(101,'John','D1','IT'),
(102,'David','D2','HR'),
(103,'Ravi','D1','IT'),
(104,'Kiran','D3','Finance'),
(105,'Arun','D2','HR');


-- Convert Into 3NF
CREATE TABLE departments (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(50)
);
INSERT INTO departments VALUES
('D1','IT'),
('D2','HR'),
('D3','Finance');


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id VARCHAR(10),
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);
INSERT INTO employees VALUES
(101,'John','D1'),
(102,'David','D2'),
(103,'Ravi','D1'),
(104,'Kiran','D3'),
(105,'Arun','D2');

-- query
SELECT e.employee_id,
       e.employee_name,
       d.department_id,
       d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- ==========================================================================================================================================================================

-- UNF (Unnormalized Table)
CREATE TABLE demon_slayer_unf (
    slayer_id INT,
    slayer_name VARCHAR(50),
    mission_id VARCHAR(10),
    mission_name VARCHAR(50),
    breathing_styles VARCHAR(100),
    hashira_id VARCHAR(10),
    hashira_name VARCHAR(50)
);
INSERT INTO demon_slayer_unf VALUES
(101,'Tanjiro','M1','Spider Mountain','Water,Hinokami','H1','Giyu'),
(102,'Zenitsu','M1','Spider Mountain','Thunder','H2','Tengen'),
(103,'Inosuke','M2','Mugen Train','Beast','H2','Tengen'),
(104,'Kanao','M2','Mugen Train','Flower','H3','Shinobu');


-- 1. Convert to 1NF
CREATE TABLE demon_slayer_1nf (
    slayer_id INT,
    slayer_name VARCHAR(50),
    mission_id VARCHAR(10),
    mission_name VARCHAR(50),
    breathing_style VARCHAR(50),
    hashira_id VARCHAR(10),
    hashira_name VARCHAR(50)
);
INSERT INTO demon_slayer_1nf VALUES
(101,'Tanjiro','M1','Spider Mountain','Water','H1','Giyu'),
(101,'Tanjiro','M1','Spider Mountain','Hinokami','H1','Giyu'),
(102,'Zenitsu','M1','Spider Mountain','Thunder','H2','Tengen'),
(103,'Inosuke','M2','Mugen Train','Beast','H2','Tengen'),
(104,'Kanao','M2','Mugen Train','Flower','H3','Shinobu');

-- 2. Convert to 2NF
-- Slayers
CREATE TABLE slayers (
    slayer_id INT PRIMARY KEY,
    slayer_name VARCHAR(50),
    hashira_id VARCHAR(10),
    hashira_name VARCHAR(50)
);
INSERT INTO slayers VALUES
(101,'Tanjiro','H1','Giyu'),
(102,'Zenitsu','H2','Tengen'),
(103,'Inosuke','H2','Tengen'),
(104,'Kanao','H3','Shinobu');

-- Missions
CREATE TABLE missions (
    mission_id VARCHAR(10) PRIMARY KEY,
    mission_name VARCHAR(50)
);
INSERT INTO missions VALUES
('M1','Spider Mountain'),
('M2','Mugen Train');

-- Slayer Missions
CREATE TABLE slayer_missions (
    slayer_id INT,
    mission_id VARCHAR(10)
);
INSERT INTO slayer_missions VALUES
(101,'M1'),
(102,'M1'),
(103,'M2'),
(104,'M2');

-- Breathing Styles
CREATE TABLE breathing_styles (
    slayer_id INT,
    breathing_style VARCHAR(50)
);
INSERT INTO breathing_styles VALUES
(101,'Water'),
(101,'Hinokami'),
(102,'Thunder'),
(103,'Beast'),
(104,'Flower');


-- 3. Convert to 3NF
CREATE TABLE slayers (
    slayer_id INT PRIMARY KEY,
    slayer_name VARCHAR(50),
    hashira_id VARCHAR(10)
);
INSERT INTO slayers VALUES
(101,'Tanjiro','H1'),
(102,'Zenitsu','H2'),
(103,'Inosuke','H2'),
(104,'Kanao','H3');
CREATE TABLE hashiras (
    hashira_id VARCHAR(10) PRIMARY KEY,
    hashira_name VARCHAR(50)
);
INSERT INTO hashiras VALUES
('H1','Giyu'),
('H2','Tengen'),
('H3','Shinobu');

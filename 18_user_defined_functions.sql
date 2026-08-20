create database user_defined_functions;
use user_defined_functions;
-- ==========================================================================================================================================================================

CREATE TABLE ai_projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    ai_category VARCHAR(50),
    programming_language VARCHAR(50),
    project_manager VARCHAR(50),
    team_size INT,
    status VARCHAR(20),
    budget DECIMAL(10,2),
    start_date DATE,
    expected_end_date DATE
);
INSERT INTO ai_projects
(project_name, ai_category, programming_language, project_manager, team_size, status, budget, start_date, expected_end_date)
VALUES
('MedScan AI', 'Healthcare', 'Python', 'Rahul Sharma', 10, 'Completed', 850000.00, '2025-01-10', '2025-08-30'),

('ChatAssist Pro', 'Chatbot', 'Python', 'Sneha Reddy', 8, 'In Progress', 450000.00, '2025-05-01', '2025-11-15'),

('Vision Detect', 'Computer Vision', 'Python', 'Amit Kumar', 12, 'In Progress', 1200000.00, '2025-02-20', '2025-12-20'),

('VoiceBot AI', 'Speech Recognition', 'Python', 'Priya Singh', 9, 'Planning', 600000.00, '2025-09-01', '2026-03-01'),

('CodeGen AI', 'Code Generation', 'Java', 'Arjun Patel', 14, 'Completed', 1500000.00, '2024-06-15', '2025-04-30'),

('Smart Recruiter', 'HR Automation', 'Java', 'Megha Rao', 7, 'Completed', 700000.00, '2024-09-10', '2025-03-15'),

('Finance Predictor', 'Finance', 'Python', 'Kiran Verma', 11, 'In Progress', 950000.00, '2025-03-01', '2026-01-15'),

('Legal AI Assistant', 'Legal Tech', 'C#', 'Neha Gupta', 6, 'Planning', 500000.00, '2025-10-01', '2026-05-30'),

('EduTutor AI', 'Education', 'Python', 'Rakesh Naidu', 9, 'Completed', 800000.00, '2024-07-20', '2025-02-28'),

('AgriVision', 'Agriculture', 'Python', 'Pooja Rani', 8, 'Testing', 650000.00, '2025-04-15', '2025-12-10');

-- ==========================================================================================================================================================================
-- 

-- User Defined Functions!
-- Get Total Budget by Status
delimiter //
create function GetProjectBudget(p_status varchar(30))
returns decimal(10,2)
READS SQL DATA
begin 
      declare total decimal(10,2);
      
      select sum(budget)
      into total
      from ai_projects
      where status = p_status;
      
      return total;
end //
delimiter ;
SELECT DISTINCT
    status, GETPROJECTBUDGET(status) AS total_budget
FROM
    ai_projects;
SHOW CREATE FUNCTION GetProjectBudget;
DROP FUNCTION GetProjectBudget;
-- ---------------------------------------------------------------------------------------------
-- Get Project Budget by Project ID
DELIMITER //

CREATE function ProjectBudget(p_prjct_id int)
returns int
READS SQL DATA
BEGIN
	declare total int;
    
    select budget
    into total 
    from ai_projects
    where project_id = p_prjct_id;
    
    return total;

END //

DELIMITER ;

select project_name,ProjectBudget(project_id) as budget
from ai_projects;
-- ------------------------------------------------------------------------------------
-- Get Total Budget by Programming Language
DELIMITER //

CREATE function ProgrammingBudget(plb varchar(50))
returns int
reads sql data
BEGIN

      declare total int;
      
      select sum(budget)
      into total
      from ai_projects
      where programming_language = plb;
      
      return total;

END //

DELIMITER ;
select distinct programming_language,ProgrammingBudget(programming_language) as budget
from ai_projects;
-- -------------------------------------------------------------------------------------------
-- Display projects whose budget is greater than $800,000.
-- using where 

DELIMITER //

CREATE function highest_budgets(p_id int)
returns int
reads sql data
BEGIN

    declare total int;
    
    select budget
    into total
    from ai_projects
    where project_id = p_id;
    
    return total;

END //

DELIMITER ;

select project_name,highest_budgets(project_id) as highest_budgets
from ai_projects
where highest_budgets(project_id) > 800000;
-- ----------------------------------------------------------------------------------
-- Using CASE
DELIMITER //

CREATE function budget_declaration(p_id int)
returns int
reads sql data
BEGIN

    declare total int;
    
    select budget
    into total
    from ai_projects
    where project_id = p_id;
    
    return total;

END //

DELIMITER ;

select project_name,budget, 
       case 
           when budget_declaration(project_id) > 800000 then 'High'
           when budget_declaration(project_id) between  500000 and  800000 then 'Medium'
           else  'Low'
           end as Budget_Status
from ai_projects;
-- -----------------------------------------------------------------------------------------------------------
-- Using GroupBy & Having
DELIMITER //

CREATE FUNCTION ai_category_budget(p_project_id INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total_budget DECIMAL(10,2);

    SELECT budget
    INTO total_budget
    FROM ai_projects
    WHERE project_id = p_project_id;

    RETURN IFNULL(total_budget, 0);

END //

DELIMITER ;

SELECT ai_category,
       SUM(ai_category_budget(project_id)) AS Total_Budget
FROM ai_projects
GROUP BY ai_category
HAVING SUM(ai_category_budget(project_id)) > 1000000;
-- -----------------------------------------------------------------------------------------------
-- Joins
CREATE TABLE project_clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT,
    client_name VARCHAR(100),
    country VARCHAR(50),
    FOREIGN KEY (project_id) REFERENCES ai_projects(project_id)
);
INSERT INTO project_clients(project_id, client_name, country)
VALUES
(1,'Apollo Hospitals','India'),
(2,'Google','USA'),
(3,'Tesla','USA'),
(4,'Microsoft','Canada'),
(5,'Infosys','India'),
(6,'Amazon','USA'),
(7,'ICICI Bank','India'),
(8,'IBM','USA'),
(9,'BYJU''S','India'),
(10,'John Deere','USA');

DELIMITER //

CREATE function project_description(p_id int)
returns int 
reads sql data
BEGIN

    declare total int;
    
    select budget
    into total 
    from ai_projects
    where project_id = p_id;
    
    return total;

END //

DELIMITER ;

SELECT p.project_name,
       c.client_name,
       ProjectBudget(p.project_id) AS Budget
FROM ai_projects p
INNER JOIN project_clients c
ON p.project_id = c.project_id;

-- -----------------------------------------------------------------------------------------
-- Funtion With Subquery
DELIMITER //

CREATE function budget_analysis(p_id int)
returns int
reads sql data

BEGIN

    declare total int;
    
    select budget
    into total
    from ai_projects
    where project_id = p_id;
    
    return total;

END //

DELIMITER ;

select project_name as ProjectName,
       budget_analysis(project_id) as Budget
from ai_projects
where budget_analysis(project_id) > 
( select avg(budget)
  from ai_projects
);

-- ------------------------------------------------------------------------------------
-- Budget increment calculation
DELIMITER //

CREATE FUNCTION FinalBudget(p_id INT)
RETURNS DECIMAL(10,2)
READS SQL DATA

BEGIN

    DECLARE total DECIMAL(10,2);

    SELECT budget
    INTO total
    FROM ai_projects
    WHERE project_id = p_id;

    IF total <= 1000000 THEN
        RETURN total + (total * 0.05);
    ELSE
        RETURN total;
    END IF;

END //

DELIMITER ;
SELECT project_name,
       budget AS Original_Budget,
       FinalBudget(project_id) AS Final_Budget
FROM ai_projects;
-- ---------------------------------------------------------------------------------------
-- Risk Level Calculation
DELIMITER //

CREATE FUNCTION ProjectRisk(p_id INT)
RETURNS VARCHAR(20)
READS SQL DATA

BEGIN

    DECLARE total DECIMAL(10,2);
    DECLARE risk VARCHAR(20);

    SELECT budget
    INTO total
    FROM ai_projects
    WHERE project_id = p_id;

    IF total > 1500000 THEN
        SET risk = 'High Risk';
    ELSEIF total BETWEEN 1000000 AND 1500000 THEN
        SET risk = 'Medium Risk';
    ELSE
        SET risk = 'Low Risk';
    END IF;

    RETURN risk;

END //

DELIMITER ;
SELECT project_name,
       ProjectRisk(project_id) AS Risk_Level
FROM ai_projects;
-- ----------------------------------------------------------------------------------------
-- Project Completion Reward
DELIMITER //

CREATE FUNCTION ProjectReward(p_id INT)
RETURNS INT
READS SQL DATA

BEGIN

    DECLARE total DECIMAL(10,2);
    DECLARE p_status VARCHAR(20);
    DECLARE reward INT;

    SELECT budget, status
    INTO total, p_status
    FROM ai_projects
    WHERE project_id = p_id;

    IF p_status = 'Completed' THEN

        IF total > 1000000 THEN
            SET reward = 50000;
        ELSE
            SET reward = 25000;
        END IF;

    ELSEIF p_status = 'Testing' THEN
        SET reward = 10000;

    ELSE
        SET reward = 0;
    END IF;

    RETURN reward;

END //

DELIMITER ;
SELECT project_name,
       ProjectReward(project_id) AS Reward
FROM ai_projects;

-- **************************************************************************************
-- Modify SQL DATA
DELIMITER //

CREATE FUNCTION ChangeStatus(p_id INT)
RETURNS VARCHAR(20)
MODIFIES SQL DATA
BEGIN

    UPDATE ai_projects
    SET status = 'Completed'
    WHERE project_id = p_id;

    RETURN 'Updated';

END //

DELIMITER ;
select ChangeStatus(5);
create database day_21;
use day_21;

-- ***************************************************************************************************************************************************************************

CREATE TABLE candidates (
    candidate_id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    position_applied VARCHAR(50),
    experience_years INT,
    skills VARCHAR(100),
    expected_salary DECIMAL(10,2),
    application_date DATE,
    interview_status VARCHAR(30),
    recruiter_name VARCHAR(100)
);
INSERT INTO candidates
(candidate_name,email,phone,position_applied,experience_years,skills,expected_salary,application_date,interview_status,recruiter_name)
VALUES
('Rahul Sharma','rahul@gmail.com','9876543210','Java Developer',3,'Java,SQL',650000,'2025-01-10','Selected','Priya Reddy'),

('Sneha Reddy','sneha@gmail.com','9876543211','Python Developer',2,'Python,SQL',550000,'2025-02-15','Interview Scheduled','Amit Kumar'),

('Kiran Verma','kiran@gmail.com','9876543212','Data Analyst',4,'SQL,Power BI',700000,'2025-03-20','Selected','Priya Reddy'),

('Neha Gupta','neha@gmail.com','9876543213','Frontend Developer',1,'HTML,CSS,JavaScript',450000,'2025-04-05','Rejected','Megha Rao'),

('Arjun Patel','arjun@gmail.com','9876543214','Backend Developer',5,'Java,Spring Boot',900000,'2025-05-18','Interview Scheduled','Amit Kumar'),

('Pooja Singh','pooja@gmail.com','9876543215','Python Developer',3,'Python,Django',620000,'2025-06-01','Selected','Priya Reddy'),

('Rakesh Naidu','rakesh@gmail.com','9876543216','Data Scientist',4,'Python,ML',950000,'2025-06-25','Offer Released','Sneha Sharma'),

('Anjali Rao','anjali@gmail.com','9876543217','QA Engineer',2,'Manual Testing',500000,'2025-07-10','Interview Scheduled','Megha Rao'),

('Vikas Kumar','vikas@gmail.com','9876543218','DevOps Engineer',6,'AWS,Docker',1100000,'2025-07-20','Selected','Amit Kumar'),

('Meena Joshi','meena@gmail.com','9876543219','Business Analyst',3,'SQL,Excel',680000,'2025-08-01','Applied','Sneha Sharma');

-- **************************************************************************************************************************************************************************

-- Creating Indexes on Frequently Searched Columns!
CREATE INDEX idx_recruiter
ON candidates(recruiter_name);

CREATE INDEX idx_position
ON candidates(position_applied);

CREATE INDEX idx_application_date
ON candidates(application_date);

SELECT *
FROM candidates
WHERE recruiter_name='Priya Reddy';


-- Avoid SELECT * As much as possible!
SELECT *
FROM candidates;   -- bad practice

SELECT
candidate_name,
position_applied
FROM candidates; -- good practice

-- Write Index-Friendly WHERE Conditions!
CREATE INDEX idx_date
ON candidates(application_date);

SELECT *
FROM candidates
WHERE application_date
BETWEEN '2025-01-01'
AND '2025-06-30';

-- Avoid Wrapping Indexed Columns in Functions!

SELECT *
FROM candidates
WHERE YEAR(application_date)=2025;  -- Bad Query
SELECT *
FROM candidates
WHERE application_date
BETWEEN '2025-01-01'
AND '2025-12-31';  -- Good Query

SELECT *
FROM candidates
WHERE UPPER(recruiter_name)='PRIYA REDDY';  -- Bad query
SELECT *
FROM candidates
WHERE recruiter_name='Priya Reddy'; -- Good query

-- Use LIMIT

SELECT *
FROM candidates; -- bad 

SELECT *
FROM candidates
LIMIT 5;  -- good


-- Checking Execution Plan using EXPLAIN!
SELECT *
FROM candidates
WHERE recruiter_name='Priya Reddy';  -- bad 

EXPLAIN
SELECT *
FROM candidates
WHERE recruiter_name='Priya Reddy';  -- good

CREATE INDEX idx_recruiter
ON candidates(recruiter_name);
EXPLAIN
SELECT *
FROM candidates
WHERE recruiter_name='Priya Reddy';

-- Optimize JOIN
CREATE TABLE interviews
(
    interview_id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT,
    interview_round VARCHAR(30),
    interviewer_name VARCHAR(100),
    interview_date DATE,
    result VARCHAR(20),

    FOREIGN KEY(candidate_id)
    REFERENCES candidates(candidate_id)
);
INSERT INTO interviews
(candidate_id, interview_round, interviewer_name, interview_date, result)
VALUES
(1,'HR','Priya Menon','2025-01-18','Pass'),
(2,'Technical','Rajesh Kumar','2025-02-22','Pending'),
(3,'Manager','Anita Sharma','2025-03-28','Pass'),
(4,'Technical','Suresh Reddy','2025-04-12','Fail'),
(5,'HR','Kiran Rao','2025-05-25','Pending'),
(6,'Technical','Amit Verma','2025-06-08','Pass'),
(7,'Manager','Sneha Gupta','2025-06-30','Pass'),
(8,'Technical','Rahul Singh','2025-07-18','Pending'),
(9,'HR','Neha Patel','2025-07-28','Pass'),
(10,'Screening','Vijay Kumar','2025-08-03','Pending');

explain
SELECT
c.candidate_name,
i.result
FROM candidates c
JOIN interviews i
ON c.candidate_name = i.interviewer_name; -- bad

explain
SELECT
c.candidate_name,
i.result
FROM candidates c
JOIN interviews i
ON c.candidate_id = i.candidate_id;  -- good
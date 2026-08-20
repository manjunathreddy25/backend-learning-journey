create database math_and_date_functions;
use math_and_date_functions;
CREATE TABLE anime_characters_staff (
    employee_id INT,
    character_name VARCHAR(50),
    anime_name VARCHAR(50),
    role VARCHAR(50),
    salary DECIMAL(10 , 2 ),
    bonus DECIMAL(10 , 2 ),
    dob DATE,
    joining_date DATE
);


INSERT INTO anime_characters_staff VALUES
(1, 'Naruto Uzumaki', 'Naruto', 'Ninja Leader', 75000.50, 5000, '1997-10-10', '2015-04-01'),
(2, 'Monkey D Luffy', 'One Piece', 'Pirate Captain', 82000.75, 7000, '1997-05-05', '2016-06-15'),
(3, 'Goku', 'Dragon Ball', 'Saiyan Warrior', 95000.25, 10000, '1984-04-16', '2010-01-10'),
(4, 'Levi Ackerman', 'Attack on Titan', 'Captain', 88000.40, 6000, '1990-12-25', '2013-09-20'),
(5, 'Tanjiro Kamado', 'Demon Slayer', 'Demon Slayer', 65000.80, 4000, '2000-07-14', '2020-02-01'),
(6, 'Mikasa Ackerman', 'Attack on Titan', 'Soldier', 72000.60, 4500, '1996-02-10', '2014-08-12'),
(7, 'Saitama', 'One Punch Man', 'Hero', 55000.30, 3000, '1988-08-21', '2018-03-05'),
(8, 'Ichigo Kurosaki', 'Bleach', 'Soul Reaper', 79000.90, 5500, '1995-07-15', '2012-11-11'),
(9, 'Light Yagami', 'Death Note', 'Detective', 67000.45, 3500, '1986-02-28', '2011-05-17'),
(10, 'Eren Yeager', 'Attack on Titan', 'Scout Leader', 85000.70, 8000, '2000-03-30', '2019-07-01');
-- ******************************************************************************************************************
-- day 5 

SELECT 
    ROUND(salary)
FROM
    anime_characters_staff
WHERE
    salary > 55000;

SELECT 
    MAX(bonus)
FROM
    anime_characters_staff;

SELECT 
    MIN(salary)
FROM
    anime_characters_staff;

SELECT 
    salary + bonus AS total_salary
FROM
    anime_characters_staff;

SELECT 
    CEIL(salary)
FROM
    anime_characters_staff;

SELECT 
    FLOOR(salary)
FROM
    anime_characters_staff;

SELECT 
    ABS(salary)
FROM
    anime_characters_staff;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- date functions
SELECT 
    EXTRACT(DAY FROM dob) AS dob_day,
    EXTRACT(MONTH FROM dob) AS dob_month,
    EXTRACT(YEAR FROM dob) AS dob_year
FROM
    anime_characters_staff
WHERE
    character_name = 'Naruto Uzumaki';

SELECT 
    character_name,
    dob,
    TIMESTAMPDIFF(DAY, dob, CURRENT_DATE()) AS age_days
FROM
    anime_characters_staff;

SELECT 
    salary,
    TIMESTAMPDIFF(YEAR, dob, CURRENT_DATE) AS age,
    character_name
FROM
    anime_characters_staff
WHERE
    TIMESTAMPDIFF(YEAR, dob, CURRENT_DATE) > 30
        AND salary > (SELECT 
            AVG(salary)
        FROM
            anime_characters_staff);

SELECT 
    AVG(salary) AS average_salary
FROM
    anime_characters_staff
WHERE
    TIMESTAMPDIFF(YEAR, dob, CURDATE()) > 30;

SELECT 
    character_name,
    joining_date,
    DATE_ADD(joining_date, INTERVAL 5 YEAR) AS after_5_years
FROM
    anime_characters_staff;

SELECT 
    character_name,
    DATEDIFF(CURDATE(), joining_date) AS days_worked
FROM
    anime_characters_staff;

SELECT 
    character_name,
    salary,
    ROUND(salary * 1.10) AS increased_salary
FROM
    anime_characters_staff
WHERE
    TIMESTAMPDIFF(YEAR,
        joining_date,
        CURRENT_DATE) > 7;


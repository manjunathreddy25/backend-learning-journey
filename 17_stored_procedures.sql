create database stored_procedures;
use stored_procedures;
-- =========================================================================================================================================================================
-- CRUD Procedures
CREATE TABLE patients(
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15),
    city VARCHAR(50),
    disease VARCHAR(100)
);
INSERT INTO patients
(first_name,last_name,age,gender,phone,city,disease)

VALUES
('Rahul','Sharma',28,'Male','9876543210','Hyderabad','Fever'),
('Sneha','Reddy',32,'Female','9876543211','Bangalore','Diabetes'),
('Ajay','Kumar',45,'Male','9876543212','Chennai','Heart Disease'),
('Priya','Patel',24,'Female','9876543213','Hyderabad','Cold'),
('Kiran','Verma',37,'Male','9876543214','Mumbai','Asthma');

CREATE TABLE appointments(
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_name VARCHAR(50),
    department VARCHAR(50),
    appointment_date DATE,
    status VARCHAR(20),

    FOREIGN KEY(patient_id)
    REFERENCES patients(patient_id)
);
INSERT INTO appointments
(patient_id,doctor_name,department,appointment_date,status)

VALUES
(1,'Dr. Rajesh','General Medicine','2026-07-20','Completed'),
(2,'Dr. Anitha','Diabetology','2026-07-21','Pending'),
(3,'Dr. Kumar','Cardiology','2026-07-22','Completed'),
(4,'Dr. Meena','ENT','2026-07-23','Cancelled'),
(5,'Dr. Arjun','Pulmonology','2026-07-24','Completed');

-- ==========================================================================================================================================================================

-- Procedure
SHOW PROCEDURE STATUS
where Db = 'trainingdb';
DELIMITER //

CREATE PROCEDURE AddPatient
(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_age INT,
    IN p_gender VARCHAR(10),
    IN p_phone VARCHAR(15),
    IN p_city VARCHAR(50),
    IN p_disease VARCHAR(100)
)

BEGIN

INSERT INTO patients
(
first_name,
last_name,
age,
gender,
phone,
city,
disease
)

VALUES
(
p_first_name,
p_last_name,
p_age,
p_gender,
p_phone,
p_city,
p_disease
);

END //

DELIMITER ;

CALL AddPatient
(
'Manjunath',
'Reddy',
24,
'Male',
'9701875821',
'Hyderabad',
'Migraine'
);
-- ==============================================================
-- READ Procedure
DELIMITER //

CREATE PROCEDURE GetAllPatients()

BEGIN

SELECT *
FROM patients;

END //

DELIMITER ;

CALL GetAllPatients();
-- READ by ID
DELIMITER //

CREATE PROCEDURE GetPatientById
(
IN p_id INT
)

BEGIN

SELECT *

FROM patients

WHERE patient_id=p_id;

END //

DELIMITER ;
CALL GetPatientById(3);
-- READ by City
DELIMITER //

CREATE PROCEDURE GetPatientsByCity
(
IN p_city VARCHAR(50)
)

BEGIN

SELECT *

FROM patients

WHERE city=p_city;

END //

DELIMITER ;
CALL GetPatientsByCity('Hyderabad');
-- ===============================================================
-- UPDATE Procedure
DELIMITER //

CREATE PROCEDURE UpdatePatientPhone
(
IN p_id INT,
IN p_phone VARCHAR(15)
)

BEGIN

UPDATE patients

SET phone=p_phone

WHERE patient_id=p_id;

END //

DELIMITER ;
CALL UpdatePatientPhone
(
1,
'8186834119'
);


DELIMITER //

CREATE PROCEDURE UpdatePatient
(
IN p_id INT,
IN p_phone VARCHAR(15),
IN p_city VARCHAR(50),
IN p_disease VARCHAR(100)
)

BEGIN

UPDATE patients

SET

phone=p_phone,

city=p_city,

disease=p_disease

WHERE patient_id=p_id;

END //

DELIMITER ;
CALL UpdatePatient
(
1,
'8888888888',
'Bangalore',
'Dengue'
);
-- =============================================================================
-- DELETE Procedure
DELIMITER //

CREATE PROCEDURE DeletePatient
(
IN p_id INT
)

BEGIN

DELETE

FROM patients

WHERE patient_id=p_id;

END //

DELIMITER ;
CALL DeletePatient(5);
-- ==========================================================================================================================================================================

-- IN Parameter
DELIMITER //

CREATE PROCEDURE GetPatient1(IN p_id INT)

BEGIN

SELECT *
FROM patients
WHERE patient_id=p_id;

END//

DELIMITER ;
call Getpatient(5);
-- ---------------------------------------------------------------------------
-- OUT Parameter
DELIMITER //

CREATE PROCEDURE PatientCount1(OUT total INT)

BEGIN
declare total int;
SELECT COUNT(*)
INTO total
FROM patients;

END//

DELIMITER ;
call PatientCount1(@count);
SELECT @count;

-- ------------------------------------------------------------------------------
-- INOUT Procedure
DELIMITER //

CREATE PROCEDURE IncreaseAge(INOUT p_age INT)

BEGIN

SET p_age=p_age+5;

END//

DELIMITER ;
SET @age=50;

CALL IncreaseAge(@age);

SELECT @age;

-- ==========================================================================================================================================================================
-- Different Examples
-- Group By
delimiter // 
create procedure group_by_city()
begin 
SELECT city,
COUNT(*) AS total_patients
FROM patients
GROUP BY city;
end // 
delimiter ;
call group_by_city();
-- ----------------------------------------------
-- Having
DELIMITER //

CREATE PROCEDURE count_of_city()

BEGIN
SELECT city,
COUNT(*)
FROM patients
GROUP BY city
HAVING COUNT(*) > 5;
END //

DELIMITER ;
call count_of_city();
-- --------------------------------------------------
-- IN
DELIMITER //

CREATE PROCEDURE Selected_City()

BEGIN

    SELECT *

FROM patients

WHERE city IN
('Hyderabad','Mumbai');

END //

DELIMITER ;
call Selected_City();
-- --------------------------------------------------
-- Left Join
DELIMITER //

CREATE PROCEDURE Patients_with_doctors_name()

BEGIN

    SELECT

p.first_name,

a.doctor_name

FROM patients p

LEFT JOIN appointments a

ON p.patient_id=a.patient_id;

END //

DELIMITER ;
call Patients_with_doctors_name();

-- --------------------------------------------------
-- Right Join
DELIMITER //

CREATE PROCEDURE Doctors_with_patients_name()

BEGIN

    SELECT

p.first_name,

a.doctor_name

FROM patients p

RIGHT JOIN appointments a

ON p.patient_id=a.patient_id;

END //

DELIMITER ;
call Doctors_with_patients_name();
-- --------------------------------------------------
-- Inner Join
DELIMITER //

CREATE PROCEDURE mathing_names()

BEGIN

    SELECT *

FROM patients p

INNER JOIN appointments a

ON p.patient_id=a.patient_id;

END //

DELIMITER ;
call mathing_names();
-- --------------------------------------------------
-- Subquery
DELIMITER //

CREATE PROCEDURE Subquery()

BEGIN

    SELECT *

FROM patients

WHERE patient_id IN

(
SELECT patient_id

FROM appointments
);

END //

DELIMITER ;
call Subquery();
-- --------------------------------------------------
-- Exists
DELIMITER //

CREATE PROCEDURE if_exists()

BEGIN

    SELECT *

FROM patients p

WHERE EXISTS

(
SELECT 1

FROM appointments a

WHERE a.patient_id=p.patient_id
);

END //

DELIMITER ;
call if_exists();
-- --------------------------------------------------
-- Case
DELIMITER //

CREATE PROCEDURE using_case()

BEGIN

    SELECT

first_name,

CASE

WHEN age>=60 THEN 'Senior'

WHEN age>=30 THEN 'Adult'

ELSE 'Young'

END AgeGroup

FROM patients;

END //

DELIMITER ;
call using_case();
-- --------------------------------------------------
-- --------------------------------------------------
-- Nested Procedures
DELIMITER //

CREATE PROCEDURE Nested_Procedures()

BEGIN

    call if_exists();

END //

DELIMITER ;
call Nested_Procedures();
-- ----------------------------------------------------
-- Variable in Procedures 
DELIMITER //

CREATE PROCEDURE PatientCount()

BEGIN

    DECLARE total_patients INT;  -- varaible declaration in sql

    SET total_patients = 0;

    SELECT COUNT(*)
    INTO total_patients
    FROM patients;

    SELECT total_patients; -- displays stored value in  total_patients variable 

END //

DELIMITER ;
call PatientCount();
-- --------------------------------------------------
-- Using IF_ELSE
DELIMITER //

CREATE PROCEDURE Patient_Status(in p_id int)

BEGIN

    DECLARE p_age INT;

SELECT age
INTO p_age
FROM patients
WHERE patient_id = p_id;

IF p_age < 18 THEN
    SELECT 'Younger Patient';
ELSE
    SELECT 'Adult Patient';
END IF;

END //

DELIMITER ;
call Patient_Status(2);
-- ==========================================================================================================================================================================
-- Use of CRUD Procedures

-- ✅ Reduce code redundancy (Don't repeat the same SQL queries in multiple places.)
-- ✅ Reuse code (Write the procedure once, call it many times.)
-- ✅ Simplify CRUD operations (Create, Read, Update, Delete become easy.)
-- ✅ Improve security (Applications can be allowed to execute procedures without giving direct access to tables.)
-- ✅ Improve maintainability (Code is easier to manage and debug.)
-- ✅ Can improve performance for frequently executed operations because the SQL is precompiled/optimized by MySQL.
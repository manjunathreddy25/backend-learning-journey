create database hr_attendance_and_overtime_payroll;
use hr_attendance_and_overtime_payroll;
-- *****************************************************************************
-- HR, Attendance & Payroll
-- Assume:employees, attendance_logs, shifts, salary_revisions, departments
-- Shift Compliance & OT Calculation
-- attendance_logs(emp_id, punch_in, punch_out) and shifts(emp_id, shift_start, shift_end).


-- Tasks:
-- Detect employees who work more than 12 hours in a day.
-- Weekly: compute total hours worked and flag those exceeding 60 hours/week.
-- Calculate night shift allowance for hours worked between 10 PM–6 AM.


-- Concepts: time arithmetic, overlaps, grouping by week, business rules.
-- *****************************************************************************
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
INSERT INTO departments
(department_id, department_name)
VALUES
(1, 'Engineering'),
(2, 'Human Resources'),
(3, 'Finance'),
(4, 'Operations'),
(5, 'Sales');
-- ------------------------------------------------------------------------------
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    designation VARCHAR(100),
    joining_date DATE,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);
INSERT INTO employees
(emp_id, emp_name, department_id, designation, joining_date)
VALUES
(1001, 'Rahul Sharma', 1, 'Software Engineer', '2024-06-10'),
(1002, 'Priya Reddy', 1, 'Backend Developer', '2023-08-15'),
(1003, 'Arjun Kumar', 2, 'HR Executive', '2025-01-20'),
(1004, 'Sneha Rao', 3, 'Financial Analyst', '2024-03-12'),
(1005, 'Vikram Singh', 4, 'Operations Executive', '2023-11-05'),
(1006, 'Ananya Patel', 1, 'Software Engineer', '2025-05-18'),
(1007, 'Kiran Reddy', 4, 'Operations Manager', '2022-09-01'),
(1008, 'Meera Nair', 5, 'Sales Executive', '2024-01-25'),
(1009, 'Rohit Verma', 1, 'DevOps Engineer', '2023-04-17'),
(1010, 'Divya Menon', 5, 'Sales Manager', '2022-07-11');
-- --------------------------------------------------------------------------
CREATE TABLE shifts (
    shift_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    shift_start TIME NOT NULL,
    shift_end TIME NOT NULL,
    shift_type VARCHAR(30),

    FOREIGN KEY (emp_id)
        REFERENCES employees(emp_id)
);
INSERT INTO shifts
(emp_id, shift_start, shift_end, shift_type)
VALUES
(1001, '09:00:00', '18:00:00', 'DAY'),
(1002, '10:00:00', '19:00:00', 'DAY'),
(1003, '09:30:00', '18:30:00', 'DAY'),
(1004, '09:00:00', '18:00:00', 'DAY'),
(1005, '08:00:00', '17:00:00', 'DAY'),
(1006, '10:00:00', '19:00:00', 'DAY'),
(1007, '20:00:00', '05:00:00', 'NIGHT'),
(1008, '21:00:00', '06:00:00', 'NIGHT'),
(1009, '22:00:00', '07:00:00', 'NIGHT'),
(1010, '09:00:00', '18:00:00', 'DAY');
-- -----------------------------------------------------------------------------
CREATE TABLE attendance_logs(
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    punch_in DATETIME NOT NULL,
    punch_out DATETIME NOT NULL,

    FOREIGN KEY (emp_id)
        REFERENCES employees(emp_id)
);
INSERT INTO attendance_logs
(emp_id, punch_in, punch_out)
VALUES
(1001, '2026-08-10 09:00:00', '2026-08-10 18:00:00'),
(1001, '2026-08-11 09:05:00', '2026-08-11 18:10:00'),
(1001, '2026-08-12 09:00:00', '2026-08-12 18:00:00'),
(1001, '2026-08-13 09:10:00', '2026-08-13 18:00:00'),
(1001, '2026-08-14 09:00:00', '2026-08-14 17:30:00'),

(1002, '2026-08-10 10:00:00', '2026-08-10 19:00:00'),
(1002, '2026-08-11 10:05:00', '2026-08-11 19:10:00'),
(1002, '2026-08-12 10:00:00', '2026-08-12 19:00:00'),
(1002, '2026-08-13 10:00:00', '2026-08-13 19:00:00'),
(1002, '2026-08-14 10:15:00', '2026-08-14 18:45:00'),

(1003, '2026-08-10 09:00:00', '2026-08-10 18:00:00'),
(1003, '2026-08-11 08:30:00', '2026-08-11 21:30:00'),
(1003, '2026-08-12 09:00:00', '2026-08-12 18:00:00'),
(1003, '2026-08-13 09:00:00', '2026-08-13 18:00:00'),
(1003, '2026-08-14 09:00:00', '2026-08-14 17:00:00'),

(1004, '2026-08-10 08:00:00', '2026-08-10 20:30:00'),
(1004, '2026-08-11 08:00:00', '2026-08-11 20:30:00'),
(1004, '2026-08-12 08:00:00', '2026-08-12 20:30:00'),
(1004, '2026-08-13 08:00:00', '2026-08-13 20:30:00'),
(1004, '2026-08-14 08:00:00', '2026-08-14 20:30:00'),

(1005, '2026-08-10 08:00:00', '2026-08-10 17:00:00'),
(1005, '2026-08-11 08:00:00', '2026-08-11 17:00:00'),
(1005, '2026-08-12 08:10:00', '2026-08-12 17:10:00'),
(1005, '2026-08-13 08:00:00', '2026-08-13 17:00:00'),
(1005, '2026-08-14 08:00:00', '2026-08-14 17:00:00'),

(1006, '2026-08-10 07:00:00', '2026-08-10 20:00:00'),
(1006, '2026-08-11 07:00:00', '2026-08-11 20:00:00'),
(1006, '2026-08-12 07:00:00', '2026-08-12 20:00:00'),
(1006, '2026-08-13 07:00:00', '2026-08-13 20:00:00'),
(1006, '2026-08-14 07:00:00', '2026-08-14 20:00:00'),

(1007, '2026-08-10 20:00:00', '2026-08-11 05:00:00'),
(1007, '2026-08-11 20:00:00', '2026-08-12 05:00:00'),
(1007, '2026-08-12 20:00:00', '2026-08-13 05:00:00'),
(1007, '2026-08-13 20:00:00', '2026-08-14 05:00:00'),
(1007, '2026-08-14 20:00:00', '2026-08-15 05:00:00'),

(1008, '2026-08-10 21:00:00', '2026-08-11 06:00:00'),
(1008, '2026-08-11 21:30:00', '2026-08-12 06:30:00'),
(1008, '2026-08-12 21:00:00', '2026-08-13 05:30:00'),
(1008, '2026-08-13 21:00:00', '2026-08-14 06:00:00'),
(1008, '2026-08-14 21:15:00', '2026-08-15 06:15:00'),

(1009, '2026-08-10 22:00:00', '2026-08-11 07:00:00'),
(1009, '2026-08-11 22:00:00', '2026-08-12 07:00:00'),
(1009, '2026-08-12 18:00:00', '2026-08-13 07:00:00'),
(1009, '2026-08-13 22:00:00', '2026-08-14 07:00:00'),
(1009, '2026-08-14 22:00:00', '2026-08-15 07:00:00'),

(1010, '2026-08-10 09:00:00', '2026-08-10 18:00:00'),
(1010, '2026-08-11 09:00:00', '2026-08-11 18:00:00'),
(1010, '2026-08-12 09:00:00', '2026-08-12 18:00:00'),
(1010, '2026-08-13 09:00:00', '2026-08-13 18:00:00'),
(1010, '2026-08-14 09:00:00', '2026-08-14 18:00:00');
-- *****************************************************************************
-- Detect employees working more than 12 hours in a day
SELECT
    emp_id,
    punch_in,
    punch_out,
    CASE
        WHEN TIMESTAMPDIFF(HOUR, punch_in, punch_out) > 12
        THEN 'YES'
        ELSE 'NO'
    END AS more_than_12_hours
FROM attendance_logs;

SELECT
    emp_id,
    punch_in,
    punch_out,
    CASE
        WHEN TIMESTAMPDIFF(HOUR, punch_in, punch_out) > 12
        THEN '12+ Hrs'
    END AS more_than_12_hours
FROM attendance_logs
WHERE TIMESTAMPDIFF(HOUR, punch_in, punch_out) > 12 ;
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Employees exceeding 60 hours/week
SELECT
    emp_id,
    YEARWEEK(punch_in) AS work_week,
    SUM(
        TIMESTAMPDIFF(MINUTE, punch_in, punch_out) / 60.0
    ) AS total_weekly_hours
FROM attendance_logs
GROUP BY
    emp_id,
    YEARWEEK(punch_in)
having SUM(
        TIMESTAMPDIFF(MINUTE, punch_in, punch_out) / 60.0
    ) > 60 ;
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Calculate night shift allowance for hours worked between 10 PM–6 AM.
WITH night_hours AS
(
SELECT
    emp_id,
    punch_in,
    punch_out,

    GREATEST(
        punch_in,
        TIMESTAMP(DATE(punch_in), '22:00:00')
    ) AS night_start,

    LEAST(
        punch_out,
        TIMESTAMP(DATE(punch_in) + INTERVAL 1 DAY,'06:00:00')
    ) AS night_end,

    CASE
        WHEN
            LEAST(
                punch_out,
                TIMESTAMP(
                    DATE(punch_in) + INTERVAL 1 DAY,
                    '06:00:00'
                )
            )
            >
            GREATEST(
                punch_in,
                TIMESTAMP(DATE(punch_in), '22:00:00')
            )
        THEN
            TIMESTAMPDIFF(
                MINUTE,

                GREATEST(
                    punch_in,
                    TIMESTAMP(DATE(punch_in), '22:00:00')
                ),

                LEAST(
                    punch_out,
                    TIMESTAMP(
                        DATE(punch_in) + INTERVAL 1 DAY,
                        '06:00:00'
                    )
                )
            ) / 60.0

        ELSE 0
    END AS night_hours

FROM attendance_logs
)
SELECT
    emp_id,
    ROUND(SUM(night_hours), 2) AS total_night_hours
FROM night_hours
GROUP BY emp_id
HAVING SUM(night_hours) > 0
ORDER BY emp_id;
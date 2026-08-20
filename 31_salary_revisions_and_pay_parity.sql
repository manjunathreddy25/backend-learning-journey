create database day_31;
use day_31;
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Salary Revisions & Pay Parity
-- salary_revisions(emp_id, effective_from, ctc, grade).


-- Tasks:
-- For each employee, compute increment % between consecutive salary revisions (use LAG).

-- Within each grade + department, find employees whose last increment was below team average.

-- Identify employees who did not get any increment in past 2 cycles while their peers did.


-- Concepts: window functions, partitions, comparison within groups.
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
INSERT INTO departments
(department_id, department_name)
VALUES
(1, 'Engineering'),
(2, 'Finance'),
(3, 'HR'),
(4, 'Operations');
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);
INSERT INTO employees
(emp_id, emp_name, department_id)
VALUES
(1001, 'Rahul', 1),
(1002, 'Priya', 1),
(1003, 'Arjun', 1),
(1004, 'Sneha', 1),

(1005, 'Vikram', 2),
(1006, 'Ananya', 2),
(1007, 'Kiran', 2),

(1008, 'Meera', 3),
(1009, 'Rohit', 4),
(1010, 'Divya', 4);
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
CREATE TABLE salary_revisions (
    revision_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    effective_from DATE NOT NULL,
    ctc DECIMAL(12,2) NOT NULL,
    grade VARCHAR(10) NOT NULL,

    FOREIGN KEY (emp_id)
        REFERENCES employees(emp_id)
);
INSERT INTO salary_revisions
(emp_id, effective_from, ctc, grade)
VALUES
(1001, '2025-01-01', 600000, 'A'),
(1001, '2025-07-01', 660000, 'A'),
(1001, '2026-01-01', 726000, 'A'),

(1002, '2025-01-01', 600000, 'A'),
(1002, '2025-07-01', 636000, 'A'),
(1002, '2026-01-01', 687000, 'A'),

(1003, '2025-01-01', 600000, 'A'),
(1003, '2025-07-01', 672000, 'A'),
(1003, '2026-01-01', 772800, 'A'),

(1004, '2025-01-01', 600000, 'A'),
(1004, '2025-07-01', 660000, 'A'),
(1004, '2026-01-01', 660000, 'A'),
(1004, '2026-07-01', 660000, 'A'),

(1005, '2025-01-01', 500000, 'B'),
(1005, '2025-07-01', 550000, 'B'),
(1005, '2026-01-01', 605000, 'B'),

(1006, '2025-01-01', 500000, 'B'),
(1006, '2025-07-01', 525000, 'B'),
(1006, '2026-01-01', 535500, 'B'),

(1007, '2025-01-01', 500000, 'B'),
(1007, '2025-07-01', 560000, 'B'),
(1007, '2026-01-01', 627200, 'B'),

(1008, '2025-01-01', 450000, 'C'),
(1008, '2025-07-01', 472500, 'C'),
(1008, '2026-01-01', 510300, 'C'),

(1009, '2025-01-01', 550000, 'B'),
(1009, '2025-07-01', 605000, 'B'),
(1009, '2026-01-01', 665500, 'B'),

(1010, '2025-01-01', 550000, 'B'),
(1010, '2025-07-01', 577500, 'B'),
(1010, '2026-01-01', 577500, 'B');
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- For each employee, compute increment % between consecutive salary revisions (use LAG)

WITH salary_history AS
(
    SELECT
        emp_id,
        effective_from,
        ctc,
        grade,

        LAG(ctc) OVER (
            PARTITION BY emp_id
            ORDER BY effective_from
        ) AS previous_ctc

    FROM salary_revisions
)

SELECT
    emp_id,
    effective_from,
    ctc,
    previous_ctc,
    CONCAT(
    COALESCE(
        ROUND(
            (ctc - previous_ctc) / previous_ctc * 100,
            2
        ),
        0
    ),
    '%'
) AS increment_percentage

FROM salary_history
ORDER BY
    emp_id,
    effective_from;
-- ***********************************************************************************
-- Within each grade + department, find employees whose last increment was below team average.

WITH salary_history AS
(
    SELECT
        emp_id,
        effective_from,
        ctc,
        grade,

        LAG(ctc) OVER (
            PARTITION BY emp_id
            ORDER BY effective_from
        ) AS previous_ctc

    FROM salary_revisions
),

salary_with_increment AS
(
    SELECT
        emp_id,
        effective_from,
        ctc,
        grade,

        COALESCE(
            ROUND(
                (ctc - previous_ctc)
                / previous_ctc * 100,
                2
            ),
            0
        ) AS increment_percentage

    FROM salary_history
),

latest_revision AS
(
    SELECT
        s.*,
        e.department_id,

        ROW_NUMBER() OVER (
            PARTITION BY s.emp_id
            ORDER BY s.effective_from DESC
        ) AS rn

    FROM salary_with_increment s

    JOIN employees e
        ON s.emp_id = e.emp_id
),

team_average AS
(
    SELECT
        *,
        
        AVG(increment_percentage) OVER (
            PARTITION BY department_id, grade
        ) AS team_average_increment

    FROM latest_revision

    WHERE rn = 1
)

SELECT
    emp_id,
    department_id,
    grade,
    increment_percentage,
    ROUND(team_average_increment, 2) AS team_average_increment,

    CASE
        WHEN increment_percentage < team_average_increment
        THEN 'BELOW AVERAGE'
        ELSE 'OK'
    END AS status

FROM team_average
ORDER BY
    department_id,
    grade,
    emp_id;
-- ***********************************************************************************
-- Identify employees who did not get any increment in the past 2 salary cycles while their peers did.

WITH salary_history AS
(
    SELECT
        emp_id,
        effective_from,
        ctc,
        grade,

        LAG(ctc) OVER (
            PARTITION BY emp_id
            ORDER BY effective_from
        ) AS previous_ctc

    FROM salary_revisions
),

salary_with_increment AS
(
    SELECT
        emp_id,
        effective_from,
        ctc,
        grade,

        COALESCE(
            ROUND(
                (ctc - previous_ctc)
                / previous_ctc * 100,
                2
            ),
            0
        ) AS increment_percentage

    FROM salary_history
),

revision_ranked AS
(
    SELECT
        s.*,

        ROW_NUMBER() OVER (
            PARTITION BY emp_id
            ORDER BY effective_from DESC
        ) AS rn

    FROM salary_with_increment s
),

employee_history AS
(
    SELECT
        r.*,
        e.department_id

    FROM revision_ranked r

    JOIN employees e
        ON r.emp_id = e.emp_id

    WHERE r.rn <= 2
),

employee_two_cycle AS
(
    SELECT
        emp_id,
        department_id,
        grade,

        SUM(increment_percentage)
            AS last_two_cycle_increment

    FROM employee_history

    GROUP BY
        emp_id,
        department_id,
        grade
),

team_check AS
(
    SELECT
        *,

        SUM(last_two_cycle_increment) OVER (
            PARTITION BY department_id, grade
        ) AS team_increment_total

    FROM employee_two_cycle
)

SELECT
    emp_id,
    department_id,
    grade,
    last_two_cycle_increment,
    team_increment_total,

    CASE
        WHEN last_two_cycle_increment = 0
             AND team_increment_total > 0
        THEN 'FLAGGED'
        ELSE 'OK'
    END AS status

FROM team_check
ORDER BY
    department_id,
    grade,
    emp_id;
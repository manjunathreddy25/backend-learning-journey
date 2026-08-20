create database day_29;
use day_29;
-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
-- Tiered Interest & Backdated Changes


-- Tasks:
-- Implement tiered interest:
-- 0–50k → 3%
-- 50k–2L → 5%
-- Above 2L → 6.5%

-- For each month, compute interest per account using the daily closing balance.

-- If a backdated transaction is inserted, recalculate interest for that month and track adjustment entries in a separate table.


-- Concepts: complex CASE logic, daily snapshot, recomputation, transaction audit.
-- @backend guys
-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE TABLE interest_accounts (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    current_balance DECIMAL(12,2) NOT NULL
);
INSERT INTO interest_accounts
(account_id, customer_name, current_balance)
VALUES
(2001, 'Rahul Sharma', 35000.00),
(2002, 'Priya Reddy', 75000.00),
(2003, 'Arjun Kumar', 150000.00),
(2004, 'Sneha Rao', 225000.00),
(2005, 'Vikram Singh', 45000.00),
(2006, 'Ananya Patel', 110000.00),
(2007, 'Kiran Reddy', 300000.00),
(2008, 'Meera Nair', 60000.00),
(2009, 'Rohit Verma', 180000.00),
(2010, 'Divya Menon', 500000.00);

CREATE TABLE interest_transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_type ENUM('CREDIT', 'DEBIT') NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    transaction_date DATETIME NOT NULL,

    FOREIGN KEY (account_id)
        REFERENCES interest_accounts(account_id)
);
INSERT INTO interest_transactions
(transaction_id, account_id, transaction_type, amount, transaction_date)
VALUES

-- =====================================================
-- ACCOUNT 2001
-- Low balance → mostly 3% tier
-- Multiple transactions on same day
-- =====================================================

(1, 2001, 'CREDIT', 30000.00, '2026-07-01 09:00:00'),
(2, 2001, 'CREDIT', 10000.00, '2026-07-01 14:00:00'),
(3, 2001, 'DEBIT',   5000.00, '2026-07-03 11:00:00'),
(4, 2001, 'CREDIT', 10000.00, '2026-07-10 09:30:00'),
(5, 2001, 'DEBIT',   2000.00, '2026-07-10 15:30:00'),
(6, 2001, 'DEBIT',   8000.00, '2026-07-20 12:00:00'),

(7, 2001, 'CREDIT',  5000.00, '2026-08-01 10:00:00'),
(8, 2001, 'CREDIT', 12000.00, '2026-08-05 09:00:00'),
(9, 2001, 'DEBIT',    3000.00, '2026-08-05 16:00:00'),
(10, 2001, 'DEBIT',   7000.00, '2026-08-18 13:00:00'),

(11, 2001, 'CREDIT',  8000.00, '2026-09-01 09:00:00'),
(12, 2001, 'DEBIT',    4000.00, '2026-09-10 11:00:00'),
(13, 2001, 'CREDIT',  6000.00, '2026-09-10 16:00:00'),
(14, 2001, 'DEBIT',    5000.00, '2026-09-25 14:00:00'),


-- =====================================================
-- ACCOUNT 2002
-- Crosses ₹50K → 3% then 5%
-- =====================================================

(15, 2002, 'CREDIT', 40000.00, '2026-07-01 09:00:00'),
(16, 2002, 'CREDIT', 20000.00, '2026-07-01 15:00:00'),
(17, 2002, 'DEBIT',    5000.00, '2026-07-07 10:00:00'),
(18, 2002, 'CREDIT', 10000.00, '2026-07-07 17:00:00'),
(19, 2002, 'DEBIT',   10000.00, '2026-07-15 14:00:00'),
(20, 2002, 'CREDIT', 25000.00, '2026-07-22 10:00:00'),

(21, 2002, 'DEBIT',    5000.00, '2026-08-03 09:00:00'),
(22, 2002, 'CREDIT', 20000.00, '2026-08-03 16:00:00'),
(23, 2002, 'DEBIT',   15000.00, '2026-08-12 13:00:00'),
(24, 2002, 'CREDIT', 10000.00, '2026-08-25 10:00:00'),

(25, 2002, 'DEBIT',    5000.00, '2026-09-02 09:30:00'),
(26, 2002, 'CREDIT', 15000.00, '2026-09-12 10:00:00'),
(27, 2002, 'DEBIT',    5000.00, '2026-09-12 17:00:00'),
(28, 2002, 'DEBIT',   10000.00, '2026-09-28 15:00:00'),


-- =====================================================
-- ACCOUNT 2003
-- 50K–2L → 5%
-- =====================================================

(29, 2003, 'CREDIT',100000.00, '2026-07-01 09:00:00'),
(30, 2003, 'CREDIT', 50000.00, '2026-07-02 10:00:00'),
(31, 2003, 'DEBIT',    5000.00, '2026-07-02 15:00:00'),
(32, 2003, 'DEBIT',   15000.00, '2026-07-14 12:00:00'),
(33, 2003, 'CREDIT', 30000.00, '2026-07-25 09:30:00'),

(34, 2003, 'DEBIT',   10000.00, '2026-08-01 11:00:00'),
(35, 2003, 'CREDIT', 25000.00, '2026-08-08 09:00:00'),
(36, 2003, 'DEBIT',    5000.00, '2026-08-08 18:00:00'),
(37, 2003, 'DEBIT',   20000.00, '2026-08-20 14:00:00'),
(38, 2003, 'CREDIT', 10000.00, '2026-08-29 10:00:00'),

(39, 2003, 'DEBIT',   12000.00, '2026-09-03 11:00:00'),
(40, 2003, 'CREDIT', 20000.00, '2026-09-15 09:00:00'),
(41, 2003, 'DEBIT',    5000.00, '2026-09-15 16:00:00'),
(42, 2003, 'CREDIT', 15000.00, '2026-09-27 10:00:00'),


-- =====================================================
-- ACCOUNT 2004
-- Above ₹2L → 6.5%
-- =====================================================

(43, 2004, 'CREDIT',250000.00, '2026-07-01 08:30:00'),
(44, 2004, 'DEBIT',   20000.00, '2026-07-05 10:00:00'),
(45, 2004, 'CREDIT', 30000.00, '2026-07-05 16:00:00'),
(46, 2004, 'DEBIT',   15000.00, '2026-07-12 11:00:00'),
(47, 2004, 'CREDIT', 50000.00, '2026-07-20 09:00:00'),

(48, 2004, 'DEBIT',   40000.00, '2026-08-02 10:00:00'),
(49, 2004, 'CREDIT', 25000.00, '2026-08-02 17:00:00'),
(50, 2004, 'DEBIT',   30000.00, '2026-08-15 13:00:00'),
(51, 2004, 'CREDIT', 20000.00, '2026-08-25 10:00:00'),

(52, 2004, 'DEBIT',   25000.00, '2026-09-01 09:00:00'),
(53, 2004, 'CREDIT', 40000.00, '2026-09-10 11:00:00'),
(54, 2004, 'DEBIT',   10000.00, '2026-09-10 18:00:00'),
(55, 2004, 'DEBIT',   20000.00, '2026-09-25 15:00:00'),


-- =====================================================
-- ACCOUNT 2005
-- Mostly below ₹50K → 3%
-- =====================================================

(56, 2005, 'CREDIT',20000.00, '2026-07-01 09:00:00'),
(57, 2005, 'CREDIT',15000.00, '2026-07-01 15:00:00'),
(58, 2005, 'DEBIT',   3000.00, '2026-07-08 11:00:00'),
(59, 2005, 'CREDIT', 8000.00, '2026-07-16 10:00:00'),
(60, 2005, 'DEBIT',   2000.00, '2026-07-16 17:00:00'),
(61, 2005, 'DEBIT',   5000.00, '2026-07-28 14:00:00'),

(62, 2005, 'CREDIT',10000.00, '2026-08-04 09:00:00'),
(63, 2005, 'DEBIT',  2000.00, '2026-08-04 16:00:00'),
(64, 2005, 'CREDIT', 7000.00, '2026-08-19 10:00:00'),
(65, 2005, 'DEBIT',  4000.00, '2026-08-27 14:00:00'),

(66, 2005, 'CREDIT', 6000.00, '2026-09-05 09:00:00'),
(67, 2005, 'DEBIT',  1000.00, '2026-09-05 16:00:00'),
(68, 2005, 'DEBIT',  5000.00, '2026-09-18 13:00:00'),
(69, 2005, 'CREDIT', 4000.00, '2026-09-29 10:00:00'),


-- =====================================================
-- ACCOUNT 2006
-- 50K–2L → 5%
-- =====================================================

(70, 2006, 'CREDIT',80000.00, '2026-07-01 09:00:00'),
(71, 2006, 'DEBIT',  10000.00, '2026-07-06 11:00:00'),
(72, 2006, 'CREDIT',20000.00, '2026-07-06 17:00:00'),
(73, 2006, 'CREDIT',30000.00, '2026-07-13 10:00:00'),
(74, 2006, 'DEBIT',  15000.00, '2026-07-21 15:00:00'),

(75, 2006, 'CREDIT',10000.00, '2026-08-01 09:00:00'),
(76, 2006, 'DEBIT',  20000.00, '2026-08-10 11:00:00'),
(77, 2006, 'CREDIT',15000.00, '2026-08-10 18:00:00'),
(78, 2006, 'DEBIT',   5000.00, '2026-08-18 14:00:00'),
(79, 2006, 'CREDIT',10000.00, '2026-08-30 10:00:00'),

(80, 2006, 'DEBIT',  12000.00, '2026-09-04 11:00:00'),
(81, 2006, 'CREDIT',25000.00, '2026-09-12 09:00:00'),
(82, 2006, 'DEBIT',   5000.00, '2026-09-12 17:00:00'),
(83, 2006, 'DEBIT',   8000.00, '2026-09-26 14:00:00'),


-- =====================================================
-- ACCOUNT 2007
-- Above ₹2L → 6.5%
-- =====================================================

(84, 2007, 'CREDIT',300000.00, '2026-07-01 08:00:00'),
(85, 2007, 'DEBIT',   30000.00, '2026-07-09 10:00:00'),
(86, 2007, 'CREDIT', 50000.00, '2026-07-09 17:00:00'),
(87, 2007, 'CREDIT',100000.00, '2026-07-17 11:00:00'),
(88, 2007, 'DEBIT',   25000.00, '2026-07-26 15:00:00'),

(89, 2007, 'DEBIT',   40000.00, '2026-08-03 10:00:00'),
(90, 2007, 'CREDIT', 20000.00, '2026-08-03 18:00:00'),
(91, 2007, 'DEBIT',   30000.00, '2026-08-17 13:00:00'),
(92, 2007, 'CREDIT', 50000.00, '2026-08-28 09:00:00'),

(93, 2007, 'DEBIT',   20000.00, '2026-09-05 11:00:00'),
(94, 2007, 'CREDIT', 60000.00, '2026-09-15 09:00:00'),
(95, 2007, 'DEBIT',   10000.00, '2026-09-15 18:00:00'),
(96, 2007, 'DEBIT',   25000.00, '2026-09-27 15:00:00'),


-- =====================================================
-- ACCOUNT 2008
-- Moves around ₹50K boundary
-- =====================================================

(97, 2008, 'CREDIT',45000.00, '2026-07-01 09:00:00'),
(98, 2008, 'CREDIT',20000.00, '2026-07-10 10:00:00'),
(99, 2008, 'DEBIT',   5000.00, '2026-07-10 16:00:00'),
(100, 2008, 'CREDIT', 5000.00, '2026-07-19 11:00:00'),
(101, 2008, 'DEBIT',  8000.00, '2026-07-29 14:00:00'),

(102, 2008, 'CREDIT',10000.00, '2026-08-02 09:00:00'),
(103, 2008, 'DEBIT',  3000.00, '2026-08-02 17:00:00'),
(104, 2008, 'DEBIT',  5000.00, '2026-08-14 12:00:00'),
(105, 2008, 'CREDIT',15000.00, '2026-08-22 10:00:00'),

(106, 2008, 'DEBIT',  4000.00, '2026-09-01 09:00:00'),
(107, 2008, 'CREDIT', 8000.00, '2026-09-09 11:00:00'),
(108, 2008, 'DEBIT',  2000.00, '2026-09-09 17:00:00'),
(109, 2008, 'DEBIT',  7000.00, '2026-09-24 14:00:00'),


-- =====================================================
-- ACCOUNT 2009
-- 50K–2L → 5%
-- =====================================================

(110, 2009, 'CREDIT',120000.00, '2026-07-01 09:00:00'),
(111, 2009, 'DEBIT',   10000.00, '2026-07-08 11:00:00'),
(112, 2009, 'CREDIT', 40000.00, '2026-07-15 09:00:00'),
(113, 2009, 'DEBIT',    5000.00, '2026-07-15 17:00:00'),
(114, 2009, 'DEBIT',   10000.00, '2026-07-24 14:00:00'),

(115, 2009, 'CREDIT',20000.00, '2026-08-03 10:00:00'),
(116, 2009, 'DEBIT', 15000.00, '2026-08-11 12:00:00'),
(117, 2009, 'CREDIT',10000.00, '2026-08-20 09:00:00'),
(118, 2009, 'DEBIT',  5000.00, '2026-08-20 18:00:00'),

(119, 2009, 'DEBIT',   8000.00, '2026-09-02 11:00:00'),
(120, 2009, 'CREDIT',15000.00, '2026-09-14 09:00:00'),
(121, 2009, 'DEBIT',  5000.00, '2026-09-14 17:00:00'),
(122, 2009, 'CREDIT',10000.00, '2026-09-26 10:00:00'),


-- =====================================================
-- ACCOUNT 2010
-- Above ₹2L → 6.5%
-- =====================================================

(123, 2010, 'CREDIT',400000.00, '2026-07-01 08:30:00'),
(124, 2010, 'DEBIT',   50000.00, '2026-07-10 10:00:00'),
(125, 2010, 'CREDIT', 75000.00, '2026-07-10 17:00:00'),
(126, 2010, 'CREDIT',100000.00, '2026-07-18 11:00:00'),
(127, 2010, 'DEBIT',   25000.00, '2026-07-27 15:00:00'),

(128, 2010, 'DEBIT',   40000.00, '2026-08-04 10:00:00'),
(129, 2010, 'CREDIT', 50000.00, '2026-08-04 18:00:00'),
(130, 2010, 'DEBIT',   30000.00, '2026-08-16 13:00:00'),
(131, 2010, 'CREDIT', 60000.00, '2026-08-28 09:00:00'),

(132, 2010, 'DEBIT',   25000.00, '2026-09-05 11:00:00'),
(133, 2010, 'CREDIT', 50000.00, '2026-09-15 09:00:00'),
(134, 2010, 'DEBIT',   10000.00, '2026-09-15 18:00:00'),
(135, 2010, 'DEBIT',   20000.00, '2026-09-28 15:00:00');
CREATE TABLE interest_adjustments (
    adjustment_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    interest_month DATE NOT NULL,
    old_interest DECIMAL(12,2) NOT NULL,
    new_interest DECIMAL(12,2) NOT NULL,
    adjustment_amount DECIMAL(12,2) NOT NULL,
    reason VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (account_id)
        REFERENCES interest_accounts(account_id)
);
-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

-- Tiered Interest
SELECT
    account_id,
    current_balance,

    CASE
        WHEN current_balance <= 50000 THEN 3
        WHEN current_balance <= 200000 THEN 5
        ELSE 6.5
    END AS interest_rate

FROM interest_accounts;
-- ******************************************************************************************************
-- For each month, compute interest per account using the daily closing balance.
CREATE VIEW running_balances AS
SELECT
    account_id,
    transaction_id,
    transaction_date,
    transaction_type,
    amount,

    SUM(
        CASE
            WHEN transaction_type = 'CREDIT' THEN amount
            WHEN transaction_type = 'DEBIT' THEN -amount
        END
    ) OVER (
        PARTITION BY account_id
        ORDER BY transaction_date, transaction_id
    ) AS running_balance

FROM interest_transactions;
SELECT *
FROM running_balances;



CREATE VIEW daily_closing_balances AS
WITH ranked AS
(
    SELECT
        account_id,
        transaction_id,
        transaction_date,
        running_balance,

        ROW_NUMBER() OVER (
            PARTITION BY account_id, DATE(transaction_date)
            ORDER BY transaction_date DESC, transaction_id DESC
        ) AS rn

    FROM running_balances
)

SELECT
    account_id,
    DATE(transaction_date) AS txn_day,
    running_balance AS daily_closing_balance

FROM ranked

WHERE rn = 1;
SELECT *
FROM daily_closing_balances;




CREATE VIEW daily_interest AS
SELECT
    account_id,
    txn_day,
    daily_closing_balance,

    CASE
        WHEN daily_closing_balance <= 50000 THEN 3
        WHEN daily_closing_balance <= 200000 THEN 5
        ELSE 6.5
    END AS interest_rate,

    daily_closing_balance
        *
        (
            CASE
                WHEN daily_closing_balance <= 50000 THEN 3
                WHEN daily_closing_balance <= 200000 THEN 5
                ELSE 6.5
            END
        )
        / 100
        / 365 AS daily_interest

FROM daily_closing_balances;
SELECT *
FROM daily_interest;





SELECT
    account_id,
    DATE_FORMAT(txn_day, '%Y-%m') AS month,
    ROUND(SUM(daily_interest), 2) AS monthly_interest

FROM daily_interest

GROUP BY
    account_id,
    DATE_FORMAT(txn_day, '%Y-%m')

ORDER BY
    account_id,
    month;
    
-- ******************************************************************************************************
    -- If a backdated transaction is inserted, recalculate interest for that month and track adjustment entries in a separate table.

CREATE VIEW daily_interest_3 AS

WITH RECURSIVE date_range AS
(
    SELECT MIN(DATE(transaction_date)) AS calendar_date
    FROM interest_transactions

    UNION ALL

    SELECT DATE_ADD(calendar_date, INTERVAL 1 DAY)
    FROM date_range

    WHERE calendar_date < (
        SELECT MAX(DATE(transaction_date))
        FROM interest_transactions
    )
),

daily_balances AS
(
    SELECT
        a.account_id,
        d.calendar_date,

        COALESCE(
            (
                SELECT SUM(
                    CASE
                        WHEN t.transaction_type = 'CREDIT'
                            THEN t.amount
                        WHEN t.transaction_type = 'DEBIT'
                            THEN -t.amount
                    END
                )

                FROM interest_transactions t

                WHERE t.account_id = a.account_id
                  AND DATE(t.transaction_date) <= d.calendar_date
            ),
            0
        ) AS closing_balance

    FROM interest_accounts a
    CROSS JOIN date_range d
)

SELECT
    account_id,
    calendar_date,
    closing_balance,

    CASE
        WHEN closing_balance <= 50000 THEN 3
        WHEN closing_balance <= 200000 THEN 5
        ELSE 6.5
    END AS interest_rate,

    ROUND(
        closing_balance *
        CASE
            WHEN closing_balance <= 50000 THEN 3
            WHEN closing_balance <= 200000 THEN 5
            ELSE 6.5
        END
        / 100
        / 365,
        6
    ) AS daily_interest

FROM daily_balances;

select * 
from daily_interest_3 
order by account_id,calendar_date asc;
-- ********************************************************





CREATE TABLE current_monthly_interest (
    interest_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    interest_month DATE NOT NULL,
    monthly_interest DECIMAL(12,2) NOT NULL,
    calculated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (account_id)
        REFERENCES interest_accounts(account_id),

    UNIQUE (account_id, interest_month)
);
INSERT INTO current_monthly_interest
(
    account_id,
    interest_month,
    monthly_interest
)
SELECT
    account_id,

    STR_TO_DATE(
        DATE_FORMAT(calendar_date, '%Y-%m-01'),
        '%Y-%m-%d'
    ) AS interest_month,

    ROUND(SUM(daily_interest), 2) AS monthly_interest

FROM daily_interest_3

WHERE calendar_date BETWEEN '2026-07-01' AND '2026-07-31'

GROUP BY
    account_id,
    STR_TO_DATE(
        DATE_FORMAT(calendar_date, '%Y-%m-01'),
        '%Y-%m-%d'
    );
    
select * from current_monthly_interest;






-- **************************************
-- Insert the backdated transaction
INSERT INTO interest_transactions
(
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_date
)
VALUES
(
    136,
    2003,
    'CREDIT',
    60000.00,
    '2026-07-10 10:00:00'
);


-- *********************************************



SELECT
    account_id,
    ROUND(SUM(daily_interest), 2) AS new_monthly_interest

FROM daily_interest_3

WHERE calendar_date BETWEEN '2026-07-01' AND '2026-07-31'
  AND account_id = 2003

GROUP BY account_id;
-- ************************************************




SELECT
    c.account_id,
    c.interest_month,

    c.monthly_interest AS old_interest,

    n.new_interest,

    ROUND(
        n.new_interest - c.monthly_interest,
        2
    ) AS adjustment_amount

FROM current_monthly_interest c

JOIN
(
    SELECT
        account_id,
        ROUND(SUM(daily_interest), 2) AS new_interest

    FROM daily_interest_3

    WHERE calendar_date BETWEEN '2026-07-01' AND '2026-07-31'
      AND account_id = 2003

    GROUP BY account_id

) n
    ON c.account_id = n.account_id

WHERE c.account_id = 2003
  AND c.interest_month = '2026-07-01';
  
  
  
  
  
  
  -- *************************************************
  INSERT INTO interest_adjustments
(
    account_id,
    interest_month,
    old_interest,
    new_interest,
    adjustment_amount,
    reason
)

SELECT
    c.account_id,
    c.interest_month,
    c.monthly_interest AS old_interest,
    n.new_interest,

    ROUND(
        n.new_interest - c.monthly_interest,
        2
    ) AS adjustment_amount,

    'Backdated transaction recalculation'

FROM current_monthly_interest c

JOIN
(
    SELECT
        account_id,
        ROUND(SUM(daily_interest), 2) AS new_interest

    FROM daily_interest_3

    WHERE calendar_date BETWEEN '2026-07-01' AND '2026-07-31'
      AND account_id = 2003

    GROUP BY account_id

) n
    ON c.account_id = n.account_id

WHERE c.account_id = 2003
  AND c.interest_month = '2026-07-01';
  
SELECT *
FROM interest_adjustments;


-- ************************************************
-- Update the current monthly interest
UPDATE current_monthly_interest c

JOIN
(
    SELECT
        account_id,
        ROUND(SUM(daily_interest), 2) AS new_interest

    FROM daily_interest_3

    WHERE calendar_date BETWEEN '2026-07-01' AND '2026-07-31'
      AND account_id = 2003

    GROUP BY account_id

) n
    ON c.account_id = n.account_id

SET
    c.monthly_interest = n.new_interest,
    c.calculated_at = CURRENT_TIMESTAMP

WHERE c.account_id = 2003
  AND c.interest_month = '2026-07-01';
-- Banking / Payments Fraud Detection
-- Assume:
-- accounts, transactions, cards, card_transactions, branches, cities
--  Fraud / Suspicious Transaction Pattern


-- Tasks:
-- Detect cards that have more than 5 transactions within 10 minutes with total amount > 50,000.

-- Find cards used in two different cities within 30 minutes (impossible travel).

-- Create a table fraud_alerts and insert suspicious cases.


-- Concepts: self-joins, time window logic, grouping by card/time, window functions.

-- *************************************************************************************************************************************************************************
create database day_27;
use day_27;
CREATE TABLE cities_27 (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    state_name VARCHAR(100) NOT NULL
);
INSERT INTO cities_27
(city_id, city_name, state_name)
VALUES
(1, 'Hyderabad', 'Telangana'),
(2, 'Bengaluru', 'Karnataka'),
(3, 'Chennai', 'Tamil Nadu'),
(4, 'Mumbai', 'Maharashtra'),
(5, 'Delhi', 'Delhi'),
(6, 'Pune', 'Maharashtra'),
(7, 'Vijayawada', 'Andhra Pradesh'),
(8, 'Kolkata', 'West Bengal');
-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE TABLE branches_27 (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city_id INT NOT NULL,

    FOREIGN KEY (city_id)
        REFERENCES cities_27(city_id)
);
INSERT INTO branches_27
(branch_id, branch_name, city_id)
VALUES
(101, 'Hyderabad Main Branch', 1),
(102, 'Hitech City Branch', 1),
(103, 'Bengaluru MG Road Branch', 2),
(104, 'Bengaluru Whitefield Branch', 2),
(105, 'Chennai Central Branch', 3),
(106, 'Mumbai Andheri Branch', 4),
(107, 'Delhi Connaught Branch', 5),
(108, 'Pune Central Branch', 6),
(109, 'Vijayawada Main Branch', 7),
(110, 'Kolkata Park Street Branch', 8);
-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE TABLE accounts_27 (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    branch_id INT NOT NULL,
    balance DECIMAL(12,2) NOT NULL,

    FOREIGN KEY (branch_id)
        REFERENCES branches_27(branch_id)
);
INSERT INTO accounts_27
(account_id, customer_name, account_type, branch_id, balance)
VALUES
(1001, 'Rahul Sharma', 'SAVINGS', 101, 150000.00),
(1002, 'Priya Reddy', 'SAVINGS', 103, 220000.00),
(1003, 'Arjun Kumar', 'CURRENT', 105, 500000.00),
(1004, 'Sneha Rao', 'SAVINGS', 106, 175000.00),
(1005, 'Vikram Singh', 'SAVINGS', 107, 300000.00),
(1006, 'Ananya Patel', 'CURRENT', 108, 450000.00),
(1007, 'Kiran Reddy', 'SAVINGS', 109, 125000.00),
(1008, 'Meera Nair', 'SAVINGS', 110, 275000.00),
(1009, 'Rohit Verma', 'SAVINGS', 102, 180000.00),
(1010, 'Divya Menon', 'CURRENT', 104, 600000.00);
-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE TABLE transactions_27 (
    transaction_id INT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_type ENUM('CREDIT', 'DEBIT') NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    transaction_time DATETIME NOT NULL,

    FOREIGN KEY (account_id)
        REFERENCES accounts_27(account_id)
);
INSERT INTO transactions_27
(transaction_id, account_id, transaction_type, amount, transaction_time)
VALUES

(1, 1001, 'CREDIT', 50000.00, '2026-08-10 09:00:00'),
(2, 1001, 'DEBIT', 10000.00, '2026-08-10 10:30:00'),
(3, 1002, 'CREDIT', 75000.00, '2026-08-10 11:00:00'),
(4, 1002, 'DEBIT', 15000.00, '2026-08-10 12:15:00'),
(5, 1003, 'CREDIT', 120000.00, '2026-08-10 13:00:00'),
(6, 1003, 'DEBIT', 25000.00, '2026-08-10 14:30:00'),
(7, 1004, 'CREDIT', 40000.00, '2026-08-10 15:00:00'),
(8, 1004, 'DEBIT', 12000.00, '2026-08-10 16:00:00'),
(9, 1005, 'CREDIT', 90000.00, '2026-08-10 17:00:00'),
(10, 1005, 'DEBIT', 20000.00, '2026-08-10 18:00:00'),
(11, 1006, 'CREDIT', 150000.00, '2026-08-11 09:00:00'),
(12, 1006, 'DEBIT', 30000.00, '2026-08-11 10:00:00'),
(13, 1007, 'CREDIT', 60000.00, '2026-08-11 11:00:00'),
(14, 1008, 'CREDIT', 80000.00, '2026-08-11 12:00:00'),
(15, 1009, 'DEBIT', 15000.00, '2026-08-11 13:00:00'),
(16, 1010, 'CREDIT', 200000.00, '2026-08-11 14:00:00');
-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE TABLE cards_27 (
    card_id INT PRIMARY KEY,
    account_id INT NOT NULL,
    card_number VARCHAR(20) NOT NULL,
    card_type VARCHAR(20) NOT NULL,
    card_status VARCHAR(20) NOT NULL,

    FOREIGN KEY (account_id)
        REFERENCES accounts_27(account_id)
);
INSERT INTO cards_27
(card_id, account_id, card_number, card_type, card_status)
VALUES
(201, 1001, '**** **** **** 1001', 'DEBIT', 'ACTIVE'),
(202, 1002, '**** **** **** 1002', 'CREDIT', 'ACTIVE'),
(203, 1003, '**** **** **** 1003', 'DEBIT', 'ACTIVE'),
(204, 1004, '**** **** **** 1004', 'CREDIT', 'ACTIVE'),
(205, 1005, '**** **** **** 1005', 'DEBIT', 'ACTIVE'),
(206, 1006, '**** **** **** 1006', 'CREDIT', 'ACTIVE'),
(207, 1007, '**** **** **** 1007', 'DEBIT', 'ACTIVE'),
(208, 1008, '**** **** **** 1008', 'DEBIT', 'ACTIVE'),
(209, 1009, '**** **** **** 1009', 'CREDIT', 'ACTIVE'),
(210, 1010, '**** **** **** 1010', 'DEBIT', 'ACTIVE');
-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE TABLE card_transactions_27 (
    card_transaction_id INT PRIMARY KEY,
    card_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    transaction_time DATETIME NOT NULL,
    city_id INT NOT NULL,
    merchant_name VARCHAR(100) NOT NULL,

    FOREIGN KEY (card_id)
        REFERENCES cards_27(card_id),

    FOREIGN KEY (city_id)
        REFERENCES cities_27(city_id)
);
INSERT INTO card_transactions_27
(card_transaction_id, card_id, amount, transaction_time, city_id, merchant_name)
VALUES

(1, 201, 5000.00, '2026-08-12 09:00:00', 1, 'Amazon'),
(2, 201, 2500.00, '2026-08-12 10:30:00', 1, 'Flipkart'),
(3, 201, 3500.00, '2026-08-12 12:00:00', 1, 'Myntra'),
(4, 201, 2000.00, '2026-08-12 14:00:00', 1, 'Swiggy'),
(5, 201, 4500.00, '2026-08-12 16:00:00', 1, 'BookMyShow');
INSERT INTO card_transactions_27
(card_transaction_id, card_id, amount, transaction_time, city_id, merchant_name)
VALUES

(6, 202, 10000.00, '2026-08-12 11:00:00', 2, 'Amazon'),
(7, 202, 9000.00, '2026-08-12 11:01:00', 2, 'Flipkart'),
(8, 202, 12000.00, '2026-08-12 11:03:00', 2, 'Myntra'),
(9, 202, 11000.00, '2026-08-12 11:05:00', 2, 'Croma'),
(10, 202, 8000.00, '2026-08-12 11:07:00', 2, 'Reliance Digital'),
(11, 202, 7000.00, '2026-08-12 11:09:00', 2, 'Apple Store');
INSERT INTO card_transactions_27
(card_transaction_id, card_id, amount, transaction_time, city_id, merchant_name)
VALUES

(12, 203, 15000.00, '2026-08-12 10:00:00', 1, 'Amazon'),

(13, 203, 18000.00, '2026-08-12 10:20:00', 4, 'Apple Store'),

(14, 203, 5000.00, '2026-08-12 13:00:00', 4, 'Swiggy');
INSERT INTO card_transactions_27
(card_transaction_id, card_id, amount, transaction_time, city_id, merchant_name)
VALUES

(15, 204, 12000.00, '2026-08-12 14:00:00', 3, 'Amazon'),
(16, 204, 10000.00, '2026-08-12 14:01:00', 3, 'Flipkart'),
(17, 204, 9000.00, '2026-08-12 14:03:00', 3, 'Myntra'),
(18, 204, 11000.00, '2026-08-12 14:05:00', 3, 'Croma'),
(19, 204, 10000.00, '2026-08-12 14:07:00', 3, 'Reliance Digital'),
(20, 204, 9000.00, '2026-08-12 14:09:00', 3, 'Apple Store');
INSERT INTO card_transactions_27
(card_transaction_id, card_id, amount, transaction_time, city_id, merchant_name)
VALUES

(21, 204, 15000.00, '2026-08-12 14:25:00', 4, 'Amazon');
INSERT INTO card_transactions_27
(card_transaction_id, card_id, amount, transaction_time, city_id, merchant_name)
VALUES

(22, 205, 3000.00, '2026-08-12 09:00:00', 5, 'Amazon'),
(23, 205, 4500.00, '2026-08-12 11:00:00', 5, 'Flipkart'),
(24, 205, 2000.00, '2026-08-12 14:00:00', 5, 'Swiggy'),
(25, 205, 5000.00, '2026-08-12 18:00:00', 5, 'Myntra');
INSERT INTO card_transactions_27
(card_transaction_id, card_id, amount, transaction_time, city_id, merchant_name)
VALUES

(26, 206, 4000.00, '2026-08-12 09:30:00', 6, 'Amazon'),
(27, 206, 6000.00, '2026-08-12 12:30:00', 6, 'Flipkart'),

(28, 207, 3500.00, '2026-08-12 10:00:00', 7, 'Myntra'),
(29, 207, 2500.00, '2026-08-12 15:00:00', 7, 'Swiggy'),

(30, 208, 7000.00, '2026-08-12 11:00:00', 8, 'Amazon'),
(31, 208, 5000.00, '2026-08-12 17:00:00', 8, 'Croma'),

(32, 209, 4500.00, '2026-08-12 09:00:00', 2, 'Flipkart'),
(33, 209, 3500.00, '2026-08-12 13:00:00', 2, 'Myntra'),

(34, 210, 6000.00, '2026-08-12 10:00:00', 1, 'Amazon'),
(35, 210, 8000.00, '2026-08-12 16:00:00', 1, 'Apple Store');
-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE TABLE fraud_alerts_27 (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    card_id INT NOT NULL,
    alert_type VARCHAR(50) NOT NULL,
    transaction_count INT NULL,
    total_amount DECIMAL(12,2) NULL,
    city_1 VARCHAR(100) NULL,
    city_2 VARCHAR(100) NULL,
    transaction_time_1 DATETIME NULL,
    transaction_time_2 DATETIME NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (card_id)
        REFERENCES cards_27(card_id)
);
-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
-- Detect cards that have more than 5 transactions within 10 minutes with total amount > 50,000.
select * from card_transactions_27;

SELECT
    t1.card_id,
    t1.transaction_time AS window_start,

    COUNT(DISTINCT t1.card_transaction_id)
        + COUNT(DISTINCT t2.card_transaction_id)
        AS transaction_count,

    t1.amount + SUM(t2.amount) AS total_amount

FROM card_transactions_27 t1
JOIN card_transactions_27 t2
    ON t1.card_id = t2.card_id
    AND t1.card_transaction_id <> t2.card_transaction_id
    AND TIMESTAMPDIFF(
        MINUTE,
        t1.transaction_time,
        t2.transaction_time
    ) BETWEEN 1 AND 10

GROUP BY
    t1.card_id,
    t1.transaction_time,
    t1.amount

HAVING
    COUNT(DISTINCT t1.card_transaction_id)
        + COUNT(DISTINCT t2.card_transaction_id) > 5
    AND
    t1.amount + SUM(t2.amount) > 50000;
    
-- ****************************************************************************************
-- Same Card, Different Cities Within 30 Minutes

SELECT
    t1.card_id,
    max(t1.transaction_time) AS time_1,
    max(t2.transaction_time) AS time_2,
    t1.city_id AS city_1,
    t2.city_id AS city_2

FROM card_transactions_27 t1

JOIN card_transactions_27 t2
    ON t1.card_id = t2.card_id
    AND t1.city_id <> t2.city_id
    AND t1.transaction_time < t2.transaction_time
    AND TIMESTAMPDIFF(
        MINUTE,
        t1.transaction_time,
        t2.transaction_time
    ) BETWEEN 0 AND 30
GROUP BY
    t1.card_id,
    t1.city_id,
    t2.city_id;
    
-- ********************************************************************************************
-- Insert Fraud Alerts

DELIMITER $$

CREATE PROCEDURE sp_detect_fraud()
BEGIN

    -- =========================================
    -- TASK 1: TRANSACTION BURST
    -- =========================================

    INSERT INTO fraud_alerts_27
    (
        card_id,
        alert_type,
        transaction_count,
        total_amount,
        transaction_time_1
    )

    SELECT
        t1.card_id,
        'TRANSACTION_BURST',

        COUNT(DISTINCT t1.card_transaction_id)
        +
        COUNT(DISTINCT t2.card_transaction_id)
        AS transaction_count,

        t1.amount + SUM(t2.amount)
        AS total_amount,

        t1.transaction_time

    FROM card_transactions_27 t1

    JOIN card_transactions_27 t2
        ON t1.card_id = t2.card_id

        AND t1.card_transaction_id <> t2.card_transaction_id

        AND TIMESTAMPDIFF(
            MINUTE,
            t1.transaction_time,
            t2.transaction_time
        ) BETWEEN 1 AND 10

    GROUP BY
        t1.card_id,
        t1.transaction_time,
        t1.amount

    HAVING
        COUNT(DISTINCT t1.card_transaction_id)
        +
        COUNT(DISTINCT t2.card_transaction_id) > 5

        AND

        t1.amount + SUM(t2.amount) > 50000;


    -- =========================================
    -- TASK 2: IMPOSSIBLE TRAVEL
    -- =========================================

    INSERT INTO fraud_alerts_27
    (
        card_id,
        alert_type,
        city_1,
        city_2,
        transaction_time_1,
        transaction_time_2
    )

    SELECT
        t1.card_id,
        'IMPOSSIBLE_TRAVEL',

        t1.city_id,
        t2.city_id,

        MAX(t1.transaction_time),
        MAX(t2.transaction_time)

    FROM card_transactions_27 t1

    JOIN card_transactions_27 t2
        ON t1.card_id = t2.card_id

        AND t1.city_id <> t2.city_id

        AND t1.transaction_time < t2.transaction_time

        AND TIMESTAMPDIFF(
            MINUTE,
            t1.transaction_time,
            t2.transaction_time
        ) BETWEEN 0 AND 30

    GROUP BY
        t1.card_id,
        t1.city_id,
        t2.city_id;

END $$

DELIMITER ;


CALL sp_detect_fraud();

SELECT *
FROM fraud_alerts_27;
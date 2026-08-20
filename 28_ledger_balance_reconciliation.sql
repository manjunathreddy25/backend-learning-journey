create database ledger_balance_reconciliation;
use ledger_balance_reconciliation;
-- *****************************************************************************************************************************************************************************
-- Ledger vs Balance Reconciliation
-- Assume accounts(current_balance) and transactions(account_id, amount, type, txn_date).


-- Tasks:
-- Recalculate balance for each account from transaction history.

-- Compare it to current_balance and find mismatch accounts.

-- For mismatches, generate a statement showing transactions from last mismatch-free date.


-- Concepts: running totals, SUM with partition, reconciliation queries.
-- @backend guys 
-- **************************************************************************************************************************************************************************
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    current_balance DECIMAL(12,2) NOT NULL
);
INSERT INTO accounts
(account_id, customer_name, account_type, current_balance)
VALUES
(1001, 'Rahul Sharma', 'SAVINGS', 85000.00),
(1002, 'Priya Reddy', 'SAVINGS', 120000.00),
(1003, 'Arjun Kumar', 'CURRENT', 250000.00),
(1004, 'Sneha Rao', 'SAVINGS', 67500.00),
(1005, 'Vikram Singh', 'SAVINGS', 95000.00),
(1006, 'Ananya Patel', 'CURRENT', 180000.00),
(1007, 'Kiran Reddy', 'SAVINGS', 42000.00),
(1008, 'Meera Nair', 'SAVINGS', 150000.00),
(1009, 'Rohit Verma', 'SAVINGS', 73000.00),
(1010, 'Divya Menon', 'CURRENT', 210000.00);
-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    type ENUM('CREDIT', 'DEBIT') NOT NULL,
    txn_date DATETIME NOT NULL,

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);
INSERT INTO transactions
(transaction_id, account_id, amount, type, txn_date)
VALUES

-- =========================================
-- ACCOUNT 1001
-- =========================================

(1, 1001, 50000.00, 'CREDIT', '2026-07-01 09:00:00'),
(2, 1001, 10000.00, 'DEBIT',  '2026-07-05 10:30:00'),
(3, 1001, 25000.00, 'CREDIT', '2026-07-10 11:00:00'),
(4, 1001, 5000.00,  'DEBIT',  '2026-07-15 14:00:00'),
(5, 1001, 25000.00, 'CREDIT', '2026-08-01 09:30:00'),

-- =========================================
-- ACCOUNT 1002
-- =========================================

(6, 1002, 100000.00, 'CREDIT', '2026-07-01 09:15:00'),
(7, 1002, 15000.00,  'DEBIT',  '2026-07-04 11:00:00'),
(8, 1002, 30000.00,  'CREDIT', '2026-07-12 12:30:00'),
(9, 1002, 10000.00,  'DEBIT',  '2026-07-20 15:00:00'),
(10, 1002, 15000.00, 'CREDIT', '2026-08-03 10:00:00'),

-- =========================================
-- ACCOUNT 1003
-- =========================================

(11, 1003, 200000.00, 'CREDIT', '2026-07-01 09:00:00'),
(12, 1003, 25000.00,  'DEBIT',  '2026-07-03 10:00:00'),
(13, 1003, 50000.00,  'CREDIT', '2026-07-10 13:00:00'),
(14, 1003, 10000.00,  'DEBIT',  '2026-07-18 16:00:00'),
(15, 1003, 35000.00,  'DEBIT',  '2026-08-05 11:30:00'),

-- =========================================
-- ACCOUNT 1004
-- =========================================

(16, 1004, 70000.00, 'CREDIT', '2026-07-02 09:00:00'),
(17, 1004, 5000.00,  'DEBIT',  '2026-07-06 12:00:00'),
(18, 1004, 10000.00, 'CREDIT', '2026-07-15 14:00:00'),
(19, 1004, 2500.00,  'DEBIT',  '2026-07-25 10:00:00'),
(20, 1004, 5000.00,  'DEBIT',  '2026-08-04 09:30:00'),

-- =========================================
-- ACCOUNT 1005
-- =========================================

(21, 1005, 80000.00, 'CREDIT', '2026-07-01 08:30:00'),
(22, 1005, 10000.00, 'DEBIT',  '2026-07-05 11:00:00'),
(23, 1005, 20000.00, 'CREDIT', '2026-07-11 12:00:00'),
(24, 1005, 5000.00,  'DEBIT',  '2026-07-20 14:30:00'),
(25, 1005, 10000.00, 'CREDIT', '2026-08-02 10:00:00'),

-- =========================================
-- ACCOUNT 1006
-- =========================================

(26, 1006, 150000.00, 'CREDIT', '2026-07-01 09:00:00'),
(27, 1006, 20000.00,  'DEBIT',  '2026-07-04 10:30:00'),
(28, 1006, 50000.00,  'CREDIT', '2026-07-14 13:00:00'),
(29, 1006, 10000.00,  'DEBIT',  '2026-07-25 15:00:00'),
(30, 1006, 10000.00,  'CREDIT', '2026-08-05 11:00:00'),

-- =========================================
-- ACCOUNT 1007
-- =========================================

(31, 1007, 50000.00, 'CREDIT', '2026-07-02 09:30:00'),
(32, 1007, 5000.00,  'DEBIT',  '2026-07-05 11:30:00'),
(33, 1007, 10000.00, 'CREDIT', '2026-07-15 12:00:00'),
(34, 1007, 3000.00,  'DEBIT',  '2026-07-25 14:00:00'),
(35, 1007, 5000.00,  'DEBIT',  '2026-08-06 10:00:00'),

-- =========================================
-- ACCOUNT 1008
-- =========================================

(36, 1008, 120000.00, 'CREDIT', '2026-07-01 08:00:00'),
(37, 1008, 15000.00,  'DEBIT',  '2026-07-05 09:30:00'),
(38, 1008, 30000.00,  'CREDIT', '2026-07-12 11:00:00'),
(39, 1008, 10000.00,  'DEBIT',  '2026-07-20 15:00:00'),
(40, 1008, 25000.00,  'CREDIT', '2026-08-03 10:30:00'),

-- =========================================
-- ACCOUNT 1009
-- =========================================

(41, 1009, 60000.00, 'CREDIT', '2026-07-01 09:00:00'),
(42, 1009, 5000.00,  'DEBIT',  '2026-07-04 11:00:00'),
(43, 1009, 15000.00, 'CREDIT', '2026-07-15 12:00:00'),
(44, 1009, 2000.00,  'DEBIT',  '2026-07-25 14:00:00'),
(45, 1009, 5000.00,  'CREDIT', '2026-08-04 10:00:00'),

-- =========================================
-- ACCOUNT 1010
-- =========================================

(46, 1010, 200000.00, 'CREDIT', '2026-07-01 08:30:00'),
(47, 1010, 20000.00,  'DEBIT',  '2026-07-05 10:00:00'),
(48, 1010, 50000.00,  'CREDIT', '2026-07-15 11:30:00'),
(49, 1010, 15000.00,  'DEBIT',  '2026-07-25 13:00:00'),
(50, 1010, 5000.00,  'CREDIT', '2026-08-05 09:00:00');
-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

-- Recalculate balance for each account from transaction history.
CREATE VIEW ledger_balances AS
SELECT
    account_id,
    SUM(
        CASE
            WHEN type = 'CREDIT' THEN amount
            WHEN type = 'DEBIT' THEN -amount
        END
    ) AS calculated_balance
FROM transactions
GROUP BY account_id;


SELECT *
FROM ledger_balances;


-- -- Compare it to current_balance and find mismatch accounts.
SELECT
    a.account_id,
    a.current_balance,
    lb.calculated_balance
FROM accounts a
JOIN ledger_balances lb
    ON a.account_id = lb.account_id
WHERE a.current_balance <> lb.calculated_balance;


-- For mismatches, generate a statement showing transactions from last mismatch-free date.
CREATE TABLE account_balance_snapshots (
    snapshot_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    snapshot_date DATE NOT NULL,
    verified_balance DECIMAL(12,2) NOT NULL,

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);
INSERT INTO account_balance_snapshots
(account_id, snapshot_date, verified_balance)
VALUES

-- =========================================
-- ACCOUNT 1001 → MISMATCH ❌
-- Actual Jul 15 balance = 60,000
-- We store 70,000
-- =========================================

(1001, '2026-07-01', 50000.00),
(1001, '2026-07-05', 40000.00),
(1001, '2026-07-10', 65000.00),
(1001, '2026-07-15', 70000.00),   -- ❌ WRONG


-- =========================================
-- ACCOUNT 1002 → MATCH ✅
-- =========================================

(1002, '2026-07-01', 100000.00),
(1002, '2026-07-04', 85000.00),
(1002, '2026-07-12', 115000.00),
(1002, '2026-07-20', 105000.00),


-- =========================================
-- ACCOUNT 1003 → MISMATCH ❌
-- Actual Jul 10 balance = 225,000
-- We store 230,000
-- =========================================

(1003, '2026-07-01', 200000.00),
(1003, '2026-07-03', 175000.00),
(1003, '2026-07-10', 230000.00),   -- ❌ WRONG


-- =========================================
-- ACCOUNT 1004 → MATCH ✅
-- =========================================

(1004, '2026-07-02', 70000.00),
(1004, '2026-07-06', 65000.00),
(1004, '2026-07-15', 75000.00),


-- =========================================
-- ACCOUNT 1005 → MATCH ✅
-- =========================================

(1005, '2026-07-01', 80000.00),
(1005, '2026-07-05', 70000.00),
(1005, '2026-07-11', 90000.00),


-- =========================================
-- ACCOUNT 1006 → MATCH ✅
-- =========================================

(1006, '2026-07-01', 150000.00),
(1006, '2026-07-04', 130000.00),
(1006, '2026-07-14', 180000.00),


-- =========================================
-- ACCOUNT 1007 → MISMATCH ❌
-- Actual Jul 15 balance = 52,000
-- We store 60,000
-- =========================================

(1007, '2026-07-02', 50000.00),
(1007, '2026-07-05', 45000.00),
(1007, '2026-07-15', 60000.00),   -- ❌ WRONG


-- =========================================
-- ACCOUNT 1008 → MATCH ✅
-- =========================================

(1008, '2026-07-01', 120000.00),
(1008, '2026-07-05', 105000.00),
(1008, '2026-07-12', 135000.00),


-- =========================================
-- ACCOUNT 1009 → MATCH ✅
-- =========================================

(1009, '2026-07-01', 60000.00),
(1009, '2026-07-04', 55000.00),
(1009, '2026-07-15', 68000.00),


-- =========================================
-- ACCOUNT 1010 → MISMATCH ❌
-- Actual Jul 15 balance = 215,000
-- We store 230,000
-- =========================================

(1010, '2026-07-01', 200000.00),
(1010, '2026-07-05', 180000.00),
(1010, '2026-07-15', 230000.00);   -- ❌ WRONG



CREATE VIEW reconciliation AS

WITH running AS
(
    SELECT
        t.account_id,
        t.transaction_id,
        t.txn_date,
        t.type,
        t.amount,

        SUM(
            CASE
                WHEN t.type = 'CREDIT' THEN t.amount
                WHEN t.type = 'DEBIT' THEN -t.amount
            END
        ) OVER (
            PARTITION BY t.account_id
            ORDER BY t.txn_date
        ) AS running_balance,

        s.verified_balance

    FROM transactions t

    JOIN account_balance_snapshots s
        ON t.account_id = s.account_id
        AND DATE(t.txn_date) = s.snapshot_date
)

SELECT
    account_id,
    transaction_id,
    txn_date,
    type,
    amount,
    running_balance,
    verified_balance,

    CASE
        WHEN running_balance = verified_balance
        THEN 'MATCH'
        ELSE 'MISMATCH'
    END AS status

FROM running;
-- ******************************************************
SELECT *
FROM reconciliation;
-- ******************************************************
SELECT
    r.account_id,
    r.transaction_id,
    r.txn_date,
    r.type,
    r.amount,
    r.running_balance,
    r.verified_balance,
    r.status,
    lm.last_mismatch_free_date

FROM reconciliation r

JOIN
(
    SELECT
        account_id,
        MAX(DATE(txn_date)) AS last_mismatch_free_date

    FROM reconciliation

    WHERE status = 'MATCH'

    GROUP BY account_id

) lm

ON r.account_id = lm.account_id

WHERE
    r.status = 'MISMATCH'
    AND DATE(r.txn_date) > lm.last_mismatch_free_date

ORDER BY
    r.account_id,
    r.txn_date;
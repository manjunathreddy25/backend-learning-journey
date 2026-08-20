create database day_19;
use day_19;


-- ==========================================================================================================================================================================
-- 
CREATE TABLE bank_transactions (

    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_number VARCHAR(20),
    customer_name VARCHAR(50),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    balance DECIMAL(10,2),
    transaction_date DATE

);
INSERT INTO bank_transactions
(account_number, customer_name, transaction_type, amount, balance, transaction_date)

VALUES

('ACC1001','Rahul','Deposit',5000,25000,'2026-07-01'),
('ACC1002','Priya','Withdraw',3000,17000,'2026-07-02'),
('ACC1003','Kiran','Deposit',10000,55000,'2026-07-03'),
('ACC1004','Sneha','Withdraw',2000,28000,'2026-07-04'),
('ACC1005','Arjun','Deposit',7000,42000,'2026-07-05');

CREATE TABLE transaction_audit (

    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_id INT,
    action_type VARCHAR(20),
    old_balance DECIMAL(10,2),
    new_balance DECIMAL(10,2),
    audit_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);
-- BEFORE INSERT TRIGGER
DELIMITER //

CREATE TRIGGER check_amount

BEFORE INSERT

ON bank_transactions

FOR EACH ROW

BEGIN

    IF NEW.amount < 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Amount cannot be negative';

    END IF;

END //

DELIMITER ;
-- AFTER INSERT TRIGGER
DELIMITER //

CREATE TRIGGER after_transaction_insert

AFTER INSERT

ON bank_transactions

FOR EACH ROW

BEGIN

    INSERT INTO transaction_audit
    (
        transaction_id,
        action_type,
        old_balance,
        new_balance
    )

    VALUES
    (
        NEW.transaction_id,
        'INSERT',
        NULL,
        NEW.balance
    );

END //

DELIMITER ;
INSERT INTO bank_transactions
(account_number, customer_name, transaction_type, amount, balance, transaction_date)
VALUES
('ACC1006','Manoj','Deposit',-9000,60000,'2026-07-10');


SELECT * FROM transaction_audit;
-- ********************************************************************************************************
-- BEFORE UPDATE TRIGGER
DELIMITER //

CREATE TRIGGER check_balance

BEFORE UPDATE

ON bank_transactions

FOR EACH ROW

BEGIN

    IF NEW.balance < 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Balance cannot be negative';

    END IF;

END //

DELIMITER ;
-- AFTER UPDATE TRIGGER
DELIMITER //

CREATE TRIGGER after_transaction_update

AFTER UPDATE

ON bank_transactions

FOR EACH ROW

BEGIN

    INSERT INTO transaction_audit
    (
        transaction_id,
        action_type,
        old_balance,
        new_balance
    )

    VALUES
    (
        NEW.transaction_id,
        'UPDATE',
        OLD.balance,
        NEW.balance
    );

END //

DELIMITER ;
UPDATE bank_transactions

SET balance = 150000

WHERE transaction_id = 3;

SELECT * FROM transaction_audit;
-- *******************************************************************************
-- BEFORE DELETE TRIGGER
DELIMITER //

CREATE TRIGGER prevent_delete

BEFORE DELETE

ON bank_transactions

FOR EACH ROW

BEGIN

    IF OLD.balance > 100000 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete high value transaction';

    END IF;

END //

DELIMITER ;
-- AFTER DELETE TRIGGER
DELIMITER //

CREATE TRIGGER after_transaction_delete

AFTER DELETE

ON bank_transactions

FOR EACH ROW

BEGIN

    INSERT INTO transaction_audit
    (
        transaction_id,
        action_type,
        old_balance,
        new_balance
    )

    VALUES
    (
        OLD.transaction_id,
        'DELETE',
        OLD.balance,
        NULL
    );

END //

DELIMITER ;
DELETE FROM bank_transactions
WHERE transaction_id = 2;


SELECT * FROM transaction_audit;



-- ****************************************************************************************
-- EXAMPLES

-- Update Another Table Automatically
CREATE TABLE accounts
(
    account_no VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(50),
    balance DECIMAL(10,2)
);
INSERT INTO accounts
VALUES
('ACC101','Rahul',20000),
('ACC102','Priya',30000),
('ACC103','Kiran',15000);
CREATE TABLE transactions
(
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_no VARCHAR(20),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2)
);
DELIMITER //

CREATE TRIGGER update_account_balance

AFTER INSERT

ON transactions

FOR EACH ROW

BEGIN

    UPDATE accounts

    SET balance = balance + NEW.amount

    WHERE account_no = NEW.account_no;

END //

DELIMITER ;

INSERT INTO transactions
(account_no,transaction_type,amount)

VALUES

('ACC101','Deposit',5000);
-- *******************************************************
-- Inventory Management Trigger
CREATE TABLE products19
(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    stock INT,
    price DECIMAL(10,2)
);
INSERT INTO products19
(product_name,stock,price)

VALUES

('Laptop',20,65000),
('Mobile',50,30000),
('Keyboard',40,1200),
('Mouse',30,800);
CREATE TABLE orders19
(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT
);
DELIMITER //

CREATE TRIGGER check_stock

BEFORE INSERT

ON orders19

FOR EACH ROW

BEGIN

    DECLARE available_stock INT;

    SELECT stock
    INTO available_stock
    FROM products19
    WHERE product_id = NEW.product_id;

    IF available_stock < NEW.quantity THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock';

    END IF;

END //

DELIMITER ;
DELIMITER //

CREATE TRIGGER reduce_stock

AFTER INSERT

ON orders19

FOR EACH ROW

BEGIN

    UPDATE products19

    SET stock = stock - NEW.quantity

    WHERE product_id = NEW.product_id;

END //

DELIMITER ;
INSERT INTO orders19
(product_id,quantity)
VALUES
(1,2);

-- ******************************************************************
-- Generate Notifications
CREATE TABLE transactions19
(
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    amount DECIMAL(10,2)
);
CREATE TABLE notifications
(
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    message VARCHAR(200)
);
DELIMITER //

CREATE TRIGGER generate_notification

AFTER INSERT

ON transactions19

FOR EACH ROW

BEGIN

    INSERT INTO notifications
    (
        customer_name,
        message
    )

    VALUES
    (
        NEW.customer_name,
        CONCAT('₹',NEW.amount,' deposited successfully.')
    );

END //

DELIMITER ;
INSERT INTO transactions19
(customer_name,amount)
VALUES
('Rahul',5000);
-- ************************************************************************************
-- Automatic Timestamp
CREATE TABLE employees19
(
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50),
    salary INT,
    last_updated DATETIME
);
INSERT INTO employees19

(emp_name,salary)

VALUES

('Rahul',50000);
DELIMITER //

CREATE TRIGGER update_timestamp

BEFORE UPDATE

ON employees19

FOR EACH ROW

BEGIN

    SET NEW.last_updated = NOW();

END //

DELIMITER ;
UPDATE employees19
SET salary = 55000
WHERE emp_id = 1;
/*
-- Modern  MYSQL Timestamp record!
last_updated TIMESTAMP
DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP 
*/
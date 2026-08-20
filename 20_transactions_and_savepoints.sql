create database day_20;
use day_20;

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
SELECT @@autocommit;
SET autocommit = 0;
-- **********************************************************************
CREATE TABLE accounts20
(
    id int primary key auto_increment,
    account_no VARCHAR(20),
    customer_name VARCHAR(50),
    balance DECIMAL(10,2)
);
DELIMITER //

CREATE TRIGGER trg_account
BEFORE INSERT
ON accounts20
FOR EACH ROW
BEGIN
    SET NEW.account_no = CONCAT('ACC', FLOOR(RAND() * 900 + 100));
END //

DELIMITER ;
INSERT INTO accounts20(customer_name,balance)
VALUES
('Naruto',50000),
('Hinata',30000);
 
SELECT * FROM accounts20;
-- ***********************************************************************
-- COMMIT
SET SQL_SAFE_UPDATES = 0;

start transaction;
update accounts20
set balance = balance+5000
where account_no = 'ACC381';

COMMIT;

-- ***************************************************************************
-- ROLLBACK
start transaction;
UPDATE accounts20
SET balance = balance - 5000
WHERE account_no='ACC381';

ROLLBACK;
-- ****************************************************************************
CREATE TABLE transaction_history
(
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_no VARCHAR(20),
    amount DECIMAL(10,2),
    current_balance DECIMAL(10,2),
    transaction_type VARCHAR(20)
);

START TRANSACTION;
UPDATE accounts20
SET balance = balance - 5000
WHERE account_no='ACC381';
INSERT INTO transaction_history
(account_no,amount,current_balance,transaction_type)
VALUES
('ACC381',5000,35000,'Withdraw');

COMMIT;
select * from transaction_history;
-- ---------------------------------------------------------
delimiter //
create trigger t_h
after update
on accounts20
for each row
begin 
     insert into transaction_history
     (
        account_no,
        amount,
        current_balance,
		transaction_type
     )
     values
     (
       old.account_no,
       new.balance-old.balance,
       new.balance,
       'Withdraw'
     );
end //
delimiter ;
-- ************************************************************************
-- SAVEPOINT
START TRANSACTION;
UPDATE accounts20
SET balance=balance-5000
WHERE account_no='ACC381';

SAVEPOINT withdraw_done;

UPDATE accounts20
SET balance=balance+5000
WHERE account_no='ACC843';

SELECT * FROM accounts20;

ROLLBACK TO withdraw_done;

COMMIT;
-- ************************************************************************
CREATE TABLE users
(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50),
    email VARCHAR(100)
);
CREATE TABLE wallet
(
    wallet_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    balance DECIMAL(10,2),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);
CREATE TABLE credit_cards
(
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    bank_name VARCHAR(50),
    card_number VARCHAR(20),
    outstanding_amount DECIMAL(10,2),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);
CREATE TABLE payment_history
(
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    card_id INT,
    amount DECIMAL(10,2),
    payment_date DATETIME,
    status VARCHAR(20)
);
CREATE TABLE wallet_transaction_history
(
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    wallet_id INT,
    old_balance DECIMAL(10,2),
    new_balance DECIMAL(10,2),
    amount DECIMAL(10,2),
    transaction_type VARCHAR(20),
    transaction_time DATETIME
);
INSERT INTO users(full_name,email)
VALUES
('Naruto Uzumaki','naruto@gmail.com'),
('Sasuke Uchiha','sasuke@gmail.com'),
('Sakura Haruno','sakura@gmail.com'),
('Kakashi Hatake','kakashi@gmail.com'),
('Hinata Hyuga','hinata@gmail.com'),
('Shikamaru Nara','shikamaru@gmail.com'),
('Rock Lee','rocklee@gmail.com'),
('Neji Hyuga','neji@gmail.com'),
('Gaara','gaara@gmail.com'),
('Itachi Uchiha','itachi@gmail.com');
INSERT INTO wallet(user_id,balance)
VALUES
(1,50000),
(2,45000),
(3,38000),
(4,62000),
(5,41000),
(6,55000),
(7,30000),
(8,47000),
(9,65000),
(10,90000);
INSERT INTO credit_cards(user_id,bank_name,card_number,outstanding_amount)
VALUES
(1,'Hidden Leaf Bank','1001001001001001',12000),
(2,'Sharingan Bank','1001001001001002',15000),
(3,'Medical Ninja Bank','1001001001001003',8000),
(4,'Copy Ninja Bank','1001001001001004',20000),
(5,'Hyuga Bank','1001001001001005',9500),
(7,'Taijutsu Bank','1001001001001007',7000),
(8,'Byakugan Bank','1001001001001008',11000),
(9,'Sand Village Bank','1001001001001009',14000),
(10,'Akatsuki Bank','1001001001001010',30000);
-- ***********************************************************************************************************************************************************************
SELECT * FROM users;

SELECT * FROM wallet;

SELECT * FROM credit_cards;
-- ***********************************************************************************************************************************************************************
-- Successful Payment (COMMIT)
START TRANSACTION;

UPDATE wallet
SET balance = balance - 5000
WHERE user_id = (
SELECT user_id
FROM users
WHERE full_name='Naruto Uzumaki'
);

UPDATE credit_cards
SET outstanding_amount = outstanding_amount - 5000
WHERE user_id = (
SELECT user_id
FROM users
WHERE full_name='Naruto Uzumaki'
);

SELECT * FROM wallet WHERE user_id=1;

SELECT * FROM credit_cards WHERE user_id=1;

COMMIT;

SELECT * FROM wallet;

SELECT * FROM credit_cards;

-- ----------------------------------------------------------------------------
-- Payment Failed (ROLLBACK)
START TRANSACTION;

UPDATE wallet
SET balance=balance-6000
WHERE user_id=2;

UPDATE credit_cards
SET outstanding_amount=outstanding_amount-6000
WHERE user_id=2;

SELECT * FROM wallet WHERE user_id=2;

SELECT * FROM credit_cards WHERE user_id=2;

ROLLBACK;

SELECT * FROM wallet WHERE user_id=2;

SELECT * FROM credit_cards WHERE user_id=2;
-- --------------------------------------------------------------------------------------
-- SAVEPOINT
DELIMITER //

CREATE PROCEDURE PayCreditBill
(
    IN p_user_id INT,
    IN p_amount DECIMAL(10,2),
    IN p_payment_no INT
)
BEGIN

    DECLARE v_balance DECIMAL(10,2);
    DECLARE c_amount DECIMAL(10,2);

    SELECT balance
    INTO v_balance
    FROM wallet
    WHERE user_id = p_user_id;

    SELECT outstanding_amount
    INTO c_amount
    FROM credit_cards
    WHERE user_id = p_user_id;

    IF v_balance >= p_amount THEN

        IF p_amount <= c_amount THEN

            UPDATE wallet
            SET balance = balance - p_amount
            WHERE user_id = p_user_id;

            UPDATE credit_cards
            SET outstanding_amount = outstanding_amount - p_amount
            WHERE user_id = p_user_id;

            SELECT CONCAT('Payment ', p_payment_no, ' Successful') AS Message;

        ELSE

            IF p_payment_no = 1 THEN

                ROLLBACK;
                SELECT 'Payment 1 Failed - Payment is greater than Outstanding' AS Message;

            ELSEIF p_payment_no = 2 THEN

                ROLLBACK TO payment1_completed;
                SELECT 'Payment 2 Failed - Payment is greater than Outstanding' AS Message;

            ELSEIF p_payment_no = 3 THEN
			    SELECT 'Payment 3 Failed - Payment is greater than Outstanding' AS Message;
                ROLLBACK TO payment2_completed;

            END IF;

        END IF;

    ELSE

        IF p_payment_no = 1 THEN

            ROLLBACK;
            SELECT 'Payment 1 Failed - Insufficient Wallet Balance' AS Message;

        ELSEIF p_payment_no = 2 THEN

            ROLLBACK TO payment1_completed;
            SELECT 'Payment 2 Failed - Rolled back to Payment 1' AS Message;

        ELSEIF p_payment_no = 3 THEN
            SELECT 'Payment 3 Failed - Rolled back to Payment 2' AS Message;
            ROLLBACK TO payment2_completed;

        END IF;

    END IF;

END //

DELIMITER ;



START TRANSACTION;

-- Payment 1
CALL PayCreditBill(4,20000,1);

-- Verify payment 1
SELECT balance
FROM wallet
WHERE user_id = 4;
SELECT outstanding_amount
FROM credit_cards
WHERE user_id = 4;

SAVEPOINT payment1_completed;

------------------------------------------------

-- Payment 2
CALL PayCreditBill(10,25000,2);

-- Verify payment 2
SELECT balance
FROM wallet
WHERE user_id = 10;
SELECT outstanding_amount
FROM credit_cards
WHERE user_id = 10;

SAVEPOINT payment2_completed;

------------------------------------------------

-- Payment 3
CALL PayCreditBill(1,30000,3);

SELECT balance
FROM wallet
WHERE user_id = 1;
SELECT outstanding_amount
FROM credit_cards
WHERE user_id = 1;
rollback;
SAVEPOINT payment3_completed;
------------------------------------------------

COMMIT;


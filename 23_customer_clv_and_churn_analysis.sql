create database day_23;
use day_23;

-- **************************************************************************************************************************************************************************
-- Customer Lifetime Value (CLV) & Churn Analysis.
CREATE TABLE c_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(120),
    city VARCHAR(50),
    signup_date DATE
);
INSERT INTO c_customers VALUES
(1,'Aarav Sharma','aarav@gmail.com','Delhi','2024-01-15'),
(2,'Priya Singh','priya@gmail.com','Mumbai','2024-02-10'),
(3,'Rahul Kumar','rahul@gmail.com','Hyderabad','2024-03-20'),
(4,'Sneha Patel','sneha@gmail.com','Pune','2024-05-12'),
(5,'Vikram Reddy','vikram@gmail.com','Chennai','2024-06-18'),
(6,'Neha Gupta','neha@gmail.com','Delhi','2024-07-01'),
(7,'Arjun Rao','arjun@gmail.com','Bangalore','2024-08-10'),
(8,'Meera Joshi','meera@gmail.com','Ahmedabad','2024-09-02'),
(9,'Karan Verma','karan@gmail.com','Lucknow','2024-10-15'),
(10,'Anjali Das','anjali@gmail.com','Kolkata','2024-11-05'),
(11,'Rohan Nair','rohan@gmail.com','Kochi','2025-01-10'),
(12,'Pooja Yadav','pooja@gmail.com','Jaipur','2025-02-01'),
(13,'Amit Shah','amit@gmail.com','Surat','2025-03-18'),
(14,'Divya Iyer','divya@gmail.com','Chennai','2025-04-22'),
(15,'Nikhil Jain','nikhil@gmail.com','Indore','2025-05-11'),
(16,'Kavya Menon','kavya@gmail.com','Bangalore','2025-06-20'),
(17,'Sanjay Mishra','sanjay@gmail.com','Patna','2025-08-01'),
(18,'Ritika Kapoor','ritika@gmail.com','Delhi','2025-10-10'),
(19,'Deepak Soni','deepak@gmail.com','Nagpur','2025-12-05'),
(20,'Isha Roy','isha@gmail.com','Kolkata','2026-01-15');

CREATE TABLE c_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id)
    REFERENCES c_customers(customer_id)
);
INSERT INTO c_orders VALUES

(1,1,'2024-02-10',450),
(2,1,'2024-04-18',1200),
(3,1,'2024-08-15',850),
(4,1,'2025-02-20',760),
(5,1,'2026-07-18',1400),

(6,2,'2024-03-11',650),
(7,2,'2024-06-01',900),
(8,2,'2025-01-10',1200),
(9,2,'2026-05-12',950),
(10,2,'2026-07-05',1100),

(11,3,'2024-04-05',500),
(12,3,'2024-09-09',1300),
(13,3,'2025-02-01',900),
(14,3,'2025-08-20',1500),
(15,3,'2026-03-11',1800),

(16,4,'2024-06-20',750),
(17,4,'2025-01-15',620),
(18,4,'2025-04-18',980),
(19,4,'2026-06-05',1600),
(20,4,'2026-07-12',700),

(21,5,'2024-07-01',1100),
(22,5,'2024-11-20',850),
(23,5,'2025-03-10',990),
(24,5,'2025-12-11',600),
(25,5,'2026-07-08',1700),

(26,6,'2024-08-12',450),
(27,6,'2024-10-25',800),
(28,6,'2025-06-11',1000),
(29,6,'2026-04-05',1500),
(30,6,'2026-06-28',600),

(31,7,'2024-09-15',900),
(32,7,'2025-01-20',650),
(33,7,'2025-10-18',1100),
(34,7,'2026-06-14',1200),
(35,7,'2026-07-22',1450),

(36,8,'2024-10-12',500),
(37,8,'2025-03-01',900),
(38,8,'2025-09-15',750),
(39,8,'2026-01-18',600),
(40,8,'2026-07-25',950),

(41,9,'2024-11-16',800),
(42,9,'2025-02-18',1250),
(43,9,'2025-07-20',1450),
(44,9,'2026-02-05',500),
(45,9,'2026-05-10',900),

(46,10,'2024-12-10',900),
(47,10,'2025-04-05',650),
(48,10,'2025-09-10',1000),
(49,10,'2026-07-15',1300),
(50,10,'2026-07-28',800),

(51,11,'2025-02-01',700),
(52,11,'2025-08-01',1200),
(53,11,'2026-01-20',900),
(54,11,'2026-06-15',1400),
(55,11,'2026-07-20',950),

(56,12,'2025-03-15',650),
(57,12,'2025-10-18',1200),
(58,12,'2026-02-12',900),
(59,12,'2026-06-20',1600),
(60,12,'2026-07-10',750),

(61,13,'2025-04-20',850),
(62,13,'2025-11-15',900),
(63,13,'2026-03-22',1000),
(64,13,'2026-05-15',1450),
(65,13,'2026-07-02',1700),

(66,14,'2025-05-22',600),
(67,14,'2025-12-01',900),
(68,14,'2026-02-20',1100),
(69,14,'2026-06-01',700),
(70,14,'2026-07-16',1350),

(71,15,'2025-06-10',450),
(72,15,'2025-09-01',900),
(73,15,'2026-01-15',650),
(74,15,'2026-06-25',800),
(75,15,'2026-07-30',1200),

(76,16,'2025-07-01',950),
(77,16,'2025-12-15',800),
(78,16,'2026-04-10',650),
(79,16,'2026-06-18',1500),
(80,16,'2026-07-08',950),

(81,17,'2025-08-15',1100),
(82,17,'2025-11-20',700),
(83,17,'2026-01-25',900),
(84,17,'2026-05-25',1400),
(85,17,'2026-06-29',650),

(86,18,'2025-10-15',500),
(87,18,'2026-02-20',900),
(88,18,'2026-05-18',1200),
(89,18,'2026-06-27',700),
(90,18,'2026-07-21',1450),

(91,19,'2025-12-15',1000),
(92,19,'2026-03-18',900),
(93,19,'2026-06-12',700),
(94,19,'2026-07-18',1800),
(95,19,'2026-07-29',650),

(96,20,'2026-01-20',600),
(97,20,'2026-03-22',850),
(98,20,'2026-06-14',900),
(99,20,'2026-07-12',1400),
(100,20,'2026-07-30',750);
-- Customer Lifetime Value (CLV) & Churn Analysis.

-- Task 1

-- For each customer, calculate:
-- Total Revenue
-- First Order Date
-- Last Order Date
-- Status (Active / Churned)

SET @active_days = 30;
SET @churn_days = 120;

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.amount) AS total_revenue,
    MIN(o.order_date) AS first_order_date,
    MAX(o.order_date) AS last_order_date,

    DATEDIFF(CURRENT_DATE, MAX(o.order_date)) AS days_since_last_order,

    CASE
        WHEN DATEDIFF(CURRENT_DATE, MAX(o.order_date)) <= @active_days
            THEN 'Active'

        WHEN DATEDIFF(CURRENT_DATE, MAX(o.order_date)) >= @churn_days
            THEN 'Churned'

        ELSE 'Inactive'
    END AS customer_status

FROM c_customers c
JOIN c_orders o
ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;
        
-- *************************************************************************************
        
-- Task 2

-- Monthly report: Total revenue from
-- New customers
-- Returning customers
-- Churned customers


WITH customer_summary AS (

    SELECT
        customer_id,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date
    FROM c_orders
    GROUP BY customer_id

),

order_classification AS (

    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        o.amount,
        CASE
            WHEN o.order_date = cs.first_order_date
                THEN 'New'
            ELSE 'Returning'
        END AS customer_type,

        CASE
            WHEN DATEDIFF(CURRENT_DATE, cs.last_order_date) <= @active_days
                THEN 'Active'

            WHEN DATEDIFF(CURRENT_DATE, cs.last_order_date) >= @churn_days
                THEN 'Churned'

            ELSE 'Inactive'

        END AS present_customer_status

    FROM c_orders o
    JOIN customer_summary cs
    ON o.customer_id = cs.customer_id
)


SELECT
    DATE_FORMAT(order_date,'%Y-%m') AS order_month,
    customer_type,
    present_customer_status,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT customer_id) AS customers

FROM order_classification
GROUP BY
    order_month,
    customer_type,
    present_customer_status
ORDER BY
    order_month,
    customer_type,
    present_customer_status;
    
-- ***************************************************************************************
    
-- Task 3: 

-- Identify At-Risk Customers
-- At-risk customers: those who were active last month but had no orders this month.

WITH monthly_customer_activity AS (
    SELECT
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m') AS order_month
    FROM c_orders
    GROUP BY
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m')
)

SELECT
    c.customer_id,
    c.customer_name,
	'Yes' AS at_risk


FROM c_customers c
LEFT JOIN monthly_customer_activity as previous_month
ON c.customer_id = previous_month.customer_id
AND previous_month.order_month =
    DATE_FORMAT(
        DATE_SUB(CURRENT_DATE, INTERVAL 2 MONTH),
        '%Y-%m'
    )
LEFT JOIN monthly_customer_activity as current_month
ON c.customer_id = current_month.customer_id
AND current_month.order_month =
    DATE_FORMAT(
        DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH),
        '%Y-%m'
    )
WHERE 
previous_month.customer_id IS NOT NULL AND current_month.customer_id IS NULL;











-- Customer Spending Trend & Loyalty Analysis
WITH customer_orders AS (

    SELECT

        c.customer_id,
        c.customer_name,
        o.order_id,
        o.order_date,
        o.amount

    FROM c_customers c

    JOIN c_orders o

    ON c.customer_id = o.customer_id

)


SELECT

    customer_id,
    customer_name,
    order_id,
    order_date,
    amount,


    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS order_number,


    LAG(amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_amount,


    SUM(amount) OVER(
        PARTITION BY customer_id
    ) AS lifetime_revenue,


    SUM(amount) OVER(

        PARTITION BY customer_id

        ORDER BY order_date

        ROWS BETWEEN 2 PRECEDING
        AND CURRENT ROW

    ) AS rolling_3_order_revenue,


    AVG(amount) OVER(

        PARTITION BY customer_id

        ORDER BY order_date

        ROWS BETWEEN 2 PRECEDING
        AND CURRENT ROW

    ) AS rolling_3_order_average,


    MIN(order_date) OVER(
        PARTITION BY customer_id
    ) AS first_order_date,


    MAX(order_date) OVER(
        PARTITION BY customer_id
    ) AS last_order_date,


    DATEDIFF(

        CURRENT_DATE,

        MAX(order_date) OVER(
            PARTITION BY customer_id
        )

    ) AS days_since_last_order,


    CASE

        WHEN DATEDIFF(
            CURRENT_DATE,
            MAX(order_date) OVER(
                PARTITION BY customer_id
            )
        ) <= @active_days

        THEN 'Active'


        WHEN DATEDIFF(
            CURRENT_DATE,
            MAX(order_date) OVER(
                PARTITION BY customer_id
            )
        ) >= @churn_days

        THEN 'Churned'


        ELSE 'In Active'

    END AS customer_status


FROM customer_orders

ORDER BY
    customer_id,
    order_date;
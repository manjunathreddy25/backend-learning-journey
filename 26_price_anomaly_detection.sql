-- Price Anomaly Detection
-- Assume product_price_history(product_id, price, valid_from).


-- Tasks:
-- Using window functions (LAG / AVG), detect price changes where:

-- New price differs by more than 30% from the average of last 3 prices.

-- Flag these as anomalies and store them in price_anomalies.

-- Create a view showing latest valid price per product.


-- Concepts: window frames, anomaly logic, history tables.
-- @backend guys 

-- **************************************************************************************
create database day_26;
use day_26;
CREATE TABLE product_price_history_26 (
    price_history_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    valid_from DATE NOT NULL
);
INSERT INTO product_price_history_26
(product_id, price, valid_from)
VALUES

-- ==========================================
-- Product 101 - Wireless Mouse
-- Normal changes + one large increase
-- ==========================================

(101, 1000.00, '2026-01-01'),
(101, 1050.00, '2026-02-01'),
(101, 1100.00, '2026-03-01'),
(101, 1080.00, '2026-04-01'),
(101, 1600.00, '2026-05-01'),   -- 🚨 anomaly
(101, 1580.00, '2026-06-01'),

-- ==========================================
-- Product 102 - Mechanical Keyboard
-- Mostly stable
-- ==========================================

(102, 2500.00, '2026-01-01'),
(102, 2550.00, '2026-02-01'),
(102, 2600.00, '2026-03-01'),
(102, 2580.00, '2026-04-01'),
(102, 2650.00, '2026-05-01'),
(102, 2700.00, '2026-06-01'),

-- ==========================================
-- Product 103 - USB-C Cable
-- Normal changes + large decrease
-- ==========================================

(103, 500.00, '2026-01-01'),
(103, 520.00, '2026-02-01'),
(103, 510.00, '2026-03-01'),
(103, 530.00, '2026-04-01'),
(103, 540.00, '2026-05-01'),
(103, 300.00, '2026-06-01'),    -- 🚨 anomaly

-- ==========================================
-- Product 104 - Laptop Stand
-- Normal price movement
-- ==========================================

(104, 1500.00, '2026-01-01'),
(104, 1520.00, '2026-02-01'),
(104, 1550.00, '2026-03-01'),
(104, 1500.00, '2026-04-01'),
(104, 1480.00, '2026-05-01'),

-- ==========================================
-- Product 105 - Webcam
-- Large increase
-- ==========================================

(105, 3000.00, '2026-01-01'),
(105, 3050.00, '2026-02-01'),
(105, 3100.00, '2026-03-01'),
(105, 3150.00, '2026-04-01'),
(105, 5000.00, '2026-05-01'),   -- 🚨 anomaly

-- ==========================================
-- Product 106 - Bluetooth Headphones
-- Stable pricing
-- ==========================================

(106, 3500.00, '2026-01-01'),
(106, 3550.00, '2026-02-01'),
(106, 3600.00, '2026-03-01'),
(106, 3580.00, '2026-04-01'),
(106, 3650.00, '2026-05-01'),

-- ==========================================
-- Product 107 - Power Bank
-- Large decrease
-- ==========================================

(107, 2000.00, '2026-01-01'),
(107, 2050.00, '2026-02-01'),
(107, 2100.00, '2026-03-01'),
(107, 2150.00, '2026-04-01'),
(107, 2200.00, '2026-05-01'),
(107, 1200.00, '2026-06-01'),   -- 🚨 anomaly

-- ==========================================
-- Product 108 - External SSD
-- Normal changes
-- ==========================================

(108, 8000.00, '2026-01-01'),
(108, 8100.00, '2026-02-01'),
(108, 8200.00, '2026-03-01'),
(108, 8300.00, '2026-04-01'),
(108, 8400.00, '2026-05-01'),

-- ==========================================
-- Product 109 - USB Hub
-- Large increase
-- ==========================================

(109, 1200.00, '2026-01-01'),
(109, 1250.00, '2026-02-01'),
(109, 1300.00, '2026-03-01'),
(109, 1280.00, '2026-04-01'),
(109, 2000.00, '2026-05-01'),   -- 🚨 anomaly

-- ==========================================
-- Product 110 - Gaming Mouse Pad
-- Stable
-- ==========================================

(110, 800.00, '2026-01-01'),
(110, 820.00, '2026-02-01'),
(110, 810.00, '2026-03-01'),
(110, 830.00, '2026-04-01'),
(110, 850.00, '2026-05-01');

SELECT *
FROM product_price_history_26
ORDER BY product_id, valid_from;

SELECT
    product_id,
    COUNT(*) AS price_records
FROM product_price_history_26
GROUP BY product_id
ORDER BY product_id;

-- *****************************************************************************************
-- New price differs by more than 30% from the average of last 3 prices.
WITH price_analysis AS (
    SELECT
        product_id,
        price,
        valid_from,

        AVG(price) OVER (
            PARTITION BY product_id
            ORDER BY valid_from
            ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
        ) AS avg_last_3_prices

    FROM product_price_history_26
)

SELECT
    product_id,
    price,
    valid_from,
    ROUND(avg_last_3_prices, 2) AS avg_last_3_prices,

    ROUND(
        ABS(price - avg_last_3_prices)
        / avg_last_3_prices * 100,
        2
    ) AS deviation_percent,

    CASE
        WHEN ABS(price - avg_last_3_prices)
             / avg_last_3_prices * 100 > 30
        THEN 'ANOMALY'
        ELSE 'NORMAL'
    END AS status

FROM price_analysis
WHERE avg_last_3_prices IS NOT NULL;

-- ********************************************************************************************

-- Flag these as anomalies and store them in price_anomalies.

CREATE TABLE price_anomalies (
    anomaly_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    valid_from DATE NOT NULL,
    avg_last_3_prices DECIMAL(10,2) NOT NULL,
    deviation_percent DECIMAL(10,2) NOT NULL,
    detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO price_anomalies
(
    product_id,
    price,
    valid_from,
    avg_last_3_prices,
    deviation_percent
)

WITH price_analysis AS (
    SELECT
        product_id,
        price,
        valid_from,

        LAG(price, 3) OVER (
            PARTITION BY product_id
            ORDER BY valid_from
        ) AS third_previous_price,

        AVG(price) OVER (
            PARTITION BY product_id
            ORDER BY valid_from
            ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
        ) AS avg_last_3_prices

    FROM product_price_history_26
)

SELECT
    product_id,
    price,
    valid_from,
    ROUND(avg_last_3_prices, 2) ,

    ROUND(
        ABS(price - avg_last_3_prices)
        / avg_last_3_prices * 100,
        2) as deviation_percent

FROM price_analysis

WHERE third_previous_price IS NOT NULL

  AND
    ABS(price - avg_last_3_prices)
    / avg_last_3_prices * 100 > 30;
    
SELECT *
FROM price_anomalies
ORDER BY product_id, valid_from;
-- ******************************************************************************************

-- Create a view showing latest valid price per product.

CREATE VIEW latest_product_prices AS

SELECT
    product_id,
    price,
    valid_from
FROM (
    SELECT
        product_id,
        price,
        valid_from,

        ROW_NUMBER() OVER (
            PARTITION BY product_id
            ORDER BY valid_from DESC
        ) AS rn

    FROM product_price_history_26
) AS price_ranked

WHERE rn = 1;

SELECT *
FROM latest_product_prices
ORDER BY product_id;
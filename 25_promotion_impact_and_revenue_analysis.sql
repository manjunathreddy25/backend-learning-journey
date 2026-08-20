-- Discount & Promotion Impact Analysis
-- Assume orders, order_items(discount_amount), and promotions.


-- Tasks:
-- For each promotion, compute:
-- Incremental revenue compared to same period last year.

-- Change in average order value (AOV).

-- Identify promotions that increased quantity sold but reduced profit margin.

-- Find customers who only buy during promotions (never paid full price).


-- Concepts: self-joins on shifted dates, profitability calculation, advanced filtering.
-- @backend guys 

-- ********************************************************************************************************
create database promotion_impact_and_revenue_analysis;
use promotion_impact_and_revenue_analysis;
CREATE TABLE promotions_25 (
    promotion_id INT PRIMARY KEY,
    promotion_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    discount_percent DECIMAL(5,2) NOT NULL
);
INSERT INTO promotions_25
(promotion_id, promotion_name, start_date, end_date, discount_percent)
VALUES
(1, 'Summer Sale', '2026-06-01', '2026-06-10', 20.00),
(2, 'Independence Sale', '2026-08-10', '2026-08-15', 25.00),
(3, 'Diwali Sale', '2026-10-20', '2026-10-30', 30.00);

CREATE TABLE orders_25 (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    promotion_id INT NULL,

    FOREIGN KEY (promotion_id)
        REFERENCES promotions_25(promotion_id)
);
INSERT INTO orders_25
(order_id, customer_id, order_date, promotion_id)
VALUES

-- =========================
-- 2025 ORDERS
-- =========================

(1001, 501, '2025-06-02', NULL),
(1002, 502, '2025-06-03', NULL),
(1003, 503, '2025-06-05', NULL),
(1004, 504, '2025-06-06', NULL),
(1005, 505, '2025-06-08', NULL),

-- =========================
-- 2026 SUMMER SALE
-- =========================

(1006, 501, '2026-06-02', 1),
(1007, 502, '2026-06-03', 1),
(1008, 503, '2026-06-04', 1),
(1009, 504, '2026-06-06', 1),
(1010, 505, '2026-06-08', 1),

-- Promotion-only customers
(1011, 506, '2026-06-02', 1),
(1012, 507, '2026-06-05', 1),
(1013, 508, '2026-06-07', 1),

-- =========================
-- NORMAL ORDERS
-- =========================

(1014, 501, '2026-06-15', NULL),
(1015, 502, '2026-06-18', NULL),
(1016, 509, '2026-06-20', NULL),
(1017, 510, '2026-06-22', NULL),

-- =========================
-- 2026 INDEPENDENCE SALE
-- =========================

(1018, 501, '2026-08-10', 2),
(1019, 502, '2026-08-11', 2),
(1020, 506, '2026-08-11', 2),
(1021, 507, '2026-08-12', 2),
(1022, 508, '2026-08-13', 2),

-- Another promotion-only customer
(1023, 511, '2026-08-12', 2),
(1024, 512, '2026-08-13', 2),

-- =========================
-- NORMAL ORDERS
-- =========================

(1025, 509, '2026-08-20', NULL),
(1026, 510, '2026-08-22', NULL),
(1027, 501, '2026-08-25', NULL),

-- =========================
-- DIWALI SALE
-- =========================

(1028, 503, '2026-10-21', 3),
(1029, 504, '2026-10-22', 3),
(1030, 511, '2026-10-25', 3);



CREATE TABLE order_items_25 (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) NOT NULL,
    cost_per_unit DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders_25(order_id)
);
INSERT INTO order_items_25
(order_item_id, order_id, product_id, quantity, unit_price, discount_amount, cost_per_unit)
VALUES

-- =========================
-- 2025 ORDERS
-- =========================

(1, 1001, 101, 2, 1000.00, 0.00, 600.00),
(2, 1001, 103, 3, 500.00, 0.00, 300.00),

(3, 1002, 102, 1, 2500.00, 0.00, 1500.00),
(4, 1002, 104, 2, 1500.00, 0.00, 900.00),

(5, 1003, 105, 2, 3000.00, 0.00, 1900.00),
(6, 1003, 107, 1, 2000.00, 0.00, 1200.00),

(7, 1004, 106, 2, 3500.00, 0.00, 2200.00),
(8, 1004, 109, 2, 1200.00, 0.00, 700.00),

(9, 1005, 110, 3, 800.00, 0.00, 450.00),

-- =========================
-- 2026 SUMMER SALE
-- =========================

(10, 1006, 101, 4, 1000.00, 800.00, 600.00),
(11, 1006, 103, 5, 500.00, 500.00, 300.00),

(12, 1007, 102, 3, 2500.00, 1500.00, 1500.00),
(13, 1007, 104, 3, 1500.00, 900.00, 900.00),

(14, 1008, 105, 4, 3000.00, 2400.00, 1900.00),
(15, 1008, 107, 2, 2000.00, 800.00, 1200.00),

(16, 1009, 106, 4, 3500.00, 2800.00, 2200.00),
(17, 1009, 109, 4, 1200.00, 960.00, 700.00),

(18, 1010, 110, 6, 800.00, 960.00, 450.00),

-- Promotion-only customers
(19, 1011, 101, 5, 1000.00, 1000.00, 600.00),
(20, 1012, 103, 8, 500.00, 800.00, 300.00),
(21, 1013, 110, 10, 800.00, 1600.00, 450.00),

-- =========================
-- NORMAL ORDERS
-- =========================

(22, 1014, 102, 1, 2500.00, 0.00, 1500.00),
(23, 1015, 105, 1, 3000.00, 0.00, 1900.00),
(24, 1016, 106, 2, 3500.00, 0.00, 2200.00),
(25, 1017, 109, 3, 1200.00, 0.00, 700.00),

-- =========================
-- INDEPENDENCE SALE
-- =========================

(26, 1018, 101, 3, 1000.00, 750.00, 600.00),
(27, 1018, 103, 4, 500.00, 500.00, 300.00),

(28, 1019, 102, 2, 2500.00, 1250.00, 1500.00),

(29, 1020, 107, 4, 2000.00, 2000.00, 1200.00),

(30, 1021, 110, 8, 800.00, 1600.00, 450.00),

(31, 1022, 106, 5, 3500.00, 4375.00, 2200.00),

-- Promotion-only
(32, 1023, 104, 5, 1500.00, 1875.00, 900.00),
(33, 1024, 109, 7, 1200.00, 2100.00, 700.00),

-- =========================
-- NORMAL ORDERS
-- =========================

(34, 1025, 101, 2, 1000.00, 0.00, 600.00),
(35, 1026, 105, 2, 3000.00, 0.00, 1900.00),
(36, 1027, 102, 2, 2500.00, 0.00, 1500.00),

-- =========================
-- DIWALI SALE
-- =========================

(37, 1028, 105, 5, 3000.00, 4500.00, 1900.00),
(38, 1028, 107, 3, 2000.00, 1800.00, 1200.00),

(39, 1029, 106, 5, 3500.00, 5250.00, 2200.00),
(40, 1029, 110, 10, 800.00, 2400.00, 450.00),

(41, 1030, 104, 6, 1500.00, 2700.00, 900.00),
(42, 1030, 109, 8, 1200.00, 2880.00, 700.00),

-- Additional realistic orders
(43, 1006, 109, 2, 1200.00, 480.00, 700.00),
(44, 1018, 110, 5, 1000.00, 1250.00, 550.00),
(45, 1028, 101, 3, 1000.00, 900.00, 600.00);



SELECT *
FROM promotions_25;

SELECT *
FROM orders_25
ORDER BY order_date;

SELECT *
FROM order_items_25;

SELECT COUNT(*) AS total_orders
FROM orders_25;

SELECT COUNT(*) AS total_order_items
FROM order_items_25;



SELECT
    oi.order_item_id,
    oi.order_id,
    oi.product_id,
    oi.quantity,
    oi.unit_price,
    oi.discount_amount,
    oi.cost_per_unit,

    oi.quantity * oi.unit_price AS gross_revenue,

    (oi.quantity * oi.unit_price)
        - oi.discount_amount AS net_revenue,

    (
        (oi.quantity * oi.unit_price)
        - oi.discount_amount
        - (oi.quantity * oi.cost_per_unit)
    ) AS profit,

    (
        (
            (oi.quantity * oi.unit_price)
            - oi.discount_amount
            - (oi.quantity * oi.cost_per_unit)
        )
        /
        ((oi.quantity * oi.unit_price) - oi.discount_amount)
    ) * 100 AS profit_margin

FROM order_items_25 oi;
-- ******************************************************************************************

-- Revenue per Promotion
SELECT
    p.promotion_id,
    p.promotion_name,
    SUM(
        (oi.quantity * oi.unit_price)
        - oi.discount_amount
    ) AS total_revenue
FROM promotions_25 p
JOIN orders_25 o
    ON p.promotion_id = o.promotion_id
JOIN order_items_25 oi
    ON o.order_id = oi.order_id
GROUP BY
    p.promotion_id,
    p.promotion_name
ORDER BY
    p.promotion_id;
    
    
-- Revenue + AOV per Promotion
SELECT
    p.promotion_id,
    p.promotion_name,

    SUM(
        (oi.quantity * oi.unit_price)
        - oi.discount_amount
    ) AS total_revenue,

    COUNT(DISTINCT o.order_id) AS total_orders,

    SUM(
        (oi.quantity * oi.unit_price)
        - oi.discount_amount
    ) / COUNT(DISTINCT o.order_id) AS aov

FROM promotions_25 p
JOIN orders_25 o
    ON p.promotion_id = o.promotion_id
JOIN order_items_25 oi
    ON o.order_id = oi.order_id

GROUP BY
    p.promotion_id,
    p.promotion_name;
-- ************************************************************************************

-- Compare Revenue With Same Period Last Year
SELECT
    p.promotion_id,
    p.promotion_name,

    SUM(
        (oi.quantity * oi.unit_price)
        - oi.discount_amount
    ) AS revenue_2026,

    (
        SELECT
            COALESCE(
                SUM(
                    (oi2.quantity * oi2.unit_price)
                    - oi2.discount_amount
                ),
                0
            )
        FROM orders_25 o2
        JOIN order_items_25 oi2
            ON o2.order_id = oi2.order_id
        WHERE o2.order_date BETWEEN
              DATE_SUB(p.start_date, INTERVAL 1 YEAR)
              AND DATE_SUB(p.end_date, INTERVAL 1 YEAR)
    ) AS revenue_2025,

    SUM(
        (oi.quantity * oi.unit_price)
        - oi.discount_amount
    )
    -
    (
        SELECT
            COALESCE(
                SUM(
                    (oi2.quantity * oi2.unit_price)
                    - oi2.discount_amount
                ),
                0
            )
        FROM orders_25 o2
        JOIN order_items_25 oi2
            ON o2.order_id = oi2.order_id
        WHERE o2.order_date BETWEEN
              DATE_SUB(p.start_date, INTERVAL 1 YEAR)
              AND DATE_SUB(p.end_date, INTERVAL 1 YEAR)
    ) AS incremental_revenue

FROM promotions_25 p

JOIN orders_25 o
    ON o.promotion_id = p.promotion_id

JOIN order_items_25 oi
    ON o.order_id = oi.order_id

GROUP BY
    p.promotion_id,
    p.promotion_name,
    p.start_date,
    p.end_date;
-- ***************************************************************************************

-- Find promotions where quantity sold increased but profit margin decreased.
WITH promotion_metrics AS (

    SELECT
        p.promotion_id,
        p.promotion_name,

        -- 2026 quantity
        SUM(
            oi.quantity
        ) AS quantity_2026,

        -- 2026 revenue
        SUM(
            (oi.quantity * oi.unit_price)
            - oi.discount_amount
        ) AS revenue_2026,

        -- 2026 profit
        SUM(
            (oi.quantity * oi.unit_price)
            - oi.discount_amount
            - (oi.quantity * oi.cost_per_unit)
        ) AS profit_2026,

        -- 2025 quantity
        (
            SELECT COALESCE(SUM(oi2.quantity), 0)
            FROM orders_25 o2
            JOIN order_items_25 oi2
                ON o2.order_id = oi2.order_id
            WHERE o2.order_date BETWEEN
                  DATE_SUB(p.start_date, INTERVAL 1 YEAR)
                  AND DATE_SUB(p.end_date, INTERVAL 1 YEAR)
        ) AS quantity_2025,

        -- 2025 revenue
        (
            SELECT COALESCE(
                SUM(
                    (oi2.quantity * oi2.unit_price)
                    - oi2.discount_amount
                ),
                0
            )
            FROM orders_25 o2
            JOIN order_items_25 oi2
                ON o2.order_id = oi2.order_id
            WHERE o2.order_date BETWEEN
                  DATE_SUB(p.start_date, INTERVAL 1 YEAR)
                  AND DATE_SUB(p.end_date, INTERVAL 1 YEAR)
        ) AS revenue_2025,

        -- 2025 profit
        (
            SELECT COALESCE(
                SUM(
                    (oi2.quantity * oi2.unit_price)
                    - oi2.discount_amount
                    - (oi2.quantity * oi2.cost_per_unit)
                ),
                0
            )
            FROM orders_25 o2
            JOIN order_items_25 oi2
                ON o2.order_id = oi2.order_id
            WHERE o2.order_date BETWEEN
                  DATE_SUB(p.start_date, INTERVAL 1 YEAR)
                  AND DATE_SUB(p.end_date, INTERVAL 1 YEAR)
        ) AS profit_2025

    FROM promotions_25 p

    JOIN orders_25 o
        ON p.promotion_id = o.promotion_id

    JOIN order_items_25 oi
        ON o.order_id = oi.order_id

    GROUP BY
        p.promotion_id,
        p.promotion_name,
        p.start_date,
        p.end_date
)

SELECT
    promotion_id,
    promotion_name,

    quantity_2025,
    quantity_2026,

    revenue_2025,
    revenue_2026,

    profit_2025,
    profit_2026,

    ROUND(
        profit_2025 / NULLIF(revenue_2025, 0) * 100,
        2
    ) AS profit_margin_2025,

    ROUND(
        profit_2026 / NULLIF(revenue_2026, 0) * 100,
        2
    ) AS profit_margin_2026

FROM promotion_metrics

WHERE
    quantity_2026 > quantity_2025

    AND
    (
        profit_2026 / NULLIF(revenue_2026, 0)
    )
    <
    (
        profit_2025 / NULLIF(revenue_2025, 0)
    );
    
    -- *******************************************************************************
    
    -- Find customers who only buy during promotions.
    
SELECT
    customer_id,
    COUNT(*) AS total_orders,
    COUNT(CASE WHEN promotion_id IS NOT NULL THEN 1 END) AS promotion_orders,
    COUNT(CASE WHEN promotion_id IS NULL THEN 1 END) AS full_price_orders
FROM orders_25
GROUP BY customer_id
HAVING
    COUNT(CASE WHEN promotion_id IS NOT NULL THEN 1 END) > 0
    AND
    COUNT(CASE WHEN promotion_id IS NULL THEN 1 END) = 0;
-- Inventory Reorder & Stock Health
-- Assume table inventory_movements(product_id, movement_type, qty, movement_date) and a products table with reorder_level, safety_stock.


-- Tasks:
-- Build a query to compute current stock per product from movements.

-- Identify products that:
-- Current stock < safety_stock
-- OR average daily sales for last 30 days > current stock

-- Create a view reorder_suggestions with: product, current_stock, avg_daily_sales, suggested_order_qty.

-- Create a stored procedure sp_generate_reorder_list() that:
-- Fills a purchase_requisitions table with suggested quantities.


-- Concepts: aggregation, window avg, views, stored procedures.
-- @backend guys 

-- *****************************************************************************************
create database inventory_reorder_and_stock_health;
use inventory_reorder_and_stock_health;
-- Create Products
CREATE TABLE products_24 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    reorder_level INT NOT NULL,
    safety_stock INT NOT NULL
);
INSERT INTO products_24
(product_id, product_name, reorder_level, safety_stock)
VALUES
(101, 'Wireless Mouse', 50, 20),
(102, 'Mechanical Keyboard', 30, 15),
(103, 'USB-C Cable', 100, 40),
(104, 'Laptop Stand', 25, 10),
(105, 'Webcam', 20, 8),
(106, 'Bluetooth Headphones', 35, 15),
(107, 'Power Bank', 40, 18),
(108, 'External SSD 1TB', 15, 5),
(109, 'USB Hub', 50, 20),
(110, 'Gaming Mouse Pad', 60, 25);

-- Create Inventory Movements
CREATE TABLE inventory_movements_24 (
    movement_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    movement_type ENUM('IN', 'OUT') NOT NULL,
    qty INT NOT NULL,
    movement_date DATE NOT NULL,
 
    FOREIGN KEY (product_id) 
        REFERENCES products_24(product_id)
);
INSERT INTO inventory_movements_24
(product_id, movement_type, qty, movement_date)
VALUES
 
-- Wireless Mouse
(101, 'IN', 200, '2026-06-20'),
(101, 'OUT', 40, '2026-07-15'),
(101, 'OUT', 35, '2026-07-22'),
(101, 'OUT', 50, '2026-08-01'),
(101, 'OUT', 30, '2026-08-05'),
 
-- Mechanical Keyboard
(102, 'IN', 100, '2026-06-25'),
(102, 'OUT', 20, '2026-07-10'),
(102, 'OUT', 15, '2026-07-20'),
(102, 'OUT', 25, '2026-08-02'),
(102, 'OUT', 10, '2026-08-08'),
 
-- USB-C Cable
(103, 'IN', 300, '2026-06-15'),
(103, 'OUT', 60, '2026-07-12'),
(103, 'OUT', 50, '2026-07-18'),
(103, 'OUT', 70, '2026-07-25'),
(103, 'OUT', 55, '2026-08-05'),
 
-- Laptop Stand
(104, 'IN', 80, '2026-06-28'),
(104, 'OUT', 25, '2026-07-15'),
(104, 'OUT', 20, '2026-07-28'),
(104, 'OUT', 15, '2026-08-06'),
 
-- Webcam
(105, 'IN', 60, '2026-07-01'),
(105, 'OUT', 20, '2026-07-15'),
(105, 'OUT', 15, '2026-07-25'),
(105, 'OUT', 10, '2026-08-03'),
 
-- Bluetooth Headphones
(106, 'IN', 120, '2026-06-20'),
(106, 'OUT', 30, '2026-07-05'),
(106, 'OUT', 25, '2026-07-18'),
(106, 'OUT', 20, '2026-07-30'),
(106, 'OUT', 15, '2026-08-07'),
 
-- Power Bank
(107, 'IN', 150, '2026-06-18'),
(107, 'OUT', 40, '2026-07-10'),
(107, 'OUT', 35, '2026-07-20'),
(107, 'OUT', 30, '2026-08-01'),
(107, 'OUT', 25, '2026-08-08'),
 
-- External SSD
(108, 'IN', 50, '2026-06-22'),
(108, 'OUT', 15, '2026-07-12'),
(108, 'OUT', 10, '2026-07-25'),
(108, 'OUT', 12, '2026-08-05'),
 
-- USB Hub
(109, 'IN', 120, '2026-07-01'),
(109, 'OUT', 20, '2026-07-15'),
(109, 'OUT', 15, '2026-07-25'),
(109, 'OUT', 10, '2026-08-02'),
 
-- Gaming Mouse Pad
(110, 'IN', 200, '2026-06-20'),
(110, 'OUT', 50, '2026-07-10'),
(110, 'OUT', 45, '2026-07-20'),
(110, 'OUT', 40, '2026-07-30'),
(110, 'OUT', 35, '2026-08-08');


-- making some products Risky
INSERT INTO inventory_movements_24
(product_id, movement_type, qty, movement_date)
VALUES
 
-- 105 Webcam
-- Current stock will fall below safety stock
(105, 'OUT', 5, '2026-08-09'),
(105, 'OUT', 5, '2026-08-10'),
 
-- 108 External SSD
-- High recent sales compared with current stock
(108, 'OUT', 20, '2026-08-09'),
(108, 'OUT', 20, '2026-08-10'),
(108, 'OUT', 20, '2026-08-11'),
 
-- 107 Power Bank
-- Current stock will fall below safety stock
(107, 'OUT', 5, '2026-08-09'),
(107, 'OUT', 5, '2026-08-10'),
 
-- 110 Gaming Mouse Pad
-- High recent sales compared with current stock
(110, 'OUT', 15, '2026-08-09'),
(110, 'OUT', 15, '2026-08-10'),
(110, 'OUT', 15, '2026-08-11');
-- *************************************************************************************************
SELECT *
FROM products_24;

SELECT *
FROM inventory_movements_24
ORDER BY movement_date;
SELECT COUNT(*) AS total_movements
FROM inventory_movements_24;

-- 1. Current Stock Per Product
 
-- IN → +qty
-- OUT → -qty
 
SELECT
    product_id,
    SUM(
        CASE
            WHEN movement_type = 'IN' THEN qty
            WHEN movement_type = 'OUT' THEN -qty
        END
    ) AS current_stock
FROM inventory_movements_24
GROUP BY product_id;
-- *****************************************************************************************************

-- 2. Find Risky Products (Reorder Needed)
 
-- We need:
-- Current stock
-- Avg daily sales (last 30 days)
 
 
 
-- Avg Daily Sales (last 30 days)
 
SELECT
    product_id,
    TRUNCATE(SUM(qty) / 30.0,2) AS avg_daily_sales
FROM inventory_movements_24
WHERE movement_type = 'OUT'
  AND movement_date >= CURRENT_DATE - INTERVAL 30 DAY
GROUP BY product_id; 



-- Combine Everything
SELECT
    p.product_id,
    p.product_name,
    cs.current_stock,
    p.safety_stock,
    COALESCE(ads.avg_daily_sales, 0) AS avg_daily_sales
FROM products_24 p
JOIN (
    SELECT
        product_id,
        SUM(
            CASE
                WHEN movement_type = 'IN' THEN qty
                WHEN movement_type = 'OUT' THEN -qty
            END
        ) AS current_stock
    FROM inventory_movements_24
    GROUP BY product_id
) cs ON p.product_id = cs.product_id
LEFT JOIN (
    SELECT
        product_id,
        SUM(qty) / 30.0 AS avg_daily_sales
    FROM inventory_movements_24
    WHERE movement_type = 'OUT'
      AND movement_date >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY product_id
) ads ON p.product_id = ads.product_id
WHERE
    cs.current_stock < p.safety_stock
    OR COALESCE(ads.avg_daily_sales, 0) > cs.current_stock;
 
 -- *****************************************************************************************
 
 
-- 3. Create View: reorder_suggestions
 
--  Logic for suggested quantity:
-- suggested_order_qty = (reorder_level + safety_stock) - current_stock


CREATE VIEW reorder_suggestions AS
SELECT
    p.product_id,
    p.product_name,
    cs.current_stock,
    COALESCE(ads.avg_daily_sales, 0) AS avg_daily_sales,
    GREATEST(
        (p.reorder_level + p.safety_stock) - cs.current_stock,
        0
    ) AS suggested_order_qty
FROM products_24 p
 
JOIN (
    SELECT
        product_id,
        SUM(
            CASE
                WHEN movement_type = 'IN' THEN qty
                WHEN movement_type = 'OUT' THEN -qty
            END
        ) AS current_stock
    FROM inventory_movements_24
    GROUP BY product_id
) cs ON p.product_id = cs.product_id
 
LEFT JOIN (
    SELECT
        product_id,
        SUM(qty) / 30.0 AS avg_daily_sales
    FROM inventory_movements_24
    WHERE movement_type = 'OUT'
      AND movement_date >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY product_id
) ads ON p.product_id = ads.product_id
 
WHERE
    cs.current_stock < p.safety_stock
    OR COALESCE(ads.avg_daily_sales, 0) > cs.current_stock;
    
select * from reorder_suggestions;
 -- ****************************************************************************************

-- 4. Stored Procedure: sp_generate_reorder_list()
 
 
CREATE TABLE purchase_requisitions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM purchase_requisitions;

--  Procedure
DELIMITER $$
CREATE PROCEDURE sp_generate_reorder_list()
BEGIN
 
    INSERT INTO purchase_requisitions (product_id, quantity)
    SELECT 
        product_id,
        suggested_order_qty
    FROM reorder_suggestions
    WHERE suggested_order_qty > 0;
 
END $$
 
DELIMITER ;
 
 
CALL sp_generate_reorder_list();

create database day_15;
use day_15;

-- ========================================================
-- Views

CREATE TABLE products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(30),
    brand VARCHAR(30),
    price INT,
    stock INT
);
INSERT INTO products VALUES
(101,'ROG Phone 9','Gaming Mobile','ASUS',89999,20),
(102,'RedMagic 10 Pro','Gaming Mobile','Nubia',74999,15),
(103,'iQOO Neo 10','Gaming Mobile','iQOO',35999,40),
(104,'Samsung S25 Ultra','Gaming Mobile','Samsung',129999,10),
(105,'PlayStation 5 Slim','Console','Sony',54990,12),
(106,'PlayStation Portal','Console','Sony',19990,18),
(107,'Xbox Series X','Console','Microsoft',52990,8),
(108,'Nintendo Switch OLED','Console','Nintendo',32990,22),
(109,'Steam Deck OLED','Console','Valve',56999,9),
(110,'Lenovo Legion Go','Handheld','Lenovo',69999,11);

-- =========================================================================================================================================================================

-- CREATE VIEW
-- USING WHERE IN VIEW
-- Create a view containing all gaming mobiles.
CREATE VIEW gaming_mobiles AS
SELECT *
FROM products
WHERE category='Gaming Mobile';


SELECT * FROM gaming_mobiles;
-- ---------------------------------------
--- USING ORDER BY VIEW
CREATE VIEW expensive_products AS
SELECT product_name,price
FROM products
ORDER BY price DESC;
-- ------------------------------------------
-- USING BETWEEN IN VIEW
CREATE VIEW mid_range AS
SELECT *
FROM products
WHERE price BETWEEN 30000 AND 80000;
-- --------------------------------------------
-- USING IN OPERATORS IN VIEW
CREATE VIEW sony_product AS
SELECT *
FROM products
WHERE brand IN ('Sony','Samsung');
-- -----------------------------------------------------
-- USING LIKE OPERATORS IN VIEW
CREATE VIEW play_products AS
SELECT *
FROM products
WHERE product_name LIKE 'Play%';
-- -------------------------------------------------------
-- aggregate view
CREATE VIEW category_summary AS
SELECT category,
COUNT(*) total_products,
AVG(price) avg_price
FROM products
GROUP BY category;

UPDATE category_summary
SET avg_price=50000
WHERE category='Console';
-- ----------------------------------------------------------------
-- aggregate view
CREATE VIEW stock_summary AS
SELECT brand,
SUM(stock) total_stock
FROM products
GROUP BY brand;

UPDATE category_summary
SET avg_price=50000
WHERE category='Console';
-- ----------------------------------------------------------------
-- distinct view 
CREATE VIEW brands AS
SELECT DISTINCT brand
FROM products;
-- ----------------------------------------------------------------
--  calculated view
CREATE VIEW gst_price AS
SELECT product_name,
price,
price*1.18 AS final_price
FROM products;
-- -------------------------------------------------------------------
-- case view
CREATE VIEW stock_status AS
SELECT product_name,
CASE
WHEN stock>20 THEN 'High'
ELSE 'Low'
END AS status
FROM products;
-- --------------------------------------------------------------------
-- limit view
CREATE VIEW top3_expensive AS
SELECT *
FROM products
ORDER BY price DESC
LIMIT 3;
-- ----------------------------------------------------------------------
-- subquery view
CREATE VIEW premium_products AS
SELECT *
FROM products
WHERE price>
(
SELECT AVG(price)
FROM products
);
-- ---------------------------------------------------------------------
-- Nested View
CREATE VIEW gaming AS
SELECT *
FROM products
WHERE category='Gaming Mobile';

CREATE VIEW costly_gaming AS
SELECT *
FROM gaming
WHERE price>70000;
-- ------------------------------------------------------------
-- Join View

-- Create brands table

CREATE TABLE brands(
brand VARCHAR(30),
country VARCHAR(30)
);
INSERT INTO brands VALUES
('Sony','Japan'),
('Samsung','South Korea'),
('ASUS','Taiwan'),
('Microsoft','USA'),
('Nintendo','Japan'),
('Valve','USA'),
('Lenovo','China'),
('iQOO','China'),
('Nubia','China');


CREATE VIEW product_country AS
SELECT
p.product_name,
p.brand,
b.country
FROM products p
JOIN brands b
ON p.brand=b.brand;

select * from product_country;
-- ------------------------------------------------------------------------
-- Create a Sony products view.
CREATE VIEW sony_products AS
SELECT product_name,
       price,
       stock
FROM products
where brand='Sony';

SELECT * FROM sony_products;

-- Create an expensive products view.
CREATE VIEW premium_products AS
SELECT product_name,
       brand,
       price
FROM products
WHERE price>70000;

-- Create a handheld devices view.
CREATE VIEW handheld_devices AS
SELECT *
FROM products
WHERE category='Handheld';

-- Create inventory report.
CREATE VIEW inventory_report AS
SELECT product_name,
       stock,
       price,
       stock*price AS inventory_value
FROM products;

-- ==========================================================================================================================================================================
-- CREATE OR REPLACE VIEW
CREATE VIEW gaming_products AS
SELECT *
FROM products;

CREATE OR REPLACE VIEW gaming_products AS
SELECT product_name,
       brand,
       price
FROM products;


CREATE OR REPLACE VIEW sony_products AS
SELECT product_name,
       category,
       price
FROM products
WHERE brand='Sony';


CREATE OR REPLACE VIEW premium_products AS
SELECT *
FROM products
WHERE price>50000;


CREATE OR REPLACE VIEW inventory_report AS
SELECT product_name,
       stock,
       price,
       stock*price AS total_stock_value,
       category
FROM products;



CREATE OR REPLACE VIEW handheld_devices AS
SELECT product_name,
       brand,
       price
FROM products
WHERE category='Handheld';

-- ==========================================================================================================================================================================
-- DROP VIEW
DROP VIEW gaming_mobiles;

DROP VIEW sony_products;

DROP VIEW gaming_products,
          handheld_devices;
          
          
-- ==========================================================================================================================================================================
-- ALTER VIEW
ALTER VIEW gaming_products AS
SELECT product_name,
       price
FROM products;


ALTER VIEW sony_products AS
SELECT *
FROM products
WHERE stock>10;

-- ==========================================================================================================================================================================
-- SHOW VIEW 
SHOW FULL TABLES
WHERE Table_type='VIEW';

-- ==========================================================================================================================================================================
-- View Definition
SHOW CREATE VIEW gaming_products;

-- ==========================================================================================================================================================================
-- Updating Through View
CREATE VIEW mobile_stock AS
SELECT product_id,
       product_name,
       stock
FROM products;

UPDATE mobile_stock
SET stock=50
WHERE product_id=103;

SELECT *
FROM products;

-- ==========================================================================================================================================================================
-- Delete Through View
DELETE FROM mobile_stock
WHERE product_id=103;

-- ==========================================================================================================================================================================
-- Insert Through View
CREATE VIEW console_view AS
SELECT product_id,
       product_name,
       category,
       brand,
       price,
       stock
FROM products
WHERE category='Console';

INSERT INTO console_view
VALUES
(111,'Xbox Series S',
'Console',
'Microsoft',
34990,
15);

-- -------------------------------------------------------------------------
-- ✅ Updatable
-- Think of these as only displaying data:
-- ✔ SELECT
-- ✔ WHERE
-- ✔ ORDER BY
-- ✔ Column selection
-- ✔ Column aliases


-- ❌ Not Updatable
-- Think of these as changing or combining data:
-- ❌ SUM()
-- ❌ AVG()
-- ❌ MIN()
-- ❌ MAX()
-- ❌ COUNT()
-- ❌ GROUP BY
-- ❌ HAVING
-- ❌ DISTINCT
-- ❌ JOIN
-- ❌ UNION
-- ❌ Calculated columns
-- ❌ LIMIT
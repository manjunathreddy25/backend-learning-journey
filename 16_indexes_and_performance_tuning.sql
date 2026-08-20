create database day_16;
use day_16;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    restaurant_name VARCHAR(100),
    city VARCHAR(50),
    food_item VARCHAR(100),
    amount DECIMAL(8,2),
    order_status VARCHAR(20)
);
INSERT INTO orders VALUES
(1,'Rahul','Mehfil','Hyderabad','Chicken Biryani',350,'Delivered'),
(2,'Manjunath','Paradise','Hyderabad','Mutton Biryani',420,'Delivered'),
(3,'Kiran','KFC','Bangalore','Chicken Bucket',699,'Preparing'),
(4,'Ajay','Dominos','Hyderabad','Veg Pizza',299,'Delivered'),
(5,'Ravi','Pizza Hut','Chennai','Cheese Pizza',499,'Cancelled'),
(6,'Sneha','Burger King','Bangalore','Whopper',249,'Delivered'),
(7,'Priya','McDonalds','Hyderabad','McSpicy',219,'Preparing'),
(8,'Akhil','Subway','Chennai','Veg Sub',189,'Delivered');

CREATE TABLE restaurants(
restaurant_name VARCHAR(100),
city VARCHAR(50)
);

INSERT INTO restaurants VALUES
('KFC','Bangalore'),
('Dominos','Hyderabad'),
('Subway','Chennai'),
('Paradise','Hyderabad');

CREATE INDEX idx_restaurant
ON restaurants(restaurant_name);

SELECT *
FROM orders
WHERE restaurant_name = 'KFC';

EXPLAIN
SELECT *
FROM orders
WHERE restaurant_name='KFC';
-- ========================================================

CREATE INDEX idx_restaurant
ON orders(restaurant_name);

drop INDEX idx_restaurant
ON orders;

EXPLAIN
SELECT *
FROM orders
WHERE restaurant_name='KFC';
-- ===============================================================

-- Multiple Column Index
CREATE INDEX idx_city_status
ON orders(city,order_status);
SELECT *
FROM orders
WHERE city='Hyderabad'
AND order_status='Delivered';

-- ==================================================================
-- CREATE FULLTEXT INDEX
CREATE TABLE articles(
id INT PRIMARY KEY,
title VARCHAR(100),
content TEXT
);
INSERT INTO articles VALUES
(1,'Gaming Phones',
'ROG Phone is one of the best gaming mobiles.'),

(2,'PlayStation',
'PlayStation 5 is a powerful gaming console.'),

(3,'Samsung',
'Samsung S25 Ultra is a flagship phone.');

CREATE FULLTEXT INDEX idx_content
ON articles(content);

SELECT *
FROM articles
WHERE MATCH(content)
AGAINST('gaming');

-- ==================================================================
-- SHOW INDEX
show index from orders;

-- ==================================================================
-- USE INDEX
SELECT *
FROM orders
USE INDEX(idx_restaurant)
WHERE restaurant_name='KFC';

-- ==================================================================
-- FORCE INDEX
SELECT *
FROM orders
FORCE INDEX(idx_restaurant)
WHERE restaurant_name='KFC';
-- ==================================================================
-- INGNORE INDEX
SELECT *
FROM orders
IGNORE INDEX(idx_restaurant)
WHERE restaurant_name='KFC';
-- ==================================================================
-- Invisible Index
ALTER TABLE orders
ALTER INDEX idx_restaurant INVISIBLE;
-- visible Index
ALTER TABLE orders
ALTER INDEX idx_restaurant VISIBLE;
-- ==================================================================
-- Examples
-- GROUP BY ✅
SELECT restaurant_name,
COUNT(*) AS TotalOrders
FROM orders
USE INDEX(idx_restaurant)
GROUP BY restaurant_name;
-- ------------------------------------------------------------------
-- JOIN

SELECT *
FROM orders o
USE INDEX(idx_restaurant)
JOIN restaurants r
USE INDEX(idx_restaurant)
ON o.restaurant_name=r.restaurant_name;


SELECT *
FROM orders o
USE INDEX(idx_restaurant)
JOIN restaurants r
ON o.restaurant_name=r.restaurant_name; -- Only orders uses the index!        
SELECT *
FROM orders o
JOIN restaurants r
USE INDEX(idx_restaurant)
ON o.restaurant_name=r.restaurant_name;-- Only restaurants uses the index!
-- -----------------------------------------------------------------
-- Subquery ✅
SELECT *
FROM orders
WHERE restaurant_name IN
(
    SELECT restaurant_name
    FROM restaurants
    USE INDEX(idx_restaurant)
);
-- ------------------------------------------------------------------
-- EXISTS (Correlated subquery)
SELECT *
FROM orders o
WHERE EXISTS
(
    SELECT 1
    FROM restaurants r
    USE INDEX(idx_restaurant)
    WHERE r.restaurant_name=o.restaurant_name
);
-- ---------------------------------------------------------------------
-- Having
SELECT city,
COUNT(*) AS TotalOrders
FROM orders
USE INDEX(idx_city)
GROUP BY city
HAVING COUNT(*)>2;
-- ---------------------------------------------------------------------
-- Aggregate Functions ✅
SELECT COUNT(*)
FROM orders
USE INDEX(idx_status)
WHERE order_status='Delivered';
SELECT AVG(amount)
FROM orders
USE INDEX(idx_city)
WHERE city='Hyderabad';
-- -----------------------------------------------------------------------
-- Composite Index
SELECT *
FROM orders
USE INDEX(idx_city_status)
WHERE city='Hyderabad'
AND order_status='Delivered';
-- ==================================================================

-- Where Should We Create Indexes?

-- Good candidates:
-- Primary keys
-- Foreign keys
-- Frequently searched columns
-- Frequently joined columns
-- Columns used in WHERE
-- Columns used in ORDER BY
-- Columns used in GROUP BY

-- ====================================================================================================================================================================

-- Where Should We Avoid Indexes?

-- Don't create indexes on:
-- Small tables
-- Columns with very few distinct values (e.g., only Delivered, Cancelled, Preparing)
-- Columns that are updated very frequently
-- Reason:
-- Every INSERT, UPDATE, and DELETE must also update the index, adding overhead.

-- =========================================================================
-- Advantages
-- Faster SELECT queries
-- Faster joins
-- Faster searching
-- Faster sorting in many cases
-- ==========================================================================
-- Disadvantages
-- Extra storage space
-- Slower INSERT, UPDATE, and DELETE because indexes also need maintenance.
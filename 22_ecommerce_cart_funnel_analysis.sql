create database ecommerce_cart_funnel_analysis;
use ecommerce_cart_funnel_analysis;

-- ***************************************************************************************************************************************************************************
-- E-Commerce Platform
CREATE TABLE E_customers(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30),
    age_group VARCHAR(20)
);
INSERT INTO E_customers VALUES
(1,'Rahul','Hyderabad','18-25'),
(2,'Anjali','Bangalore','26-35'),
(3,'Vikram','Hyderabad','26-35'),
(4,'Sneha','Chennai','18-25'),
(5,'Kiran','Bangalore','36-45'),
(6,'Arjun','Hyderabad','18-25'),
(7,'Priya','Chennai','26-35'),
(8,'Ramesh','Delhi','36-45');

CREATE TABLE E_products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(10,2)
);
INSERT INTO E_products VALUES
(101,'Laptop','Electronics',60000),
(102,'Mouse','Electronics',800),
(103,'Keyboard','Electronics',1500),
(104,'Headphones','Electronics',2500),
(105,'Monitor','Electronics',12000),
(106,'Mobile','Electronics',25000),
(107,'Smart Watch','Electronics',5000),
(108,'USB Cable','Accessories',300);

CREATE TABLE E_orders(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    FOREIGN KEY(customer_id) REFERENCES E_customers(customer_id)
);
INSERT INTO E_orders VALUES
(1001,1,'2026-08-01','Delivered'),
(1002,2,'2026-08-01','Delivered'),
(1003,3,'2026-08-02','Delivered'),
(1004,5,'2026-08-02','Cancelled'),
(1005,6,'2026-08-03','Delivered'),
(1006,7,'2026-08-03','Delivered');

CREATE TABLE E_order_items(
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY(order_id) REFERENCES E_orders(order_id),
    FOREIGN KEY(product_id) REFERENCES E_products(product_id)
);
INSERT INTO E_order_items VALUES
(1,1001,101,1,60000),
(2,1001,102,2,800),
(3,1002,103,1,1500),
(4,1003,104,1,2500),
(5,1005,106,1,25000),
(6,1006,108,3,300);

CREATE TABLE E_payments(
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(20),
    payment_status VARCHAR(20),
    amount DECIMAL(10,2),
    FOREIGN KEY(order_id) REFERENCES E_orders(order_id)
);
INSERT INTO E_payments VALUES
(1,1001,'UPI','Success',61600),
(2,1002,'Card','Success',1500),
(3,1003,'Card','Success',2500),
(4,1004,'UPI','Refunded',12000),
(5,1005,'NetBanking','Success',25000),
(6,1006,'COD','Success',900);

CREATE TABLE E_inventory_movements(
    movement_id INT PRIMARY KEY,
    product_id INT,
    movement_type VARCHAR(20),
    quantity INT,
    movement_date DATE
);
INSERT INTO E_inventory_movements VALUES
(1,101,'IN',20,'2026-07-25'),
(2,101,'OUT',1,'2026-08-01'),
(3,102,'OUT',2,'2026-08-01'),
(4,106,'OUT',1,'2026-08-03'),
(5,108,'OUT',3,'2026-08-03'),
(6,104,'OUT',1,'2026-08-02');

CREATE TABLE E_shipments(
    shipment_id INT PRIMARY KEY,
    order_id INT,
    shipment_status VARCHAR(20),
    shipped_date DATE,
    delivered_date DATE
);
INSERT INTO E_shipments VALUES
(1,1001,'Delivered','2026-08-02','2026-08-04'),
(2,1002,'Delivered','2026-08-02','2026-08-05'),
(3,1003,'Delivered','2026-08-03','2026-08-05'),
(4,1005,'In Transit','2026-08-04',NULL),
(5,1006,'Delivered','2026-08-04','2026-08-06');

CREATE TABLE E_cart_events(
    event_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    event_type VARCHAR(30),
    event_time DATETIME
);
INSERT INTO E_cart_events VALUES

-- Rahul (Complete Purchase)
(1,1,101,'VIEW_PRODUCT','2026-08-01 09:00:00'),
(2,1,101,'ADD_TO_CART','2026-08-01 09:05:00'),
(3,1,101,'CHECKOUT_STARTED','2026-08-01 09:10:00'),
(4,1,101,'ORDER_PLACED','2026-08-01 09:15:00'),

-- Rahul Mouse
(5,1,102,'VIEW_PRODUCT','2026-08-01 09:01:00'),
(6,1,102,'ADD_TO_CART','2026-08-01 09:06:00'),
(7,1,102,'CHECKOUT_STARTED','2026-08-01 09:11:00'),
(8,1,102,'ORDER_PLACED','2026-08-01 09:15:00'),

-- Anjali
(9,2,103,'VIEW_PRODUCT','2026-08-01 11:00:00'),
(10,2,103,'ADD_TO_CART','2026-08-01 11:05:00'),
(11,2,103,'CHECKOUT_STARTED','2026-08-01 11:10:00'),
(12,2,103,'ORDER_PLACED','2026-08-01 11:15:00'),

-- Vikram Abandoned
(13,3,105,'VIEW_PRODUCT','2026-08-02 10:00:00'),
(14,3,105,'ADD_TO_CART','2026-08-02 10:05:00'),

-- Sneha Abandoned
(15,4,106,'VIEW_PRODUCT','2026-08-02 12:00:00'),
(16,4,106,'ADD_TO_CART','2026-08-02 12:05:00'),
(17,4,106,'CHECKOUT_STARTED','2026-08-02 12:15:00'),

-- Kiran Cancelled
(18,5,105,'VIEW_PRODUCT','2026-08-02 13:00:00'),
(19,5,105,'ADD_TO_CART','2026-08-02 13:05:00'),
(20,5,105,'CHECKOUT_STARTED','2026-08-02 13:15:00'),
(21,5,105,'ORDER_PLACED','2026-08-02 13:20:00'),

-- Arjun
(22,6,106,'VIEW_PRODUCT','2026-08-03 09:00:00'),
(23,6,106,'ADD_TO_CART','2026-08-03 09:03:00'),
(24,6,106,'CHECKOUT_STARTED','2026-08-03 09:10:00'),
(25,6,106,'ORDER_PLACED','2026-08-03 09:15:00'),

-- Priya
(26,7,108,'VIEW_PRODUCT','2026-08-03 11:00:00'),
(27,7,108,'ADD_TO_CART','2026-08-03 11:05:00'),
(28,7,108,'CHECKOUT_STARTED','2026-08-03 11:15:00'),
(29,7,108,'ORDER_PLACED','2026-08-03 11:20:00'),

-- Ramesh Abandoned
(30,8,107,'VIEW_PRODUCT','2026-08-03 16:00:00'),
(31,8,107,'ADD_TO_CART','2026-08-03 16:10:00');
-- **************************************************************************************************************************************************************************
-- E-Commerce Platform

-- Funnel Conversion Rate Per Day

WITH funnel AS
(
SELECT
    DATE(event_time) AS event_date,

    SUM(CASE WHEN event_type='VIEW_PRODUCT' THEN 1 ELSE 0 END) AS views,

    SUM(CASE WHEN event_type='ADD_TO_CART' THEN 1 ELSE 0 END) AS carts,

    SUM(CASE WHEN event_type='CHECKOUT_STARTED' THEN 1 ELSE 0 END) AS checkouts,

    SUM(CASE WHEN event_type='ORDER_PLACED' THEN 1 ELSE 0 END) AS orders

FROM e_cart_events
GROUP BY DATE(event_time)
)

SELECT *,
       ROUND(carts*100.0/views,2) AS view_to_cart_rate,
       ROUND(checkouts*100.0/carts,2) AS cart_to_checkout_rate,
       ROUND(orders*100.0/checkouts,2) AS checkout_to_order_rate
FROM funnel;

-- **************************************************************************************
-- Cart Abandonment Rate by Customer Segment(city or age_group)

with abandonment as
(
 select customer_id,
        SUM(CASE WHEN event_type='ADD_TO_CART' THEN 1 ELSE 0 END) AS carts,
        SUM(CASE WHEN event_type='ORDER_PLACED' THEN 1 ELSE 0 END) AS orders
from e_cart_events 
group by customer_id
)

SELECT
    c.city,
    SUM(a.carts) AS carts,
    SUM(a.orders) AS orders,
    CONCAT(ROUND((SUM(a.carts) - SUM(a.orders)) * 100.0 / SUM(a.carts),2),'%') AS abandonment_rate
FROM e_customers c
LEFT JOIN abandonment a
ON c.customer_id = a.customer_id
GROUP BY c.city;

-- *****************************************************************************************
-- Find top 10 products that are most frequently added to cart but not purchased.

with abandonment as
(
 select product_id,
        SUM(CASE WHEN event_type='ADD_TO_CART' THEN 1 ELSE 0 END) AS carts,
        SUM(CASE WHEN event_type='ORDER_PLACED' THEN 1 ELSE 0 END) AS orders
from e_cart_events 
group by product_id
)

select p.product_name, sum(a.carts - a.orders) as Difference
from e_products as p
left join abandonment as a 
on p.product_id = a.product_id
group by p.product_id
order by sum(a.carts - a.orders) desc
limit 10;

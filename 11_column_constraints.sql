create database column_constraints;
use column_constraints;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- UNIQUE, CHECK, DEFAULT, NOT NULL-Apply constraints + insert test data

CREATE TABLE Farmers (
    FarmerID INT PRIMARY KEY,
    FarmerName VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE,
    Village VARCHAR(50)
);

INSERT INTO Farmers VALUES
(101, 'Ramesh', '9876543210', 'Green Valley'),
(102, 'Suresh', '9876543211', 'Sunrise Farm'),
(103, 'Mahesh', '9876543212', 'River Side'),
(104, 'Rajesh', '9876543213', 'Hill Farm'),
(105, 'Naresh', '9876543214', 'Fruit Garden');



CREATE TABLE Fruits (
    FruitID INT PRIMARY KEY,
    FruitName VARCHAR(50) NOT NULL,
    PricePerKg DECIMAL(6,2) CHECK (PricePerKg > 0),
    StockKg INT CHECK (StockKg >= 0)
);
INSERT INTO Fruits VALUES
(1, 'Apple', 180, 200),
(2, 'Mango', 120, 300),
(3, 'Orange', 90, 250),
(4, 'Banana', 50, 500),
(5, 'Grapes', 140, 150);


CREATE TABLE FruitOrders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    FruitName VARCHAR(50),
    Quantity INT,
    OrderStatus VARCHAR(20) DEFAULT 'Pending'
);
INSERT INTO FruitOrders
(OrderID, CustomerName, FruitName, Quantity)
VALUES
(1, 'Anil', 'Apple', 20),
(2, 'Kiran', 'Mango', 15),
(3, 'Deepa', 'Orange', 30);

INSERT INTO FruitOrders
VALUES
(4, 'Ravi', 'Banana', 50, 'Delivered'),
(5, 'Sneha', 'Grapes', 25, 'Processing');



CREATE TABLE FruitSuppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(50) NOT NULL,
    FruitName VARCHAR(50) NOT NULL,
    City VARCHAR(50),
    ContactNumber VARCHAR(15) NOT NULL
);
INSERT INTO FruitSuppliers VALUES
(1, 'Fresh Farms', 'Apple', 'Hyderabad', '9876500011'),
(2, 'Nature Fruits', 'Mango', 'Vijayawada', '9876500012'),
(3, 'Green Basket', 'Orange', 'Guntur', '9876500013'),
(4, 'Fruit World', 'Banana', 'Warangal', '9876500014'),
(5, 'Organic Hub', 'Grapes', 'Nellore', '9876500015');
-- **************************************************************************************************
-- UNIQUE, CHECK, DEFAULT, NOT NULL-Apply constraints + insert test data.

SELECT 
    *
FROM
    Farmers;

SELECT 
    *
FROM
    Farmers
WHERE
    PhoneNumber = '9876543212';

SELECT 
    COUNT(*) AS TotalFarmers
FROM
    Farmers;

SELECT 
    FarmerName
FROM
    Farmers
ORDER BY FarmerName;

INSERT INTO Farmers
VALUES (106, 'Kiran', '9876543210', 'Apple Farm');
-- INSERT INTO Farmers VALUES (106, 'Kiran', '9876543210', 'Apple Farm')	Error Code: 1062. Duplicate entry '9876543210' for key 'farmers.PhoneNumber'.




-- CHECK 

SELECT 
    *
FROM
    Fruits;

SELECT 
    *
FROM
    Fruits
WHERE
    PricePerKg > 100;

SELECT 
    SUM(StockKg) AS TotalStock
FROM
    Fruits;

SELECT 
    AVG(PricePerKg) AS AveragePrice
FROM
    Fruits;

INSERT INTO Fruits
VALUES (6, 'Kiwi', -100, 20);
-- INSERT INTO Fruits VALUES (6, 'Kiwi', -100, 20)	Error Code: 3819. Check constraint 'fruits_chk_1' is violated.

-- DEFAULT 

SELECT 
    *
FROM
    FruitOrders;

SELECT 
    *
FROM
    FruitOrders
WHERE
    OrderStatus = 'Pending';

SELECT 
    *
FROM
    FruitOrders
WHERE
    OrderStatus = 'Delivered';

SELECT 
    COUNT(*) AS TotalOrders
FROM
    FruitOrders;

INSERT INTO FruitOrders(OrderID, CustomerName, FruitName, Quantity)
VALUES
(6, 'Rahul', 'Pineapple', 10);
-- here 'DEFAULT' Assigns a value if none is provided OrderStatus becomes 'Pending'.

-- 
-- NOT NULL
SELECT 
    *
FROM
    FruitSuppliers;

SELECT 
    *
FROM
    FruitSuppliers
WHERE
    City = 'Hyderabad';

SELECT 
    COUNT(*) AS TotalSuppliers
FROM
    FruitSuppliers;

SELECT 
    SupplierName
FROM
    FruitSuppliers;

INSERT INTO FruitSuppliers
VALUES
(6, NULL, 'Kiwi', 'Delhi', '9876500016');
-- INSERT INTO FruitSuppliers VALUES (6, NULL, 'Kiwi', 'Delhi', '9876500016')	Error Code: 1048. Column 'SupplierName' cannot be null.
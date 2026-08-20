create database referential_integrity_and_cascade;
use referential_integrity_and_cascade;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

 -- parent table & data --
CREATE TABLE AnimeSeries (
    anime_id INT PRIMARY KEY,
    anime_name VARCHAR(100),
    genre VARCHAR(50),
    episodes INT
);
INSERT INTO AnimeSeries VALUES
(101, 'Naruto', 'Action', 720),
(102, 'One Piece', 'Adventure', 1120),
(103, 'Attack on Titan', 'Action', 89),
(104, 'Death Note', 'Thriller', 37),
(105, 'Demon Slayer', 'Fantasy', 55);


-- child table & data -- 
CREATE TABLE AnimeCharacters (
    character_id INT PRIMARY KEY,
    character_name VARCHAR(100),
    power VARCHAR(100),
    anime_id INT,
    FOREIGN KEY (anime_id)
    REFERENCES AnimeSeries(anime_id)
);
INSERT INTO AnimeCharacters VALUES
(201, 'Naruto Uzumaki', 'Rasengan', 101),
(202, 'Monkey D. Luffy', 'Gear 5', 102),
(203, 'Eren Yeager', 'Titan Form', 103),
(204, 'Light Yagami', 'Death Note', 104),
(205, 'Tanjiro Kamado', 'Water Breathing', 105);
-- ******************************************************************************************8
-- primary key queries --
SELECT 
    *
FROM
    AnimeSeries;

SELECT 
    anime_name, genre
FROM
    AnimeSeries;

SELECT 
    *
FROM
    AnimeSeries
WHERE
    anime_id = 103;

SELECT 
    *
FROM
    AnimeSeries
WHERE
    episodes > 100;

SELECT 
    *
FROM
    AnimeSeries
ORDER BY anime_name;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- foriegn key queries --
SELECT 
    *
FROM
    AnimeCharacters;

SELECT 
    A.anime_name, C.character_name
FROM
    AnimeSeries A
        JOIN
    AnimeCharacters C ON A.anime_id = C.anime_id;

SELECT 
    character_name, power
FROM
    AnimeCharacters;

SELECT 
    A.anime_name, C.character_name
FROM
    AnimeSeries A
        JOIN
    AnimeCharacters C ON A.anime_id = C.anime_id
WHERE
    A.genre = 'Action';

SELECT 
    COUNT(*) AS Total_Characters
FROM
    AnimeCharacters;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Assign relational constraints

CREATE TABLE AnimeSeries (
    anime_id INT PRIMARY KEY,  -- (constraint)
    anime_name VARCHAR(100),
    genre VARCHAR(50),
    episodes INT
);


CREATE TABLE AnimeCharacters (
    character_id INT PRIMARY KEY,     -- (constraint)
    character_name VARCHAR(100),
    anime_id INT,
    FOREIGN KEY (anime_id)        -- (constraint)
    REFERENCES AnimeSeries(anime_id)
);


CREATE TABLE AnimeStudios (
    studio_id INT PRIMARY KEY,         -- (constraint)
    studio_name VARCHAR(100) UNIQUE      -- (constraint)
);


CREATE TABLE AnimeGenres (
    genre_id INT PRIMARY KEY,      -- (constraint)
    genre_name VARCHAR(50) NOT NULL     -- (constraint)
);


CREATE TABLE AnimeRatings (
    anime_id INT PRIMARY KEY,        -- (constraint)
    anime_name VARCHAR(100),
    rating DECIMAL(2,1),
    CHECK (rating BETWEEN 0 AND 10)       -- (constraint)
);


CREATE TABLE AnimeEpisodes (
    anime_id INT PRIMARY KEY,      -- (constraint)
    anime_name VARCHAR(100),
    status VARCHAR(20) DEFAULT 'Ongoing');       -- (constraint)
    
    
    -- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- composite primary key

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO orders VALUES
(101, '2026-01-10'),
(102, '2026-01-11'),
(103, '2026-01-12');

INSERT INTO orders VALUES
(101, '2026-01-10'),
(102, '2026-01-11'),
(103, '2026-01-12');

INSERT INTO products VALUES
(1, 'Laptop'),
(2, 'Mouse'),
(3, 'Keyboard');

INSERT INTO order_details VALUES
(101, 1, 2),
(101, 2, 5),
(102, 1, 1),
(102, 3, 2),
(103, 2, 3);


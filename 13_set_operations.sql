create database day_13;
use day_13;

CREATE TABLE erangel_players (
    player_id INT,
    player_name VARCHAR(50),
    rank_tier VARCHAR(20)
);
CREATE TABLE miramar_players (
    player_id INT,
    player_name VARCHAR(50),
    rank_tier VARCHAR(20)
);

INSERT INTO erangel_players VALUES
(1,'Jonathan','Conqueror'),
(2,'Scout','Ace'),
(3,'Mortal','Crown'),
(4,'Snax','Ace'),
(5,'Goblin','Diamond'),
(6,'Neyoo','Conqueror');
INSERT INTO miramar_players VALUES
(3,'Mortal','Crown'),
(4,'Snax','Ace'),
(5,'Goblin','Diamond'),
(7,'Omega','Ace'),
(8,'Akshat','Crown'),
(9,'Shadow','Diamond');

-- ==================================================================================================================

-- UNION	Combines rows and removes duplicates
-- UNION ALL	Combines rows and keeps duplicates
-- INTERSECT	Returns common rows
-- EXCEPT	Returns rows in first query but not second

SELECT 
    player_name
FROM
    erangel_players 
UNION 
SELECT 
    player_name
FROM
    miramar_players;

-- 2. List all rank tiers available across both maps
SELECT 
    rank_tier
FROM
    erangel_players 
UNION SELECT 
    rank_tier
FROM
    miramar_players;

-- 3. Show all unique player IDs from both maps
SELECT 
    player_id
FROM
    erangel_players 
UNION SELECT 
    player_id
FROM
    miramar_players;

-- 4. Show all Ace and Conqueror players from both maps
SELECT 
    player_name
FROM
    erangel_players
WHERE
    rank_tier IN ('Ace' , 'Conqueror') 
UNION SELECT 
    player_name
FROM
    miramar_players
WHERE
    rank_tier IN ('Ace' , 'Conqueror');

-- 5. Create a combined leaderboard
SELECT 
    player_name, rank_tier
FROM
    erangel_players 
UNION SELECT 
    player_name, rank_tier
FROM
    miramar_players
ORDER BY rank_tier;


-- ==========================================================================================================================================================================
-- INTERSECT Queries

-- 1. Players who played both maps
SELECT player_name
FROM erangel_players
INTERSECT
SELECT player_name
FROM miramar_players;

-- 2. Common player IDs in both maps
SELECT player_id
FROM erangel_players
INTERSECT
SELECT player_id
FROM miramar_players;

-- 3. Common rank tiers available in both maps
SELECT rank_tier
FROM erangel_players
INTERSECT
SELECT rank_tier
FROM miramar_players;

-- 4. Players who have exactly the same rank in both maps
SELECT player_name, rank_tier
FROM erangel_players
INTERSECT
SELECT player_name, rank_tier
FROM miramar_players;

-- 5. Common Conqueror players
SELECT player_name
FROM erangel_players
WHERE rank_tier='Conqueror'
INTERSECT
SELECT player_name
FROM miramar_players
WHERE rank_tier='Conqueror';

-- ===========================================================================================================================================================================
-- EXCEPT Queries

-- 1. Players who played only Erangel
SELECT player_name
FROM erangel_players
except
SELECT player_name
FROM miramar_players;

-- 2. Player IDs found only in Erangel
SELECT player_id
FROM erangel_players
EXCEPT
SELECT player_id
FROM miramar_players;

-- 3. Rank tiers present in Erangel but not Miramar
SELECT rank_tier
FROM erangel_players
EXCEPT
SELECT rank_tier
FROM miramar_players;

-- 4. Ace players who never played Miramar
SELECT player_name
FROM erangel_players
WHERE rank_tier='Ace'
EXCEPT
SELECT player_name
FROM miramar_players;

-- 5. Player + Rank combinations only available in Erangel
SELECT player_name, rank_tier
FROM erangel_players
EXCEPT
SELECT player_name, rank_tier
FROM miramar_players;


-- ==========================================================================================================================================================================

-- union,intersect,except (merging all)

(
    SELECT player_name
    FROM erangel_players

    UNION

    SELECT player_name
    FROM miramar_players
)
INTERSECT
(
    SELECT player_name
    FROM erangel_players

    EXCEPT

    SELECT player_name
    FROM miramar_players
);

-- World Life Expectancy - Data Cleaning

-- 1. Quick sanity check: view the raw table
SELECT *
FROM world_life_expectancy;


-- 2. Identify duplicate Country + Year rows
SELECT
    Country,
    Year,
    CONCAT(Country, Year) AS country_year_key,
    COUNT(*) AS row_count
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(*) > 1;


-- 3. List duplicate rows using ROW_NUMBER
--    (any row with Row_Num > 1 is a duplicate)
SELECT *
FROM (
    SELECT
        Row_ID,
        CONCAT(Country, Year) AS country_year_key,
        ROW_NUMBER() OVER (
            PARTITION BY CONCAT(Country, Year)
            ORDER BY CONCAT(Country, Year)
        ) AS Row_Num
    FROM world_life_expectancy
) AS row_table
WHERE Row_Num > 1;


-- 4. Delete duplicate rows (keep Row_Num = 1)
DELETE FROM world_life_expectancy
WHERE Row_ID IN (
    SELECT Row_ID
    FROM (
        SELECT
            Row_ID,
            CONCAT(Country, Year) AS country_year_key,
            ROW_NUMBER() OVER (
                PARTITION BY CONCAT(Country, Year)
                ORDER BY CONCAT(Country, Year)
            ) AS Row_Num
        FROM world_life_expectancy
    ) AS row_table
    WHERE Row_Num > 1
);


-- 5. Inspect Status values and blanks
SELECT *
FROM world_life_expectancy;
-- WHERE Status = '';   -- uncomment to view only blank Status rows

SELECT DISTINCT Status
FROM world_life_expectancy
WHERE Status <> '';

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing'
;

-- This query will not work because it'll update from 
-- it's own info (at FROM), not from the new data that we give
-- UPDATE world_life_expectancy	
-- SET Status = 'Developing'
-- WHERE Country IN (  SELECT DISTINCT(Country)
-- 					FROM world_life_expectancy
-- 					WHERE Status = 'Developing'
-- 				 )
-- ;
-- so the workaround for above query is below,
-- where we create a temp table for the new data

-- 6. Fill blank Status values using a self-join
--    Logic: if another row for the same Country
--    already has Status = 'Developing', use that
UPDATE world_life_expectancy AS t1
JOIN world_life_expectancy AS t2
    ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
  AND t2.Status = 'Developing';


-- 7. (Optional) Check the join result
-- SELECT *
-- FROM world_life_expectancy AS t1
-- JOIN world_life_expectancy AS t2
--     ON t1.Country = t2.Country;
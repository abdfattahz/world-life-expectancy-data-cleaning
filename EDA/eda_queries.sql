-- World Life Expectancy Project (Explarotory Data Analysis)

SELECT *
FROM world_life_expectancy
;

SELECT Country, MIN(`Life expectancy`), MAX(`Life expectancy`)
FROM world_life_expectancy
GROUP BY Country
ORDER BY Country DESC
;

SELECT Country, MIN(`Life expectancy`), MAX(`Life expectancy`)
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Country DESC
;

SELECT Country,
        MIN(`Life expectancy`),
        MAX(`Life expectancy`),
        ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY `Life_Increase_15_Years` DESC
;

SELECT Country,
        MIN(`Life expectancy`),
        MAX(`Life expectancy`),
        ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY `Life_Increase_15_Years` ASC
;

SELECT Year, ROUND(AVG(`Life expectancy`), 2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;

SELECT Country,  ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(GDP), 1) AS GDP
FROM world_life_expectancy
GROUP BY Country
;

SELECT Country,  ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(GDP), 1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING AVG(`Life expectancy`) > 0
AND AVG(GDP) > 0
ORDER BY GDP ASC
;

SELECT Country,  ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(GDP), 1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING AVG(`Life expectancy`) > 0
AND AVG(GDP) > 0
ORDER BY GDP DESC
;

-- To find how many of countries that meet the case statement
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
ROUND(AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END), 1) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
ROUND(AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END), 1) Low_GDP_Life_Expectancy
FROM world_life_expectancy
;

SELECT Country, GDP
FROM world_life_expectancy
WHERE GDP <> 0
-- ORDER BY GDP ASC
ORDER BY GDP DESC
;

-- This one might not be accurate because what if there's only 1 country for developed and developing is multiple, so it will mess the actual value
SELECT Status, ROUND(AVG(`Life expectancy`), 2)
FROM world_life_expectancy
GROUP BY Status
;

-- So we do this instead
-- sanity checking each status count
SELECT Status, COUNT(DISTINCT Country)
FROM world_life_expectancy
GROUP BY Status
;

-- From above query we can see that the developing country outnumbers the developed country
-- So we combine them to see the actual numbers
SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`), 2)
FROM world_life_expectancy
GROUP BY Status
;

SELECT Country, ROUND(AVG(`Life expectancy`), 2) AS Life_Expectancy, ROUND(AVG(BMI), 2) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING BMI > 0
AND Life_Expectancy > 0
ORDER BY BMI ASC
;

-- AVG BMI for each country
SELECT AVG(BMI) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING BMI > 0
;

-- AVG BMI for the whole world (based on the country available inside the data)
SELECT AVG(avg_bmi) AS world_avg_bmi
FROM (
        SELECT 
        AVG(BMI) AS avg_bmi
        FROM world_life_expectancy
        GROUP BY Country
        HAVING avg_bmi > 0 
     ) AS t
;

SELECT Country,
        Year,
        `Life expectancy`,
        `Adult Mortality`,
        -- here is where we do the rolling total
        -- we do window function
        SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%Malay%'
;


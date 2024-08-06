-- Analysis of Netflix Userbase Dataset


/** EXPLORATORY DATA ANALYSIS **/



-- Check the number of unique users in the dataset

SELECT COUNT(DISTINCT user_id) AS UniqueUserIDs
FROM NetflixUserbase

  
-- Check for any missing values in key fields

SELECT COUNT (*) AS MissingValues
FROM NetflixUserbase
WHERE subscription_type IS NULL OR monthly_revenue IS NULL OR device is NULL


-- Determine which countries are in the dataset

SELECT country, COUNT(*) AS NumCountries
FROM NetflixUserbase
GROUP BY country
ORDER BY NumCountries DESC


-- Determine what type of devices are used to watch Netflix

SELECT device, COUNT(*) AS NumDevices
FROM NetflixUserbase
GROUP BY device
ORDER BY NumDevices DESC


-- Get an overview of the age range of our userbase

SELECT
	min(age) as MinAge,
	avg(age) AS AvgAge,
	max(age) as MaxAge
FROM NetflixUserbase


-- Determine the price points of the subscription models

SELECT DISTINCT(monthly_revenue), subscription_type AS SubscriptionPrices
FROM NetflixUserbase
GROUP BY monthly_revenue
ORDER BY monthly_revenue ASC


/** DATA ANALYSIS **/

	

-- #1: Which plans are the most popular among different age groups?

SELECT subscription_type,
	COUNT(CASE WHEN age <= 34 then 1 END) AS 'Young Adults',
	COUNT (CASE WHEN age BETWEEN 35 AND 42 THEN 1 END) AS 'Mid Adults',
	COUNT (CASE WHEN age >= 43 THEN 1 END) AS 'Mature Adults'
FROM NetflixUserbase AS AgeBrackets
GROUP BY subscription_type


-- #2: Determine the most popular devices used for streaming
	
SELECT device, SUM(monthly_revenue) AS TotalDevice
FROM NetflixUserbase
GROUP BY device
ORDER BY TotalDevice DESC


-- #3: Which devices are the most popular among different age groups?

SELECT device,
	COUNT(CASE WHEN age <= 34 then 1 END) AS 'Young Adults',
	COUNT (CASE WHEN age BETWEEN 35 AND 42 THEN 1 END) AS 'Mid Adults',
	COUNT (CASE WHEN age >= 43 THEN 1 END) AS 'Mature Adults'
FROM NetflixUserbase AS AgeBrackets
GROUP BY device


-- #4: Which subscription tiers are the most profitable?

SELECT subscription_type, SUM(monthly_revenue) AS TotalMonthlyRevenue
FROM NetflixUserbase
GROUP BY subscription_type
ORDER BY TotalMonthlyRevenue DESC


-- #5: Which markets are generating the most revenue?

-- By individual countries:

SELECT country, SUM(monthly_revenue) AS CountryRevenue
FROM NetflixUserbase
GROUP BY subscription_type
ORDER BY CountryRevenue DESC
	
/* By World Regions:
	North America: Canada, United States, Mexico
	Europe: United Kingdom, Spain, Italy, Germany, France
	South America: Brazil
	Australia & Oceania: Australia */

SELECT CASE
	WHEN country IN('Canada', 'United States', 'Mexico') THEN 'North America'
        WHEN country IN('United Kingdom', 'Spain', 'Italy', 'Germany', 'France') THEN 'Europe'
        WHEN country = 'Brazil' THEN 'South America'
        WHEN country = 'Australia' THEN 'Australia & Oceania'
      END AS WorldRegions,
      SUM(monthly_revenue) AS SumRevenueRegion
FROM NetflixUserbase
GROUP BY WorldRegions
ORDER BY SumRevenueRegion DESC


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

	

-- #1: Users with Premium subscriptions generate higher monthly revenue compared to those with Base or Standard

SELECT subscription_type, SUM(monthly_revenue) AS TotalMonthlyRevenue
FROM NetflixUserbase
GROUP BY subscription_type
ORDER BY TotalMonthlyRevenue DESC


-- #2: Users who access Netflix primarily through desktop devices generate more revenue on average than those who access through mobile devices

SELECT device, AVG(monthly_revenue) AS AvgRevenueDevice
FROM NetflixUserbase
GROUP BY device
ORDER BY AvgRevenueDevice DESC


-- #3: On average older users are more likely to subscribe to Premium plans than younger users

SELECT subscription_type, AVG(age) AS AvgAgeSubType
FROM NetflixUserbase
GROUP BY subscription_type
ORDER BY AvgAgeSubType DESC


-- #4: Mid adults (age 35-42) generate higher monthly revenue than young adults (age 26-34) and mature adults (age 43-51)

SELECT CASE
	WHEN age <= 34 then 'Young Adults'
        WHEN age BETWEEN 35 AND 42 THEN 'Mid Adults'
        WHEN age >= 43 THEN 'Mature Adults'
      END AS AgeBracket,
      SUM(monthly_revenue) AS SumRevenueAge
FROM NetflixUserbase
GROUP BY AgeBracket
ORDER BY SumRevenueAge DESC


-- #5: Users located in the North American region typically spend more on Netflix on a month-to-month basis
/* North America: Canada, United States, Mexico
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






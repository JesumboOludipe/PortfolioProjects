-- World Energy and CO2 Emissions Analysis

-- COMMANDS & SKILLS USED - SELECT, FROM, UPDATE, SET, WHERE, ALTER TABLE, ALTER COLUMN, GROUP  BY, ORDER BY, LEFT JOIN,
-- DISTINCT, CASE WHEN, WITH, DROP COLUMN, NESTED QUERIES, TEMP TABLES 

-- COLUMNS AND UNITS
-- Country, Energy Type, Year (1980 - 2019), Energy Consumption (quad Btu), Energy Production (quad Btu), 
-- Gross Domestic Product - GDP  (Billion 2015$ PPP), Population (MPerson) , Energy_intensity_per_capita (MMBtu/person), 
-- Energy_intensity_by_GDP (1000 Btu/2015$ GDP PPP), and CO2 Emmissions  (MMtonnes CO2).

-- WORLDWIDE ANALYSIS
-- World Energy and CO2 Emissions Data in most recent year (2019)
-- World Energy and CO2 Emissions Data from 1980 to 2019
-- World CO2 emissions and Population from 1980 to 2019
-- World Energy Consumption, Energy Production, and deficit or surplus from 1980 to 2019
-- World Energy Consumption and Energy Production for each energy type in most recent year (2019)
-- Total C02 emission from each energy type in most recent year (2019)

-- TREND ANALYSIS
-- Yearly World CO2 Emissions (1980-2019)
-- Year-on-Year World CO2 Emissions Difference and Percentage Difference

-- CORRELATION ANALYSIS
-- Correlation Coefficients between energy consumption, GDP, population, and CO2 emissions

-- REGIONAL ANALYSIS
-- Unique Regions
-- Regional GDP, Population, and CO2 Emissions in most recent year (2019)
-- Energy_consumption, Energy_production, and CO2 Emissions by Region
-- CO2 Emissions and Percentage of Total by Region
-- Region by Energy_intensity_per_capita, Energy_intensity_by_GDP

-- COUNTRY ANALYSIS
-- Unique Countries
-- View a Particular country energy and CO2 emissions data for most recent year (2019)
-- Countries by Energy_consumption, Energy_production, and CO2 Emissions
-- Top 10 Countries by GDP, Population, and CO2 Emission, Ranked by Population
-- Top 10 Countries by C02 Emissions And Percentage of Total in 2019
-- Countries by Energy_intensity_per_capita, Energy_intensity_by_GDP

-- VIEW ENTIRE TABLE

SELECT *
FROM ENERGY

SELECT *
FROM CONTINENTS

-- VIEW JOINED TABLE
SELECT *
FROM ENERGY
LEFT JOIN CONTINENTS
ON ENERGY.Country = CONTINENTS.Country

-- World Energy and CO2 Emissions Analysis

-- WORLDWIDE ANALYSIS
-- World Energy and CO2 Emissions Data in most recent year (2019)

SELECT *
FROM ENERGY
WHERE Country = 'World'
AND Energy_type = 'all_energy_types'
AND Year = 2019

-- World Energy and CO2 Emissions Data from 1980 to 2019

SELECT *
FROM ENERGY
WHERE Country = 'World'
AND Energy_type = 'all_energy_types'

-- World CO2 emissions and Population from 1980 to 2019

SELECT Year, Population, CO2_emission 
FROM ENERGY
WHERE Country = 'World'
AND Energy_type = 'all_energy_types'

-- World Energy Consumption, Energy Production, and deficit or surplus from 1980 to 2019

SELECT Country, Energy_production,  Energy_consumption, (Energy_production - Energy_consumption) AS Energy_difference
FROM ENERGY
WHERE Country = 'World'
AND Energy_type = 'all_energy_types'

-- World Energy Consumption and Energy Production for each energy type in most recent year (2019)

SELECT Country, Energy_type, Energy_consumption, Energy_production, CO2_emission
FROM ENERGY
WHERE Country = 'World'
AND Year = 2019
ORDER BY Energy_consumption DESC

-- Total C02 emmission from each energy type in most recent year (2019)

SELECT Country, Energy_type, CO2_emission 
FROM ENERGY
WHERE Country = 'World'
AND Year = 2019


--TREND ANALYSIS

-- Yearly World CO2 Emissions (1980-2019)

SELECT Year, 
	   SUM(Energy_consumption) AS Total_Energy_consumption,
       SUM(Energy_production) AS Total_Energy_production,
	   SUM (CO2_emission) AS Total_CO2_emission
FROM ENERGY
WHERE Country = 'World'
	  AND Energy_type = 'all_energy_types'
GROUP BY Year

-- Year on Year World CO2 Emissions Difference and Percentage Difference
-- Create a regular table to store total CO2 emissions for each year

CREATE TABLE #temp_total_emissions (
    Year INT,
    Total_CO2_emission DECIMAL(10, 2)
);

INSERT INTO #temp_total_emissions (Year, Total_CO2_emission)
SELECT Year, SUM(CO2_emission) AS Total_CO2_emission
FROM ENERGY
WHERE Country = 'World' AND Energy_type = 'all_energy_types'
GROUP BY Year;

-- Create another regular table to calculate year-on-year and percentage increases
CREATE TABLE #temp_increases (
    Year INT,
    Total_CO2_emission DECIMAL(10, 2),
    Yearly_Difference DECIMAL(10, 2),
    Percentage_Difference DECIMAL(10, 2)
);

INSERT INTO #temp_increases (Year, Total_CO2_emission, Yearly_Difference, Percentage_Difference)
SELECT t1.Year, t1.Total_CO2_emission, t1.Total_CO2_emission - t2.Total_CO2_emission AS Yearly_Difference,
       ROUND(((t1.Total_CO2_emission - t2.Total_CO2_emission) / t2.Total_CO2_emission) * 100, 2) AS Percentage_Difference
FROM #temp_total_emissions t1
JOIN #temp_total_emissions t2 ON t1.Year = t2.Year + 1;

-- Fetch the results from the #temp_increases table
SELECT Year, Total_CO2_emission, Yearly_Difference, Percentage_Difference
FROM #temp_increases;

-- Calculate average yearly difference and average percentage difference
DECLARE @AverageYearlyDifference DECIMAL(10, 2);
DECLARE @AveragePercentageDifference DECIMAL(10, 2);

SELECT @AverageYearlyDifference = AVG(Yearly_Difference),
       @AveragePercentageDifference = AVG(Percentage_Difference)
FROM #temp_increases;

-- Display average differences
SELECT @AverageYearlyDifference AS Average_Yearly_Difference, 
	   @AveragePercentageDifference AS Average_Percentage_Difference;

-- Drop the temporary tables
DROP TABLE #temp_total_emissions;
DROP TABLE #temp_increases;


-- CORRELATION ANALYSIS
-- Correlation Coefficients between energy consumption, GDP, population, and CO2 emissions 

SELECT
    (SUM(Energy_consumption * CO2_emission) - (SUM(Energy_consumption) * SUM(CO2_emission) / COUNT(*))) /
    (SQRT((SUM(POWER(Energy_consumption, 2)) - POWER(SUM(Energy_consumption), 2) / COUNT(*)) *
        (SUM(POWER(CO2_emission, 2)) - POWER(SUM(CO2_emission), 2) / COUNT(*)))) AS Consumption_Emission_Correlation,
    (SUM(GDP * CO2_emission) - (SUM(GDP) * SUM(CO2_emission) / COUNT(*))) /
    (SQRT((SUM(POWER(GDP, 2)) - POWER(SUM(GDP), 2) / COUNT(*)) *
        (SUM(POWER(CO2_emission, 2)) - POWER(SUM(CO2_emission), 2) / COUNT(*)))) AS GDP_Emission_Correlation,
    (SUM(Population * CO2_emission) - (SUM(Population) * SUM(CO2_emission) / COUNT(*))) /
    (SQRT((SUM(POWER(Population, 2)) - POWER(SUM(Population), 2) / COUNT(*)) *
        (SUM(POWER(CO2_emission, 2)) - POWER(SUM(CO2_emission), 2) / COUNT(*)))) AS Population_Emission_Correlation
FROM ENERGY
WHERE Energy_type = 'all_energy_types';


-- REGIONAL ANALYSIS

-- Unique Regions

SELECT COUNT (DISTINCT Region) AS Regions
FROM CONTINENTS

-- Regional GDP, Population, and CO2 Emissions in most recent year (2019)

SELECT Region, 
	   SUM(GDP) AS GDP, 
	   SUM(Population) Population, 
	   SUM (CO2_emission) AS Regional_CO2_emission
FROM ENERGY
LEFT JOIN CONTINENTS
ON ENERGY.Country = CONTINENTS.Country
WHERE Energy_type = 'all_energy_types'
	  AND Year = 2019
	  AND Region is NOT NULL
GROUP BY Region
ORDER  BY Regional_CO2_emission DESC

--  Energy_consumption, Energy_production, and CO2 Emissions by Region

SELECT Region, SUM(Energy_consumption) AS Regional_Energy_consumption, 
	   SUM (Energy_production) AS Regional_Energy_production, 
	   SUM (CO2_emission) AS Regional_CO2_emission
FROM ENERGY
LEFT JOIN CONTINENTS
ON ENERGY.Country = CONTINENTS.Country
WHERE Energy_type = 'all_energy_types'
	  AND Year = 2019
	  AND Energy_type = 'all_energy_types'
	  AND Region IS NOT NULL
GROUP BY Region
ORDER BY Regional_CO2_emission DESC

-- CO2 Emissions and Percentage of Total by Region

SELECT Region,
       SUM(CO2_emission) AS Regional_CO2_emission,
       ROUND(SUM(CO2_emission) / (SELECT SUM(CO2_emission) 
                                  FROM ENERGY 
                                  WHERE Year = 2019 
                                        AND Energy_type = 'all_energy_types' 
                                        AND Country != 'World') * 100, 2) AS Percentage_of_Total
FROM ENERGY
LEFT JOIN CONTINENTS ON ENERGY.Country = CONTINENTS.Country
WHERE Energy_type = 'all_energy_types'
      AND Year = 2019
      AND Region IS NOT NULL
GROUP BY Region
ORDER BY Regional_CO2_emission DESC;

-- Energy_intensity_per_capita, Energy_intensity_by_GDP by Region

SELECT Region, 
	   SUM (Energy_intensity_per_capita) AS  Energy_intensity_per_capita, 
	   SUM (Energy_intensity_by_GDP) as Energy_intensity_by_GDP
FROM ENERGY
LEFT JOIN CONTINENTS ON ENERGY.Country = CONTINENTS.Country
WHERE Energy_type = 'all_energy_types'
      AND Year = 2019
      AND Region IS NOT NULL
GROUP BY Region
ORDER BY SUM (Energy_intensity_per_capita) DESC


-- COUNTRY ANALYSIS

-- Unique Countries

SELECT COUNT (DISTINCT Country) AS Countries
FROM ENERGY

-- View a Particular country energy and CO2 emissions data for most recent year (2019)

SELECT *
FROM ENERGY
LEFT JOIN CONTINENTS ON ENERGY.Country = CONTINENTS.Country
WHERE ENERGY.Country = 'Nigeria' /*(Edit this to any country)*/
	  AND Year = 2019

SELECT *
FROM ENERGY
LEFT JOIN CONTINENTS ON ENERGY.Country = CONTINENTS.Country
WHERE ENERGY.Country = 'United States' /*(Edit this to any country)*/
	  AND Year = 2019

-- Countries by Energy_consumption, Energy_production, and CO2 Emissions

SELECT Country, Energy_consumption, Energy_production, CO2_emission
FROM ENERGY
WHERE Year = 2019
AND Energy_type = 'all_energy_types'
AND Country != 'World'
ORDER BY CO2_emission DESC

-- Top 10 Countries by GDP, Population, and CO2 Emission, Ranked by Population

SELECT TOP 10 Country, GDP, Population, CO2_emission
FROM ENERGY
WHERE Year = 2019
AND Energy_type = 'all_energy_types'
AND Country != 'World'
ORDER BY Population DESC

-- Top 10 Countries by C02 Emissions And Percentage of Total in 2019

SELECT TOP 10 Country, 
       CO2_emission,
       ROUND (CO2_emission / (SELECT SUM(CO2_emission) 
					   FROM ENERGY 
					   WHERE Year = 2019 
					   AND Energy_type = 'all_energy_types' 
					   AND Country != 'World') * 100, 2 ) AS Percentage_of_Total
FROM ENERGY
WHERE Year = 2019
      AND Energy_type = 'all_energy_types'
      AND Country != 'World'
ORDER BY CO2_emission DESC;

-- Top 10 Countries by Energy_intensity_per_capita, Energy_intensity_by_GDP

SELECT TOP 10 Country, Energy_intensity_per_capita, Energy_intensity_by_GDP
FROM ENERGY
WHERE Year = 2019
AND Energy_type = 'all_energy_types'
AND Country != 'World'
ORDER BY Energy_intensity_per_capita DESC


--VIEW ENTIRE TABLE

SELECT *
FROM ENERGY


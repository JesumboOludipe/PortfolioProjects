--Sylip Corporation Sales Analysis,

-- Commands Used - SELECT, FROM, WHERE, ALTER TABLE, ALTER COLUMN, GROUP  BY, ORDER BY, MONTH, ADD, UPDATE, SET, DROP COLUMN.

--View Data
SELECT * FROM SALES_DATA2

--DATA CLEANING
--Change Order_Date and Ship_Date from Datetime to Date
ALTER TABLE SALES_DATA2
ALTER COLUMN Order_Date DATE

ALTER TABLE SALES_DATA2
ALTER COLUMN Ship_Date DATE

--Change Units_Sold from datetime to int
ALTER TABLE SALES_DATA2
ADD Units_Sold_Converted INT

UPDATE SALES_DATA2
SET Units_Sold_Converted = CONVERT(INT, Units_Sold)

--Unit_Price and Unit_Cost Datetime to Money
ALTER TABLE SALES_DATA2
ADD Unit_Price_Converted MONEY

UPDATE SALES_DATA2
SET Unit_Price_Converted = CONVERT(MONEY, Unit_Price)

ALTER TABLE SALES_DATA2
ADD Unit_Cost_Converted MONEY

UPDATE SALES_DATA2
SET Unit_Cost_Converted = CONVERT(MONEY, Unit_Cost)

--Change Total_revenue from Datetime to Money
ALTER TABLE SALES_DATA2
ADD Total_Profit_Converted MONEY

UPDATE SALES_DATA2
SET Total_Profit_Converted = CONVERT(MONEY, Total_Profit)

SELECT * FROM SALES_DATA

--Deleting Columns with previous data formats
ALTER TABLE SALES_DATA2
DROP COLUMN Order_Date, Ship_Date, Units_Sold, Unit_Price, Unit_Cost, Total_Profit, Total_Revenue_Converted

--KPIs
--KPI 1: Profit from all Region
SELECT 
	DISTINCT Region,
	SUM(Total_Profit) AS Profit
FROM 
	SALES_DATA2
GROUP BY
	Region

--KPI 2: Revenue made Annually
SELECT 
	YEAR(Order_Date) AS Year,
	SUM (Total_Revenue) AS Revenue
FROM 
	SALES_DATA
GROUP BY 
	YEAR(Order_Date)

--KPI 3: Compare year by year total units sold
SELECT 
	YEAR(Order_Date) AS Year,
	SUM (Units_Sold) AS Units_Sold
FROM 
	SALES_DATA
GROUP BY 
	YEAR(Order_Date)

--KPI 4: Rate of total revenue achieved annually
SELECT 
	YEAR(Order_Date) AS Year,
	SUM (Total_Revenue) *100 / (SELECT SUM(Total_Revenue) FROM SALES_DATA) AS Rate
FROM 
	SALES_DATA
GROUP BY 
	YEAR(Order_Date)

--KPI 5: Average amount of profit achieved annually
SELECT 
	YEAR(Order_Date) AS Year,
	AVG (Total_Profit) AS Average_Profit
FROM 
	SALES_DATA
GROUP BY 
	YEAR(Order_Date)

--KPI 6: Count of item types sold in Region
SELECT 
	DISTINCT Region,
	COUNT (Item_Type) AS Item_Type
FROM 
	SALES_DATA
GROUP BY 
	Region

--KPI 7: Top 4 countries with highest and lowest revenue
SELECT 
	DISTINCT TOP(4) Country,
	SUM(Total_Revenue) AS Revenue
FROM 
	SALES_DATA
GROUP BY 
	Country
ORDER BY
	SUM(Total_Revenue) DESC

SELECT 
	DISTINCT TOP(4) Country,
	SUM(Total_Revenue) AS Revenue
FROM 
	SALES_DATA
GROUP BY 
	Country
ORDER BY
	SUM(Total_Revenue) ASC

--KPI 8: Top 5 countries with lowest units sold below the bench market target of 50,000 units
SELECT 
	DISTINCT TOP (5)Country,
	SUM(Units_Sold) AS Units_Sold
FROM 
	SALES_DATA
WHERE
	Units_Sold < 50000
GROUP BY 
	Country
ORDER BY
	SUM(Units_Sold) ASC


SELECT * FROM SALES_DATA

--Further analysis and visualization done in Power BI.

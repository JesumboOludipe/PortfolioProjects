
# Energy and CO2 Emissions Analysis

## Introduction
This project focuses on analyzing energy consumption and CO2 emissions data to gain insights into global energy trends and their environmental impact. The project utilizes SQL to extract, transform, and analyze data from a database containing information on energy consumption, energy production, GDP, population, and CO2 emissions.

## Skills 
- SQL: Proficient in writing SQL queries to extract and manipulate data.
- Data Analysis: Able to perform various analytical tasks, including trend analysis, correlation analysis, and comparative analysis.
- Visualization: Plan to use visualization tools (e.g., Python's matplotlib, Power BI) to visualize data and generate meaningful charts and graphs.

## Analysis
The analysis performed in this project includes:

1. Trend Analysis: Calculating and visualizing the yearly trends in energy consumption, energy production, and CO2 emissions.
2. Correlation Analysis: Examining the relationships between energy consumption, GDP, population, and CO2 emissions using correlation coefficients.
3. Regional Analysis: Analyzing energy consumption, energy production, and CO2 emissions by regions to identify regional patterns and differences.
4. Country Analysis: Investigating energy profiles, CO2 emissions, and energy intensity metrics for individual countries to identify notable cases and trends.

## Results
The key findings from the analysis include:

- Trend Analysis: The energy consumption and CO2 emissions have generally increased over the years, while energy production has shown some variations.
- Correlation Analysis: A positive correlation exists between energy consumption and CO2 emissions, with varying strengths across different countries.
- Regional Analysis: Regions with higher GDP tend to have higher energy consumption and CO2 emissions, but the intensity levels vary. The regions with the most O2 Emissions are Asia, Europe, and the Americas
- Country Analysis: Certain countries exhibit higher energy intensity or CO2 emissions, providing insights into potential areas for improvement and policy interventions.

## Code and Tables

-- COLUMNS AND UNITS
-- Country, Energy Type, Year (1980 - 2019), Energy Consumption (quad Btu), Energy Production (quad Btu), 
-- GDP  (Billion 2015$ PPP), Population (MPerson) , Energy_intensity_per_capita (MMBtu/person), 
-- Energy_intensity_by_GDP (1000 Btu/2015$ GDP PPP), and CO2 Emmissions  (MMtonnes CO2).

-- WORLDWIDE ANALYSIS
-- World Energy and CO2 Emissions Data in the most recent year (2019)

![World2019](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/2.png)

![World2019 Table](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/World%20data.png)


-- World Energy and CO2 Emissions Data from 1980 to 2019

![World 1980 - 2019](

![World 1980 - 2019]
-- World CO2 emissions and Population from 1980 to 2019
-- World Energy Consumption, Energy Production, and deficit or surplus from 1980 to 2019
-- World Energy Consumption and Energy Production for each energy type in the most recent year (2019)
-- Total C02 emission from each energy type in the most recent year (2019)

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
-- Countries by Energy_intensity_per_capita, Energy_intensity_by_GDP

## Usage and Future Work
This project can serve as a starting point for further analysis and exploration of energy and CO2 emissions data. The SQL code provided can be modified and expanded to incorporate additional analysis or explore specific research questions.

Possible future work includes:
- Deepening the regional and country-level analysis to identify specific factors contributing to energy consumption and CO2 emissions.
- Conducting predictive modeling to forecast future energy trends and evaluate the effectiveness of potential mitigation strategies.
- Exploring additional data sources and integrating external datasets to enrich the analysis and provide a more comprehensive understanding of the energy landscape.

## Conclusion
This project showcases the utilization of SQL for analyzing energy consumption and CO2 emissions data. Through various analyses, insights into global energy trends, correlations, and regional disparities can be obtained. The project serves as a foundation for further exploration and research in the field of energy and environmental analysis.

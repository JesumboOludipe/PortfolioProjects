# World Energy and CO2 Emissions Analysis

> A SQL analysis of global energy consumption, production, and CO2 emissions from **1980 to 2019**, examining trends, correlations, and regional and country patterns. The headline finding: energy consumption and CO2 emissions rose steadily over the period, and the two are strongly and positively correlated, with **Asia, Europe, and the Americas** as the top-emitting regions.

**Tools:** `SQL Server` (T-SQL)
**Type:** Exploratory data analysis, trend and correlation analysis
**Data:** Country-level energy and emissions data, 1980 to 2019
**Links:** [Full PDF report](./World%20Energy%20and%20CO2%20Emissions%20Analysis%20Report.pdf) · [SQL script](./Countries'%20Energy%20Production%20and%20CO2%20Emissions.sql)

## Overview
This project uses SQL to extract, transform, and analyze a database of energy consumption, production, GDP, population, and CO2 emissions, in order to understand global energy trends and their environmental impact at the world, regional, and country levels.

## Key findings
- **Trend:** energy consumption and CO2 emissions generally rose from 1980 to 2019, while production showed more variation.
- **Correlation:** a strong positive correlation exists between energy consumption and CO2 emissions, with strengths that vary by country.
- **Regional:** higher-GDP regions tend to consume more energy and emit more CO2, though energy intensity varies; the largest emitters are Asia, Europe, and the Americas.
- **Country:** certain countries stand out on energy intensity or emissions, highlighting where policy and efficiency gains could matter most.

## Analysis performed
Trend analysis of year-on-year change, correlation analysis between energy, GDP, population, and emissions, regional comparison, and country-level profiling. The queries use aggregate functions, views, and window calculations, and the SQL script is included for review.

### Columns and units
Country, Energy Type, Year (1980 to 2019), Energy Consumption (quad Btu), Energy Production (quad Btu), GDP (Billion 2015$ PPP), Population (MPerson), Energy intensity per capita (MMBtu/person), Energy intensity by GDP (1000 Btu/2015$ GDP PPP), and CO2 Emissions (MMtonnes CO2).

## Detailed results

### Worldwide

World energy and CO2 emissions in the most recent year (2019):

![World2019](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/World2019.png)
![World2019 Table](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/World%20data.png)

World population and CO2 emissions from 1980 to 2019:

![World 1980 to 2019](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/World1980.png)
![World 1980 to 2019 Table a](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/World%201980a.png)
![World 1980 to 2019 Table b](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/World%201980b.png)

World consumption, production, and CO2 by energy type (2019):

![Energy Types](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/energy%20types.png)
![Energy Types Table](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/Energy%20types%20table.png)

### Trend analysis

Year-on-year world CO2 emissions difference, percentage difference, and averages:

![YoY](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/YoY.png)
![YoY Table a](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/YoYa.png)
![YoY Table b](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/YoYb.png)

### Correlation analysis

Correlation coefficients between energy consumption, GDP, population, and CO2 emissions:

![Corr](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Corr.png)
![Corr Table](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/Corr%20Table.png)

### Regional analysis

Regional GDP, population, consumption, production, and CO2, ranked by emissions (2019):

![Regional CO2](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Regional%20CO2.png)
![Regional CO2 Table](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/Regional%20CO2%20Table.png)

Regions by energy intensity per capita and by GDP:

![Regional Intensity](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Regional%20Intensity.png)
![Regional Intensity Table](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/Regional%20Intensity%20table.png)

### Country analysis

A single country's energy and CO2 profile for 2019 (Nigeria and the United States as examples):

![View Country](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/View%20Country.png)
![View Country Table](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/View%20Country%20Table.png)

Top 10 countries by emissions, with share of total:

![Country CO2](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Country%20CO2.png)
![Country CO2 Table](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/Country%20CO2%20Table.png)

Top 10 countries by energy intensity per capita and by GDP:

![Country Intensity](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Country%20Intensity.png)
![Country Intensity Table](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Countries'%20Energy%20Production%20and%20CO2%20Emissions/SQL%20Images/Results/Country%20Intensity%20Table.png)

## Skills demonstrated
SQL extraction and transformation, aggregate and window functions, views, trend and correlation analysis, and clear reporting of quantitative results.

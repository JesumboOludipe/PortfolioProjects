# COVID-19 Data Exploration (SQL Server)

> An exploratory SQL analysis of global COVID-19 cases, deaths, and vaccinations (January 2020 to April 2021), building the queries and views behind a Tableau dashboard.

**Tools:** `SQL Server` (T-SQL) · `Tableau`
**Type:** Exploratory data analysis
**Code:** [COVID-19 Data Exploration.sql](./COVID-19%20Data%20Exploration.sql)

## Overview
This project explores worldwide COVID-19 data across two tables, deaths and vaccinations, to answer questions about how the pandemic spread and how vaccination rolled out. It covers the country, continent, and global levels, and prepares clean views for downstream visualization in Tableau.

## Questions explored
- How likely was death after infection (death rate) in a given country, for example the United States and Nigeria?
- What share of each country's population was infected over time?
- Which countries and continents had the highest infection and death counts relative to population?
- What were the global daily and cumulative case and death totals, and the overall death rate?
- What share of each population received at least one vaccine dose, tracked as a running total over time?

## Techniques used
Joins across the deaths and vaccinations tables, aggregate functions, `CASE` and type conversion for clean calculations, common table expressions and temp tables to compute rolling vaccination counts with window functions (`SUM() OVER (PARTITION BY ...)`), and a `CREATE VIEW` to store results for Tableau.

## Skills demonstrated
Joins, CTEs, temp tables, window functions, aggregate functions, creating views, converting data types, and structuring exploratory queries to feed a BI tool.

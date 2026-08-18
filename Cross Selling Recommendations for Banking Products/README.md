# Data-Driven Cross-Selling Opportunities in a Spanish Bank

> Analysis of **13.6 million customer records** from a large Spanish bank to profile customers and surface the **top 10 cross-selling opportunities**, with the headline insight that nearly half of customers hold only one product and over a quarter hold none, a large untapped revenue base.

**Tools:** `Python` · `pandas` · `NumPy` · `Matplotlib` · `Power BI`
**Type:** Customer behavior analysis and cross-selling
**Data:** 13,647,308 records, reduced to 949,609 unique customers (provided during a Data Glacier internship)
**Links:** [Interactive Power BI dashboard](https://app.powerbi.com/view?r=eyJrIjoiMzA2NDlkOTItZWQyYi00YmQwLWIyZTAtOTZjOTFjY2Y1OTdkIiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9) · [Python notebook](./Cross-Selling%20Project.ipynb)

## Overview
This project analyzes the customers of a large Spanish bank and the products they hold (current and savings accounts, mortgages, loans, credit cards, and more) to understand who they are and where the bank can responsibly cross-sell. Because the source was a Latin-American bank, cleaning included translating Spanish column names and values into English before analysis.

## Key findings
- **Product gaps drive the opportunity:** most customers own only 0 to 2 products; nearly half hold just one and over a quarter hold none.
- **Gender:** 54.29% female, 45.71% male.
- **Age:** the largest group is 41 to 60 years old (33.26%), followed by 19 to 25 (27.90%).
- **Income:** the 50,000 to 100,000 band is largest (38.35%), then 100,000 to 150,000 (24.17%).
- **Products:** current accounts and debit cards are the most commonly held; savings accounts and guarantees the least.
- **Output:** a ranked list of the top 10 cross-selling opportunities, such as pairing payroll accounts with pension plans and direct debits.

## Approach
Data cleaning and translation, feature engineering, exploratory data analysis, and visualization in Python, followed by an interactive Power BI dashboard to communicate the findings to stakeholders.

## Recommendations
Build targeted campaigns around the top opportunities, focus on single-product customers, streamline and bundle product offerings, and use customer feedback to lift cross-selling and revenue from the existing base.

![Dashboard](https://github.com/JesumboOludipe/PortfolioProjects/blob/main/Cross%20Selling%20Recommendations%20for%20Banking%20Products/cross%20sell.png)

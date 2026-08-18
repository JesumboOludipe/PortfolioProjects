# Movie Correlation Analysis (Python)

> An exploratory analysis of 6,820 movies (1986 to 2016) asking what actually drives box-office gross. The headline finding: **budget and vote count are the strongest predictors of revenue, while company, genre, and director show little correlation.**

**Tools:** `Python` · `pandas` · `NumPy` · `seaborn` · `matplotlib`
**Type:** Exploratory data analysis and correlation
**Data:** IMDB movie data (scraped by Daniel Grijalva, via Kaggle), 220 movies per year, 1986 to 2016
**Code:** [Data Correlation in Python - Movies Dataset.ipynb](../Data%20Correlation%20in%20Python%20-%20Movies%20Dataset.ipynb)

## Overview
What makes a movie earn? This project investigates the factors behind a film's gross revenue, testing whether budget, votes, ratings, genre, company, or director best explain success across three decades of movies.

## Approach
1. **Cleaning:** checked every column for missing values, dropped incomplete rows, and corrected data types for budget, votes, and gross.
2. **Feature fixes:** derived a correct release year from the `released` field and sorted and de-duplicated the data.
3. **Outlier check:** used box plots to inspect the distribution of gross revenue.
4. **Correlation:** built Pearson correlation matrices and visualized them as heatmaps, encoding categorical fields numerically so they could be included.
5. **Ranking:** extracted and sorted the correlations against gross to surface the strongest relationships.

## Key findings
- **Budget** has a strong positive correlation with gross revenue: bigger budgets tend to mean bigger earnings.
- **Vote count** is the other strong predictor of gross.
- **Company, genre, and director** show weak correlation with revenue, suggesting they matter far less than spend and audience engagement.

## Skills demonstrated
Data cleaning, type handling, feature engineering, outlier detection, Pearson correlation analysis, and visualization with scatter/regression plots and heatmaps.

> Note: the notebook file lives at the repository root as `Data Correlation in Python - Movies Dataset.ipynb`; this folder holds its write-up.

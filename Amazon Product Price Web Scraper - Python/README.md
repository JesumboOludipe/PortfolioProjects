# Amazon Product Price Web Scraper (Python)

> An automated Python scraper that tracks an Amazon product's price over time and emails an alert when it drops below a target, turning a live web page into a clean, timestamped price history.

**Tools:** `Python` · `BeautifulSoup` · `Requests` · `pandas` · `csv` · `smtplib`
**Type:** Automation and web scraping
**Code:** [Amazon Web Scraper - Python.ipynb](./Amazon%20Web%20Scraper%20-%20Python.ipynb)

## Overview
This project collects product data (title and price) directly from an Amazon product page and builds a growing price-tracking dataset. Each run captures the current price with a timestamp and appends it to a CSV, so that over time the file becomes a price history you can chart or monitor. An optional email routine sends an alert the moment the price falls below a set threshold, making it a practical personal price checker.

## What it does
1. Sends a request to the product URL with browser-style headers, then parses the HTML with BeautifulSoup.
2. Extracts the product title and price, and cleans both values.
3. Stamps each capture with the current date.
4. Writes the row to a CSV, appending on every run to accumulate history.
5. Wraps the whole flow in a `check_price()` function that can run on a timer for continuous tracking.
6. Includes a `send_mail()` routine using `smtplib` to notify by email when the price drops below the target.

## Skills demonstrated
Web scraping and HTML parsing, data cleaning, working with CSV files, task automation and scheduling, and basic email automation with SMTP.

## Notes
Amazon's page structure and anti-bot measures change over time, so the CSS selectors may need occasional updating. Any email credentials should be supplied through environment variables or an app password rather than hard-coded.

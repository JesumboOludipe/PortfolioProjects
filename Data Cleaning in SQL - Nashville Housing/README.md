# Data Cleaning in SQL: Nashville Housing (SQL Server)

> A SQL Server script that takes a raw Nashville housing dataset and makes it analysis-ready: standardized dates, filled-in addresses, split location fields, normalized flags, and de-duplicated records.

**Tools:** `SQL Server` (T-SQL)
**Type:** Data cleaning and transformation
**Code:** [Nashville Housing Data Cleaning.sql](./Nashville%20Housing%20Data%20Cleaning.sql)

## Overview
Raw property data is rarely ready to use. This project walks through a full cleaning pipeline on the Nashville housing dataset, turning inconsistent, incomplete records into a clean table suitable for reporting and analysis, using only SQL.

## What the script does
1. **Standardizes the date format** by converting the `SaleDate` field to a proper `Date` type and storing it in a new column.
2. **Populates missing property addresses** using a self-join on `ParcelID`, filling nulls from matching records with `ISNULL`.
3. **Splits combined address fields into components** (address, city, state) two ways: with `SUBSTRING` and `CHARINDEX` for the property address, and with `PARSENAME` for the owner address.
4. **Normalizes the "Sold as Vacant" flag** from `Y`/`N` to `Yes`/`No` using a `CASE` statement for readability and consistency.
5. **Removes duplicate rows** by ranking records with `ROW_NUMBER()` inside a CTE partitioned on key columns, then filtering out the repeats.
6. **Drops unused columns** to leave a lean, final table.

## Skills demonstrated
`CONVERT` and data-type handling, self-joins, `ISNULL`, string functions (`SUBSTRING`, `CHARINDEX`, `PARSENAME`, `REPLACE`), `CASE` logic, common table expressions, window functions (`ROW_NUMBER`), and `ALTER TABLE` operations.

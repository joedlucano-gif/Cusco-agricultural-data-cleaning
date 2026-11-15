# Cusco Agricultural Production | SQL Data Cleaning

## Project Overview

Cleaning and validating **3,672 agricultural production records from Cusco, Peru**, using SQL and Google BigQuery.

**Goal:** Identify data-quality issues, standardize inconsistent values, and create a reliable dataset for agricultural analysis.

## Dataset

- **Source:** [Peru's National Open Data Platform — GERAGRI Cusco](https://www.datosabiertos.gob.pe/dataset/producci%C3%B3n-agr%C3%ADcola-periodos-2023-al-2025-en-la-regi%C3%B3n-de-cusco-geragri)
- **Period:** Agricultural campaigns 2023–2024 and 2024–2025
- **Tools:** SQL and Google BigQuery

## Data Cleaning Process

1. **Data profiling:** Checked missing values, duplicates, and inconsistencies.
2. **Standardization:** Cleaned crop names, dates, and production/yield fields.
3. **Validation:** Checked agricultural calculations and geographic codes.
4. **Quality control:** Flagged suspicious records without deleting them.
5. **Final output:** Created a reusable BigQuery view.

## Key Findings

| Metric | Result |
| Total records | 3,672 |
| Passed initial checks | 3,595 |
| Flagged for review | 77 |
| Invalid geographic codes | 49 |
| Malformed crop-code records | 1 |

These results reflect the initial validation rules. Flagged records remain available for further investigation.

## SQL Query

[View the complete SQL cleaning query](./Data_cleaning.sql)

The SQL script creates a BigQuery view named `cleaned_data`, preserving the original source data.

## Key Takeaway

**Reliable analysis starts with trustworthy data.**

This project demonstrates my approach to identifying, investigating, and documenting data-quality problems before building analytical dashboards.

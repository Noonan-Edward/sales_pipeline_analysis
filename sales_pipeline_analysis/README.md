# P1: Sales Pipeline Analysis
## Overview
Project 1 (P1) follows and analyzes a fictional B2B sales pipeline from acquiring leads & opportunities to closed-won and closed-lost deals. The workflow includes:
- A Python cleaning script that standardizes four raw CSV datasets retrieved from Maven Analytics' "data playground"
- A PostgreSQL database where clean data is modeled and queried on
- Several SQL insights covering revenue, various conversion rates/metrics, pipeline velocities, individual salesperson performances, and product trends
- Rudimentary visualizations highlighting actionable findings

This repository aims to reflect a real-world analytics workflow, emphasizing reproducibility and business value.

## Tech Stack
### Python
Pandas library

NumPy library

### SQL
PostgreSQL

pgAdmin 4

DBeaver (for environment)

### Microsoft PowerBI

### Git/GitHub
(For storage and management of project)

## Repository Structure

### sales-pipeline-analysis
data/
- raw/
- cleaned/

src/
- clean_data.py
- sql_queries.sql

notebooks/
- 01_data_cleaning.ipynb
- 02_exploration.ipynb
- 03_sql_analysis.ipynb

sql/
- schema.sql
- create_tables.sql
- insert_clean_data.sql
- analysis_queries.sql

outputs/
- charts/
- tables/
- dashboard_screenshots/

README.md

requirements.txt

## Data Cleaning Pipeline

The clean_data.py script intends to:
- rename & standardize columns
- cast date types
- handle nulls
- validate business rules
- export cleaned CSVs
- clear up innappropriate whitespace

This provides that PostgreSQL receives consistent data ready for analysis.

## Database Schema & SQL Modeling

The PostgreSQL layer offers:
- A relational schema that connects the four tables (accounts, products, sales_pipeline, and sales_teams) via each table's respective foreign key (FK).
- Table creation scripts (for "importing" the datasets)
- Analysis queries that can be used to generate valuable insights

## Key Insights

## Visualizations

## How to Run This Project
There are a few steps to take to set up and reproduce this project:
- Clone the repository structure
- Install dependencies (libraries, modules)
- Run clean_data.py on raw CSVs to generate cleaned CSVs
- Create PostgreSQL tables from /sql/create_tables.sql
- Load cleaned data using /sql/insert_clean_data.sql
- Run analysis queries in /sql/analysis_queries.sql
- View charts in /outputs/charts/

## Future Improvements
- Automated ETL (extract, transform, load) pipeline
- PowerPoint walkthrough
- Interactive dashboard
- Predictive modeling (likely via Python's Scikit learn, or sklearn, library)

## The Author

### Edward Noonan
Data Analyst with grounding experience in SQL, Python, R/RStudio, BI tools (PowerBI & Tableau), and overall analytics workflows.

This project was developed and polished as part of a post-graduation portfolio to demonstrate real-world data analysis (and engineering) capabilities.






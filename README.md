# P1: Sales Pipeline Analysis
## Overview
Project 1 (P1) follows and analyzes a fictional B2B sales pipeline from acquiring leads & opportunities to closed-won and closed-lost deals. The workflow includes:
- A Python cleaning script that standardizes four raw CSV datasets retrieved from Maven Analytics' "data playground"
- A PostgreSQL database where clean data is modeled and queried on
- Several SQL insights covering revenue, various conversion rates/metrics, pipeline velocities, individual salesperson performances, and product trends
- Rudimentary visualizations highlighting actionable findings

This repository aims to reflect a real-world analytics workflow while emphasizing reproducibility and business value.
## The Why/For What
Stumbling across this sales pipeline / CRM dataset on Maven Analytics posed me with what I believed to be a great opportunity to show off my grounding Python, SQL, and Data-Viz capabilities that I've been taking intiative to improve. Constantly looking for ways to grow (and put on display) my data analysis toolkit, I saw the learning opportunity as solid portfolio potential.

The hero question (or problem to solve), here, asks from where the greatest revenue potential is derived.

I planned to first clean the sales pipeline dataset's 4 individual tables using a tailored cleaning script in Python. What followed would be a brief but practical data quality check / exploratory analysis in Python. From there, I figured I could load the data into a readied PostgreSQL database of my own, query for insight, and draw actionable conclusions. Coupled with a few rudimentary but nonetheless high-yield visualizations produced in Microsoft Power BI, I planned to have developed a true front-to-end, portfolio-ready data analytics project.

## Tech Stack
### Python
Pandas library

NumPy library

### Matplotlib/Seaborn
(For exploratory data analysis)

### SQL
PostgreSQL

pgAdmin 4

DBeaver (for environment)

### Microsoft PowerBI

### Git/GitHub
(For storage and management of project)

## Repository Structure

### sales-pipeline-analysis
10-data/
- 11-raw/
- 12-cleaned/

20-src/
- 21-clean_data.py

30-notebooks/
- 31-data_cleaning.ipynb
- 32-exploration.ipynb

40-sql/
- 41-schema.sql
- 42-create_tables.sql
- 43-insert_clean_data.sql
- 44-analysis_queries.sql

50-outputs/
- 51-charts/
- 52-tables/
- 53-dashboard_screenshots/
- 54-reports/

60-README.md

70-requirements.txt

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

## Key Insights & Recommendations

Over the course of 8,800 sales opportunities spanning 437 days (1y 2mo), the fictional B2B organization generated roughly $10M in revenue with a remarkable 63% win rate.

Key findings unveil that Retail, Tech, and Medical industries dominate the pipeline, though Medical underperforms in terms of win rate. Product performance dramatically varies. The GTX Pro is the biggest revenue driver with quick sales engagement duration, while the GTK 500 generates hardly any revenue and significantly prolongs the overall sales cycle. 

Regarding regions, the West proves most efficient, yet the Central region closes the most deals. High-win-rate and high-volume sales agents make varying contributions to pipeline health, indicating the potential for targeted delegation.

#### Recommendations include assigning the strongest closers to low-win-rate industries, keeping high-volume closers on high-volume sectors, and discouraging GTK 500 prospecting due to poor ROI.

## Visualizations

<img width="898" height="432" alt="Screenshot 2026-05-25 174902" src="https://github.com/user-attachments/assets/10804b7c-74a8-4a67-9471-17bfb567d1c5" />

### Premise:
Highlights that most deals are closed, the remarkable win rate, and that there are many currently engaged/prospecting.

****
<img width="578" height="476" alt="Screenshot 2026-05-25 175413" src="https://github.com/user-attachments/assets/59bd24c2-56bb-48e1-ada3-689dc97a2793" />

### Premise:
Highlights the "big 3" industries and their respective deal win-rates.

****
<img width="397" height="388" alt="Screenshot 2026-05-25 175608" src="https://github.com/user-attachments/assets/fdf3c206-1a3b-474b-b1e2-f7d856fb5a72" />

### Premise:
Reaffirms the discouragement of GTK 500 prospecting while highlighting the GTX Pro as the undoubted breadwinner.

****
<img width="663" height="418" alt="Screenshot 2026-05-25 175851" src="https://github.com/user-attachments/assets/8aab0160-a899-4f25-a83c-9fbb656ccdfc" />

### Premise:
Emphasizes the West office's efficiency via "revenue per day engaged" metrics. Revenue per day engaged ≠ revenue per day; instead, it evaluates what one active sales opportunity yields the office per day. 

## Challenges/Caveats

#### Author's Limiting Factors
Entry-Level Python Expertise
- Redundancy
- Inefficiencies

Imperfect Data
- Limited data points
- Lack of product/organizational information


#### Author's Difficulties
Learning the PostgreSQL software
- Loading data
- Establishing & maintaining database connection
- Navigating DBeaver over pgAdmin 4


## How to Run This Project
There are a few steps to take to set up and reproduce this project:
- Clone the repository structure
- Install dependencies (libraries, modules)
- Run 21-clean_data.py on raw CSVs to generate cleaned CSVs

(Optional: View PostgreSQL schema for primary/foreign keys (PKs/FKs) from /40-sql/41-schema.sql)
- Create PostgreSQL tables from /40-sql/42-create_tables.sql
- Load cleaned data using /40-sql/43-insert_clean_data.sql
- Run analysis queries in /40-sql/44-analysis_queries.sql
- View charts in /50-outputs/51-charts/

## Future Improvements
- Automated ETL (extract, transform, load) pipeline
- PowerPoint walkthrough
- Interactive dashboard
- Predictive modeling (likely via Python's Scikit learn, or sklearn, library)

## The Author

### Edward Noonan
Data Analyst with grounding experience in SQL, Python, R/RStudio, BI tools (PowerBI & Tableau), and overall analytics workflows.

This project was developed and polished as part of a post-graduation portfolio to demonstrate real-world data analysis (and engineering) capabilities.






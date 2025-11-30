# World Life Expectancy - SQL Data Cleaning Project

This project focuses on cleaning and preparing the **World Life Expectancy** dataset using SQL.  
The goal is to demonstrate real-world data cleaning skills: finding duplicates, fixing missing values, validating fields and preparing the dataset for analysis.

---

## Files in this repository

- **world_life_expectancy_raw.csv**  
  Original dataset containing country, year, status, mortality metrics, vaccination, GDP, schooling, etc.

- **import_table.sql**  
  SQL script to create the database table and insert all raw records.

- **cleaning_steps.sql**  
  All SQL statements used to clean and validate the dataset, including:
  - detecting duplicate rows using `ROW_NUMBER()`
  - removing duplicates
  - fixing missing `Status` values through a self-join
  - standardizing fields
  - basic sanity checks

---

## SQL Skills Demonstrated

- Window functions (`ROW_NUMBER`, partitioning, ordering)
- Self joins for conditional updates
- Identifying and removing duplicate records
- Null/missing value cleanup
- Data validation checks
- Building structured cleaning scripts

---

## Dataset

The dataset includes:
- Life expectancy  
- Adult mortality  
- Infant deaths  
- Measles & Polio vaccination rates  
- GDP  
- BMI  
- Under-five mortality  
- Schooling years  
- Country & status (Developing / Developed)

Dataset source: Public educational dataset commonly used for exploratory SQL practice

---

## How to Run

1. Create a new MySQL database
2. Run `import_table.sql`
3. Run `cleaning_steps.sql`
4. Query the cleaned dataset as needed

This project is intentionally kept simple to showcase **pure SQL cleaning ability** with real data

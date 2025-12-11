# World Life Expectancy - SQL Data Cleaning and Exploratory Data Analysis (EDA)

This project focuses on cleaning, exploring, and analyzing the **World Life Expectancy** dataset using SQL.
It demonstrates real-world data cleaning skills and then extends into exploratory data analysis to understand patterns in life expectancy, GDP, BMI, country status, mortality trends, and more.

---

## Contents of the Repository

* **world_life_expectancy_raw.csv**
  Original dataset containing country, year, status, mortality metrics, vaccination, GDP, schooling, BMI, and other fields.

* **import_table.sql**
  SQL script used to create the database table and import all raw records.

* **cleaning_steps.sql**
  Full SQL pipeline for cleaning the dataset, including:

  * detecting and removing duplicates using `ROW_NUMBER()`
  * fixing missing `Status` values with a self join
  * filling missing values in relevant fields
  * sanity checks to validate the cleaned data

* **eda_queries.sql**
  All EDA queries used to study trends in life expectancy, GDP, BMI, country status, and rolling mortality.

* **eda_results.md**
  Written summary of findings from the exploratory data analysis.

---

## SQL Skills Demonstrated

### Data Cleaning Skills

* Window functions (`ROW_NUMBER()`)
* Identifying and removing duplicate records
* Updating missing categorical fields using self joins
* Standardizing inconsistent values
* Null handling and validation checks

### Exploratory Data Analysis Skills

* Grouped aggregations (`GROUP BY`, `HAVING`)
* Trend analysis across time
* Calculating min, max, and 15-year changes in life expectancy
* Conditional aggregations using `CASE`
* Categorization logic using CASE statements
* Rolling totals using window functions (`SUM() OVER`)
* Understanding data quality issues and interpreting results

---

## Dataset Overview

Each record includes:

* Country
* Year
* Life expectancy
* Adult mortality
* Infant deaths
* Vaccination rates
* GDP
* BMI
* Under-five mortality
* Schooling
* Status (Developing / Developed)

Dataset source: Public dataset frequently used for SQL learning and EDA projects.

---

# Exploratory Data Analysis Summary

After cleaning the dataset, I performed several analyses to understand trends and relationships in the data.

---

## 1. Life Expectancy Change Across 15 Years

By calculating MIN and MAX life expectancy per country (after filtering invalid 0 values), I measured how much each country improved over the 15-year span.

Countries with very high improvement (20 years or more):

* Haiti
* Zimbabwe
* Eritrea
* Uganda

Countries with very small improvement (2 years or less):

* Guyana
* Seychelles
* Kuwait
* Philippines
* Venezuela
* Mexico
* Saudi Arabia
* Tonga
* Uruguay

Overall, most countries show a positive upward trend in life expectancy.

---

## 2. Life Expectancy by Year

Averaging life expectancy across all countries for each year shows a steady increase.
The global pattern trends upward over the 2007 to 2022 period.

---

## 3. GDP and Life Expectancy

To explore whether higher GDP leads to longer life expectancy:

* I filtered out rows where GDP or life expectancy was 0
* Calculated average GDP and average life expectancy per country
* Sorted results by GDP (ascending and descending)

Observations:

* Countries with low GDP consistently show lower life expectancy
* Countries with high GDP show noticeably higher life expectancy
* The difference between the lowest and highest GDP levels is very large
* This suggests a positive correlation between GDP and life expectancy

A proper visualization tool (Tableau, Power BI) would confirm this visually, but the SQL results already show the pattern clearly.

---

## 4. Categorizing Countries (High vs Low GDP and Life Expectancy)

Initial bucket ideas:

* High GDP = GDP above a chosen threshold (about 1500 in this dataset)
* High Life Expectancy = life expectancy above ~75
* Low Life Expectancy = below ~65

These rough thresholds help segment countries for correlation checks and comparison.

---

## 5. Life Expectancy and Country Status

The dataset includes a `Status` field (Developed or Developing).

Counts:

* Developed countries: about 32
* Developing countries: about 161

Average life expectancy:

* Developed: around 80 years
* Developing: around 67 years

This lines up with global expectations.

---

## 6. BMI Observations

BMI values in this dataset appear unreliable.

* Many countries have average BMI in the 40+ range
* When averaging each country's BMI and then averaging those results, the world BMI comes out to about 39.55

With a quick google search, I found out the real global BMI is around 24, which shows the dataset's BMI field may not match real-world health statistics.
Because of this, BMI analysis does not lead to very strong conclusions.

---

## 7. Adult Mortality

While examining adult mortality, I noticed some inconsistencies and potential data quality issues.

Instead of forcing correlation analysis, I used a rolling total:

```
SUM(Adult Mortality) OVER (PARTITION BY Country ORDER BY Year)
```

This helps show long-term mortality trends even when individual yearly values are noisy.

---

# How to Run the Project

1. Create a MySQL database
2. Run `import_table.sql` to load the raw dataset
3. Run `cleaning_steps.sql` to perform all cleaning operations
4. Use `eda_queries.sql` to explore insights
5. Read `eda_results.md` for a human-friendly summary of what was discovered
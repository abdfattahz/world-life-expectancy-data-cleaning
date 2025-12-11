# World Life Expectancy - Exploratory Data Analysis (EDA)

This project explores the World Life Expectancy dataset that has already cleaned before.
Here is the process I followed, the queries I ran, and the insights I found.


# 1. Understanding Life Expectancy Changes (2007 to 2022)

First, I wanted to know how each country changed in life expectancy over the last 15 years.

When I calculated MIN and MAX life expectancy per country, I noticed something unusual:

* some countries showed 0 as their minimum or maximum life expectancy
* these 0 values are not realistic and indicate data quality issues
* so I filtered those out before analyzing the increase

After filtering the data, I calculated:

Life Increase = MAX(Life Expectancy) - MIN(Life Expectancy)

Countries with very large increases (20 years or more):

* Haiti
* Zimbabwe
* Eritrea
* Uganda

Countries with very small increases (2 years or less):

* Guyana
* Seychelles
* Kuwait
* Philippines
* Venezuela
* Mexico
* Saudi Arabia
* Tonga
* Uruguay

Overall, the global trend still shows that life expectancy is increasing year by year.


# 2. Life Expectancy by Year

Averaging life expectancy for each year shows a clear upward trend.
Even without visualization, the increase by year is easy to see from the query results.


# 3. Exploring GDP vs Life Expectancy

Next, I wanted to see whether GDP is correlated with life expectancy.

Before doing that, I noticed:

* some countries had GDP values of 0
* some had life expectancy values of 0
* these would distort averages

So I filtered out countries where the averages were zero.

Then I sorted the results by GDP.

Sorting GDP in ascending order:

* countries with low GDP also tend to have lower life expectancy
* this makes sense because lower GDP often means weaker healthcare and infrastructure

Sorting GDP in descending order:

* some countries have GDP values drastically higher than the lowest ones
* life expectancy is also noticeably higher for these high GDP countries

This suggests a positive correlation between GDP and life expectancy.
To confirm this visually, a tool like Tableau or Power BI would be helpful.


# 4. Categorizing Countries with CASE Statements

I wanted to create GDP buckets, such as:

* High GDP
* Low GDP

And similar buckets for life expectancy.

For life expectancy, I found:

* the top half is roughly around 75
* the bottom half is roughly around 65

So the top half lives about 10 years longer on average than the lower half.

These values can be used as thresholds in a CASE statement.


# 5. Life Expectancy by Status

The dataset contains a `Status` column (Developed vs Developing).

First, I checked how many countries were in each group:

* about 32 developed countries
* about 161 developing countries

So the developing group is much larger.

Average life expectancy by status:

* Developed: about 80 years
* Developing: about 67 years

This matches what we expect in real-world demographic patterns.


# 6. BMI Exploration

I attempted to compare BMI with life expectancy.

However, the BMI values in this dataset appear unreliable.
Many countries have average BMIs in the 40s or even higher.
The world average BMI I calculated (averaging each country's BMI) was around 39.55.

Real-world research shows that the global average BMI is around 24.
Because of this mismatch, drawing deep conclusions from this dataset's BMI values is not recommended.

Some countries show a pattern where higher BMI relates to lower life expectancy, but sometimes the opposite happens.
This inconsistency likely comes from data quality issues.


# 7. Adult Mortality

I looked briefly at whether adult mortality correlates with life expectancy.

However, adult mortality also shows signs of data quality problems.
Instead of forcing a correlation analysis, I used a rolling total to check how adult mortality changes over time for specific countries.

Rolling totals make it easier to see trends across years, even if individual values are noisy.


# Summary of Findings

* Life expectancy is generally rising over the 2007 to 2022 period.
* GDP and life expectancy have a clear positive correlation.
* Developed countries live significantly longer on average than developing countries.
* BMI values in this dataset are not reliable when compared to real global BMI values.
* Adult mortality has potential data quality issues.
* Rolling totals are useful for exploring long-term trends despite noisy data.

Possible next steps:

* Create visualizations in Tableau or Power BI.
* Build clear GDP or life expectancy categories with CASE statements.
* Investigate outliers more closely.
* Look for patterns based on region or continent.
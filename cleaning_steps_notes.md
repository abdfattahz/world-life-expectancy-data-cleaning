# World Life Expectancy - Cleaning Notes

These notes capture the reasoning behind the SQL cleaning steps.

## 1. Finding duplicates

- We want to know if there are duplicate records for the same `Country` and `Year`
- To do this, we create a **composite key** by concatenating `Country` and `Year`:
  - `CONCAT(Country, Year)` → a temporary unique identifier for each (Country, Year) pair
- We then `COUNT(*)` for each concatenated value and use `HAVING COUNT(*) > 1` to find duplicates
- This tells us *which* Country-Year combinations appear more than once

## 2. Locating the exact duplicate rows

- After finding which keys are duplicated, we need to see **which rows** in the table are duplicates
- We use `ROW_NUMBER() OVER (PARTITION BY CONCAT(Country, Year))`:
  - The partition groups rows by `Country + Year`
  - Any row where `Row_Num > 1` is considered a duplicate (the first row has `Row_Num = 1`)
- Because we want to filter on `Row_Num`, we wrap this in a **subquery** and then apply `WHERE Row_Num > 1` in the outer query
- This makes it easy to see exactly which rows will be deleted

## 3. Deleting duplicates safely

- To delete duplicates, we **only delete rows with `Row_Num > 1`**
- We do this by:
  - Reusing the same `ROW_NUMBER()` logic in a subquery
  - Selecting only the `Row_ID` values where `Row_Num > 1`
  - Deleting from `world_life_expectancy` where `Row_ID` is in that list
- Using a subquery avoids accidentally deleting the original, “good” record (the one with `Row_Num = 1`)

## 4. Fixing missing Status values

- Some rows have `Status = ''` (blank), but other rows for the same country already have a valid value, such as `Developing`
- We want to **fill in blanks** using information from other rows of the same country
- A simple `UPDATE` with a subquery doesn’t work well here, so we use a **self-join**:
  - `t1` represents the row we want to update
  - `t2` represents another row from the same country that already has a valid Status
- We join `t1` and `t2` on `Country` and then:
  - Update `t1.Status` to `'Developing'`
  - Only where:
    - `t1.Status = ''` (currently blank)
    - `t2.Status = 'Developing'` (a valid value we trust)
- This lets us fill in missing `Status` values based on other rows from the same country

## 5. General reminders

- Always **inspect** duplicates before deleting anything
- Keep the logic for finding duplicates and deleting them **in sync** (same partition key, same ordering)
- When updating from data in the same table, a **self-join** is often safer and clearer than nested subqueries
# Day 2 - Practice Log (Aggregate, Date & Math Functions)

**Topic:** GROUP BY, HAVING, Aggregate Functions, Date Functions, Math Functions

**Date:** 2026-08-12

**Practice file:** `sql/day02i.sql`

---

## Concepts practised

### 1. WHERE vs HAVING (important rule)
- `WHERE` filters **rows before** grouping.
- `HAVING` filters **groups after** grouping, and is used with aggregate functions such as `COUNT`, `SUM`, `AVG`.
- Use `WHERE Color IS NOT NULL` to remove NULL rows, **not** `HAVING Color IS NOT NULL`.

### 2. Logical order of execution
```
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
```

---

## Re-practice questions (attempt tomorrow before starting)

Try to write each query from memory first, then check the answers in the "Questions solved" section below.

1. From `SalesLT.Product`, count how many products exist for each `Color`, excluding NULL colours. Sort by count descending.
2. From `SalesLT.Product`, show `AvgPrice`, `MinPrice`, `MaxPrice` per `Color`. Exclude NULL colours and `ListPrice = 0`. Round average to 2 decimals. Sort by `AvgPrice` descending.
3. From `SalesLT.Product`, return only colours whose average `ListPrice` is greater than 1000. Sort by average descending.
4. From `SalesLT.SalesOrderHeader`, show total revenue per year (`SUM(TotalDue)`), rounded to 2 decimals. Sort by year ascending.
5. From `SalesLT.Product`, return `ProductCategoryID` values that have more than 5 products. Exclude NULL categories. Sort by count descending.
6. From `SalesLT.Product`, for each `Color` show the product count and a `VolumeLabel`: `'High Volume'` if count > 10, else `'Low Volume'`. Exclude NULL colours. Sort by count descending.
7. From `SalesLT.SalesOrderHeader`, for each year show `TotalRevenue` (`SUM(TotalDue)`, 2 decimals) and a `RevenueLabel`: `'Strong'` if revenue > 500000, else `'Weak'`. Sort by year ascending.
8. From `SalesLT.Product`, for each `Color` show `AvgPrice` (2 decimals) and a `PriceTier`: `'Premium'` if avg > 1500, `'Mid'` if 500-1500, `'Budget'` if below 500. Only keep colours with at least 3 products. Exclude NULL colours and `ListPrice = 0`. Sort by `AvgPrice` descending.

---

## Questions solved

### Q1 - Product count per Color
Count how many products exist for each colour, excluding NULL colours.
```sql
SELECT Color, COUNT(Color) AS product_count
FROM SalesLT.Product
WHERE Color IS NOT NULL
GROUP BY Color
ORDER BY product_count DESC;
```
**Status:** Correct.
**Lesson:** NULL colours must be removed with `WHERE`, not `HAVING`.

---

### Q2 - Price stats per Color
Show average, minimum and maximum ListPrice per colour, excluding NULL colours and zero prices.
```sql
SELECT Color,
       ROUND(AVG(ListPrice), 2) AS AvgPrice,
       MIN(ListPrice)           AS MinPrice,
       MAX(ListPrice)           AS MaxPrice
FROM SalesLT.Product
WHERE Color IS NOT NULL AND ListPrice > 0
GROUP BY Color
ORDER BY AvgPrice DESC;
```
**Status:** Correct after fix.
**Lesson:** Grouped queries must sort by an aggregated alias (`AvgPrice`), not by a raw column like `ListPrice`.

---

### Q3 - Colours with average price above 1000
Return colours whose average ListPrice is greater than 1000.
```sql
SELECT Color, ROUND(AVG(ListPrice), 2) AS avglist
FROM SalesLT.Product
WHERE Color IS NOT NULL
GROUP BY Color
HAVING AVG(ListPrice) > 1000
ORDER BY avglist DESC;
```
**Status:** Correct.
**Lesson:** `HAVING AVG(ListPrice) > 1000` is the right place for an aggregate filter.

---

### Q4 - Revenue per year
Total revenue per year from `SalesLT.SalesOrderHeader`.
```sql
SELECT YEAR(OrderDate)          AS order_year,
       ROUND(SUM(SubTotal), 2)  AS revenue,
       ROUND(SUM(TotalDue), 2)  AS Due_amount
FROM SalesLT.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY order_year ASC;
```
**Status:** Correct.
**Lesson:** `GROUP BY YEAR(OrderDate)` groups all rows of the same year together.

---

### Q5 - Categories with more than 5 products
Return categories that hold more than 5 products.
```sql
SELECT ProductCategoryID, COUNT(*) AS ProductCount
FROM SalesLT.Product
WHERE ProductCategoryID IS NOT NULL
GROUP BY ProductCategoryID
HAVING COUNT(*) > 5
ORDER BY ProductCount DESC;
```
**Status:** Correct.
**Lesson:** `ProductCategoryID` can be NULL for products not yet assigned to a category. Add `WHERE ProductCategoryID IS NOT NULL` to drop the NULL group from the result; without it the query still runs but may show one NULL group.

---

### Q6 - Colour volume label with CASE
For each colour show the product count and label it High/Low volume.
```sql
SELECT Color,
       COUNT(*) AS ProductCount,
       CASE
           WHEN COUNT(*) > 10 THEN 'High Volume'
           ELSE 'Low Volume'
       END AS VolumeLabel
FROM SalesLT.Product
WHERE Color IS NOT NULL
GROUP BY Color
ORDER BY ProductCount DESC;
```
**Status:** Correct after fix.
**Lesson:** An aggregate such as `COUNT(*)` can be used inside `CASE` in the SELECT list of a grouped query. Show the actual count as its own column so the label can be verified.

---

### Q7 - Revenue strength label per year
For each year show the total revenue and label it Strong/Weak.
```sql
SELECT YEAR(OrderDate)          AS OrderYear,
       ROUND(SUM(TotalDue), 2)  AS TotalRevenue,
       CASE
           WHEN SUM(TotalDue) > 500000 THEN 'Strong'
           ELSE 'Weak'
       END AS RevenueLabel
FROM SalesLT.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear ASC;
```
**Status:** Correct after fix.
**Lesson:** Label the same measure you display. If the label is based on `SUM(TotalDue)`, show `SUM(TotalDue)` in the result too - do not label on TotalDue while showing SubTotal. Use a clear alias (`OrderYear`, not `OrderDate`) and round money to 2 decimals.

---

### Q8 - Price tier per colour with HAVING
For each colour show the average price and a Premium/Mid/Budget tier, keeping only colours with at least 3 products.
```sql
SELECT Color,
       ROUND(AVG(ListPrice), 2) AS AvgPrice,
       CASE
           WHEN AVG(ListPrice) > 1500 THEN 'Premium'
           WHEN AVG(ListPrice) BETWEEN 500 AND 1500 THEN 'Mid'
           ELSE 'Budget'
       END AS PriceTier
FROM SalesLT.Product
WHERE Color IS NOT NULL AND ListPrice > 0
GROUP BY Color
HAVING COUNT(*) >= 3
ORDER BY AvgPrice DESC;
```
**Status:** Correct (10/10).
**Lesson:** Full Day 2 combination - `WHERE` (row filter) + `GROUP BY` + `HAVING COUNT(*) >= 3` (group filter) + `CASE` on an aggregate + `ROUND` + alias sort, all working together.

---

## Scorecard

| Q | Topic | Marks |
| --- | --- | --- |
| Q1 | Count per Color | 9/10 |
| Q2 | Price stats per Color | 7/10 |
| Q3 | HAVING avg > 1000 | 10/10 |
| Q4 | Revenue per year | 10/10 |
| Q5 | Categories > 5 products | 9/10 |
| Q6 | Color volume label (CASE) | 7/10 |
| Q7 | Revenue Strong/Weak | 6/10 |
| Q8 | Price tier + HAVING | 10/10 |
| **Total** | | **68/80 (85%)** |

### Focus areas for next time
- Do not forget `ROUND(x, 2)` on money and averages.
- Use clear aliases (`OrderYear`, not `OrderDate`).
- Show the same measure the label is based on.
- `WHERE` filters rows before grouping; `HAVING` filters groups after.

---

## Date functions reference

| Function | Purpose |
| --- | --- |
| `GETDATE()` | Current date and time |
| `SYSDATETIME()` | Current date and time with higher precision |
| `DATEADD(part, n, date)` | Add or subtract a period from a date |
| `DATEDIFF(part, start, end)` | Difference between two dates |
| `DATETRUNC(part, date)` | Start of a period (month, year, etc.) |
| `YEAR()`, `MONTH()`, `DAY()` | Extract a single date part |
| `EOMONTH(date, n)` | Last day of a month |
| `DATEFROMPARTS(y, m, d)` | Build a date from parts |

## Math functions reference

| Function | Purpose |
| --- | --- |
| `ROUND(value, decimals)` | Control decimal places |
| `CEILING(value)` | Round up to the next integer |
| `FLOOR(value)` | Round down to the previous integer |
| `ABS(value)` | Positive magnitude |
| `%` | Remainder (modulo), useful for even/odd checks |

---

## What to practise next

- Re-attempt all 8 questions above from memory before starting new topics.
- Focus on the weak areas: `ROUND`, clear aliases, and labelling the displayed measure.
- Move on to JOINs across Customer, Order and Product (Day 3).

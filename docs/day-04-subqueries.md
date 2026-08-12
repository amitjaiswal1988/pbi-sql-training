# Day 4 - SQL Practice Log

**Topic:** Subqueries and filtering patterns
**Date:** 2026-08-12
**Practice file:** `sql/day04.sql`

---

## Q1

### Problem Statement
The procurement team wants to identify products priced above the overall catalog average. Write a query that returns each product's ProductID, Name, and ListPrice from SalesLT.Product, but only for products where ListPrice is greater than the average ListPrice of all products. Exclude rows where ListPrice is NULL. Sort the result by ListPrice descending.

**Tables:** `SalesLT.Product`

**Expected columns (in order):** `ProductID`, `Name`, `ListPrice`

---

### 🟢 Simple English
Find the average price of all products, then show only products that are more expensive than that average.

---

### 💡 Hint
- Exclude NULL prices with `WHERE ListPrice IS NOT NULL`.
- Use a scalar subquery: `SELECT AVG(ListPrice) ...`.
- Compare using `ListPrice > (subquery)`.
- Sort by `ListPrice DESC`.

**Key rule to remember:** a scalar subquery returns one value, and each row can be compared against it.

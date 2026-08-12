/**********************************************************************
 DAY 4 - SUBQUERIES + FILTERING PATTERNS
 Database: AdventureWorksLT (SalesLT schema)
**********************************************************************/

/*
### Problem Statement
The procurement team wants to identify products priced above the overall catalog average. Write a query that returns each product's ProductID, Name, and ListPrice from SalesLT.Product, but only for products where ListPrice is greater than the average ListPrice of all products. Exclude rows where ListPrice is NULL. Sort the result by ListPrice descending.

Tables: SalesLT.Product
Expected columns (in order): ProductID, Name, ListPrice

### Simple English
Find the average price of all products, then show only products priced higher than that average.

### Hint
- Filter out NULL list prices.
- Use a scalar subquery with AVG(ListPrice).
- Compare each row's ListPrice against that single average value.
- Sort by ListPrice DESC.
*/

-- Write your Q1 answer below:



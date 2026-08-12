# Day 3 - SQL JOINs (Simple Notes)

**Topic:** Joining tables (INNER, LEFT, RIGHT, FULL)
**Date:** 2026-08-12
**Practice file:** `sql/Day03.SQL`

> How to read this file: every question follows the same 5-step pattern
> 1) The question  2) Why we do it  3) The bridge (key)  4) Business impact  5) One line to remember

---

## Core idea (keep this in mind)

- One table can never answer a full business question.
- Customer names are in one table. Order money is in another table.
- A **JOIN glues two tables together using a column they both share.**
- That shared column is the **bridge** (a key). Example: `CustomerID`.

---

## The 4 join types (simple English)

| Join | What it keeps | Simple meaning |
|------|---------------|----------------|
| `INNER JOIN` | only matching rows | "only customers who actually ordered" |
| `LEFT JOIN`  | all left + matches | "ALL customers, even those with no order" |
| `RIGHT JOIN` | all right + matches | "all orders, even if customer info missing" |
| `FULL JOIN`  | everything both sides | "show all, match where possible" |

---

## Question 1 - Orders with the customer who placed them

**1) The question**
Show each order + who bought it + how much - biggest first.

**2) Why we do it**
Customer names live in one table, order money in another. One table can't
answer both, so we join them.

**3) The bridge (key)**
`CustomerID` exists in BOTH tables. Same CustomerID = same person.
- Primary key in `SalesLT.Customer`
- Foreign key in `SalesLT.SalesOrderHeader`

**4) Business impact (real industry use)**
- Sales team sees the **biggest paying customers first** - knows who to call.
- Finance uses order totals for **revenue tracking**.
- Becomes a Power BI chart: **"Top Customers by Revenue."**

**5) One line to remember**
> JOIN = glue two tables using a column they both share.

```sql
SELECT c.FirstName,
       c.LastName,
       oh.SalesOrderID,
       oh.OrderDate,
       oh.TotalDue
FROM SalesLT.Customer AS c
INNER JOIN SalesLT.SalesOrderHeader AS oh
        ON c.CustomerID = oh.CustomerID
ORDER BY oh.TotalDue DESC;
```

**Status:** Solved correctly (10/10).

**Interview talking point (say this):**
> "I joined the Customer and SalesOrderHeader tables on CustomerID using an
> INNER JOIN, so I could show each order with the customer who placed it.
> I sorted by TotalDue descending to surface the highest-value orders first.
> In business terms this helps the sales team spot their biggest customers,
> and it is the same logic that becomes a 'Top Customers by Revenue' visual
> in Power BI."

Keywords to mention: INNER JOIN, join key (CustomerID), primary key / foreign key, ORDER BY DESC, business value.

---

## Question 2 - All products + quantity sold (even never-sold ones)

**1) The question**
List every product and how many units were sold. Products with ZERO sales
must still appear, showing 0.

**2) Why we do it**
An INNER JOIN would hide products that were never sold. The inventory team
needs to SEE the dead stock, so we must keep all products.

**3) The bridge (key)**
`ProductID` links `Product` (primary key) to `SalesOrderDetail` (foreign key).
Use `LEFT JOIN` with `Product` on the LEFT so every product is kept.

**4) Business impact (real industry use)**
- Finds **dead stock / non-moving products** - stop reordering them.
- Highlights **best sellers** at the top for restocking.
- Feeds a Power BI **"Product Performance"** report.

**5) One line to remember**
> LEFT JOIN = keep ALL rows from the left table, even with no match.

```sql
SELECT p.ProductID, p.Name,
       ISNULL(SUM(OD.OrderQty), 0) AS TotalQtySold
FROM SalesLT.Product P
LEFT JOIN SalesLT.SalesOrderDetail OD
       ON P.ProductID = OD.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalQtySold DESC;
```

**Status:** Solved correctly (10/10). Verified live: top seller "Classic Vest, S" (87);
153 products never sold - correctly kept by LEFT JOIN + ISNULL.

**Interview talking point (say this):**
> "I used a LEFT JOIN from Product to SalesOrderDetail on ProductID so that
> products with no sales still appear. I wrapped the total in ISNULL(SUM(...),0)
> so never-sold products show 0 instead of NULL. This lets the business spot
> dead stock they should stop reordering - it becomes a 'Product Performance'
> view in Power BI."

Keywords: LEFT JOIN, keep all left rows, ISNULL, dead stock, GROUP BY.

### Q2 - Advanced version (my own extension: CTE + CASE + window function)
Same LEFT JOIN, but wrapped in a CTE, then labelled each product SOLD / NOT SOLD
and showed the total unsold count on every row using a window function.
```sql
WITH ProductSaleDetails AS (
    SELECT P.ProductID, P.Name,
           COALESCE(SUM(OD.OrderQty), 0) AS TotalQtySold
    FROM SalesLT.Product P
    LEFT JOIN SalesLT.SalesOrderDetail OD
           ON P.ProductID = OD.ProductID
    GROUP BY P.ProductID, P.Name
)
SELECT P.*,
       CASE WHEN P.TotalQtySold = 0 THEN 'NOT SOLD' ELSE 'SOLD' END AS SalesStatus,
       SUM(CASE WHEN P.TotalQtySold = 0 THEN 1 ELSE 0 END) OVER() AS TotalUnsoldCount
FROM ProductSaleDetails P
ORDER BY TotalQtySold;
```
**Status:** Verified live - `TotalUnsoldCount = 153`, labels correct.
**Extra skills shown:** CTE (`WITH`), `COALESCE`, `CASE` label, window function `SUM() OVER()`.
**Interview line:** "I put the LEFT JOIN aggregation in a CTE, then used a window
function `SUM(...) OVER()` to show the total unsold count on every row without a
second query - and a CASE column to flag dead stock as NOT SOLD."

---

## Question 3 - High-value (loyal) customers, total spend > 10000

**1) The question**
For each customer show CustomerID, name, order count and total spent.
Keep only customers who spent more than 10000. Biggest first.

**2) Why we do it**
Marketing wants to target the top spenders with a loyalty offer.

**3) The bridge (key)**
`CustomerID` links Customer (PK) to SalesOrderHeader (FK). INNER JOIN because we
only want customers who actually ordered. Then GROUP BY customer + HAVING on the sum.

**4) Business impact (real industry use)**
- Builds a **loyalty / VIP list** for discounts and offers.
- Focuses marketing budget on customers who already spend the most.
- Feeds a Power BI **"Top Customers"** dashboard.

**5) One line to remember**
> WHERE filters rows; HAVING filters groups (after GROUP BY).

```sql
-- Standard answer
SELECT c.CustomerID, c.FirstName, c.LastName,
       COUNT(oh.SalesOrderID)     AS OrderCount,
       ROUND(SUM(oh.TotalDue), 2) AS TotalSpent
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader oh
        ON c.CustomerID = oh.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING SUM(oh.TotalDue) > 10000
ORDER BY TotalSpent DESC;
```

**Status:** Solved correctly (10/10). Verified live - top spender Terry Eminhizer ($119,960).

### Q3 - Bonus: TOP 10 loyal customers WITHOUT the TOP keyword
Three ways to limit to 10 rows:
```sql
-- A) ANSI standard (also does paging: page 2 = OFFSET 10)
... ORDER BY TotalSpent DESC OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-- B) ROW_NUMBER() window function in a CTE, then filter (my own solution)
WITH Loyal_customer AS (
    SELECT C.CustomerID, C.FirstName, C.LastName,
           COUNT(oh.SalesOrderID) AS OrderCount,
           ROUND(SUM(oh.TotalDue),2) AS TotalSpend,
           ROW_NUMBER() OVER (ORDER BY SUM(oh.TotalDue) DESC) AS RNK
    FROM SalesLT.Customer C
    INNER JOIN SalesLT.SalesOrderHeader oh ON c.CustomerID = oh.CustomerID
    GROUP BY C.CustomerID, C.FirstName, C.LastName
    HAVING SUM(oh.TotalDue) > 10000
)
SELECT * FROM Loyal_customer WHERE RNK <= 10;
```
**Note to self:** prefer explicit `INNER JOIN ... ON` over comma-join
(`FROM a, b WHERE a.id=b.id`). Use ROW_NUMBER when you need top-N *per group*.

**Interview line:** "TOP is SQL Server-specific. For portable code I use
OFFSET/FETCH, and for top-N per group I use ROW_NUMBER() in a CTE and filter rn <= N."

---

## Question 4 - Top 10 products by revenue (3-table JOIN)

**1) The question**
Show the top 10 products by total revenue, with product name, category name,
total quantity sold and total revenue. Only products that were actually sold.

**2) Why we do it**
Merchandising wants to know which products (and categories) make the most money.

**3) The bridge (keys) - two joins**
- Product -> SalesOrderDetail on `ProductID`  (gets the money / LineTotal)
- Product -> ProductCategory on `ProductCategoryID`  (gets the category name)
INNER JOIN both, because we only want SOLD products (no match = unsold = dropped).

**4) Business impact (real industry use)**
- Finds **top revenue drivers** - focus stock, ads and shelf space here.
- Category name shows **which category** dominates (here: Bikes).
- Feeds a Power BI **"Top Products / Category Revenue"** dashboard.

**5) One line to remember**
> Each JOIN needs its OWN ON with the correct key. "Only sold" = INNER JOIN.

```sql
SELECT P.ProductID, P.Name AS ProductName, PC.Name AS CategoryName,
       SUM(OD.OrderQty)            AS TotalQtySold,
       ROUND(SUM(OD.LineTotal), 2) AS TotalRevenue
FROM SalesLT.Product AS P
INNER JOIN SalesLT.SalesOrderDetail AS OD ON P.ProductID = OD.ProductID
INNER JOIN SalesLT.ProductCategory AS PC ON PC.ProductCategoryID = P.ProductCategoryID
GROUP BY P.ProductID, P.Name, PC.Name
ORDER BY TotalRevenue DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;   -- or ROW_NUMBER() in a CTE, filter RNK <= 10
```

**Status:** Solved correctly (10/10). Verified live - #1 Touring-1000 Blue, 60 ($37,191),
top 10 dominated by Bikes (Touring / Mountain / Road).

**Why INNER not LEFT (learner asked):** the task says "only products that have
actually been sold". INNER JOIN drops products with no sales row automatically.
LEFT JOIN would keep unsold products and you'd have to filter them out again.
Rule: "only matching / only sold" = INNER; "keep everything, even non-matches" = LEFT.

**Interview line:** "I chained two INNER JOINs - Product to SalesOrderDetail for the
money and Product to ProductCategory for the label - grouped per product, and used
OFFSET/FETCH (or ROW_NUMBER) to return the top 10 by revenue."

---

## Question 5 - Customers who placed orders in 2008

**1) The question**
Show customers who placed at least one order in 2008, with order count and
total spend in 2008, sorted by total spend descending.

**2) Why we do it**
Sales teams often review one year at a time for campaign and performance analysis.

**3) The bridge (key)**
`CustomerID` links Customer to SalesOrderHeader. Use INNER JOIN for matching
customers/orders, then filter rows to year 2008 in WHERE before grouping.

**4) Business impact (real industry use)**
- Builds a year-specific customer performance list.
- Helps target offers for active customers in that year.
- Feeds yearly KPI visuals in Power BI.

**5) One line to remember**
> Date filter goes in WHERE before GROUP BY; HAVING is for aggregate filters.

```sql
SELECT
       C.CustomerID,
       C.FirstName,
       C.LastName,
       COUNT(OH.SalesOrderID) AS OrderCount2008,
       ROUND(SUM(OH.TotalDue), 2) AS TotalSpent2008
FROM SalesLT.Customer AS C
INNER JOIN SalesLT.SalesOrderHeader AS OH
       ON C.CustomerID = OH.CustomerID
WHERE YEAR(OH.OrderDate) = 2008
GROUP BY
       C.CustomerID,
       C.FirstName,
       C.LastName
ORDER BY
       TotalSpent2008 DESC;
```

**Status:** Solved correctly (10/10). Verified live.

**Interview line:** "I joined Customer with SalesOrderHeader, filtered orders
to 2008 in WHERE, then grouped by customer to calculate order count and total
spend for that year."

---

Day 3 completed: Q1-Q5 all solved and validated.

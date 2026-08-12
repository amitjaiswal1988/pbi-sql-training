/**********************************************************************
 DAY 3 - SQL JOINS
 Topic: Combining data from multiple tables
 Database: AdventureWorksLT (SalesLT schema)

 Why JOINs matter:
 - Real reports never come from a single table.
 - Customers live in one table, their orders in another,
   and the products they bought in a third.
 - A JOIN links these tables using a matching key column
   (usually a primary key on one side, a foreign key on the other).

 Join types covered today:
   INNER JOIN  -> only rows that match in BOTH tables
   LEFT  JOIN  -> all rows from LEFT table + matches from right (NULL if none)
   RIGHT JOIN  -> all rows from RIGHT table + matches from left (NULL if none)
   FULL  JOIN  -> all rows from both, matched where possible
**********************************************************************/


/*====================================================================
  SECTION 1 - The key relationships (know these before joining)
====================================================================*/
-- Customer        (CustomerID)            <- primary key
-- SalesOrderHeader(SalesOrderID, CustomerID)  CustomerID = foreign key
-- SalesOrderDetail(SalesOrderID, ProductID)   both are foreign keys
-- Product         (ProductID)             <- primary key
--
-- Chain: Customer -> SalesOrderHeader -> SalesOrderDetail -> Product


/*====================================================================
  SECTION 2 - INNER JOIN (matches only)
====================================================================*/

-- 2.1  Every order together with the customer who placed it.
SELECT c.CustomerID,
       c.FirstName,
       c.LastName,
       oh.SalesOrderID,
       oh.OrderDate,
       oh.TotalDue
FROM SalesLT.Customer AS c
INNER JOIN SalesLT.SalesOrderHeader AS oh
        ON c.CustomerID = oh.CustomerID
ORDER BY oh.TotalDue DESC;

-- 2.2  Which products appear on which orders (order line detail).
SELECT oh.SalesOrderID,
       p.Name AS ProductName,
       od.OrderQty,
       od.UnitPrice,
       od.LineTotal
FROM SalesLT.SalesOrderHeader AS oh
INNER JOIN SalesLT.SalesOrderDetail AS od
        ON oh.SalesOrderID = od.SalesOrderID
INNER JOIN SalesLT.Product AS p
        ON od.ProductID = p.ProductID
ORDER BY oh.SalesOrderID, od.LineTotal DESC;


/*====================================================================
  SECTION 3 - LEFT JOIN (keep everything on the left)
====================================================================*/

-- 3.1  ALL customers, even those who never placed an order.
--      Customers with no order will show NULL in the order columns.
SELECT c.CustomerID,
       c.FirstName,
       c.LastName,
       oh.SalesOrderID,
       oh.TotalDue
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS oh
       ON c.CustomerID = oh.CustomerID
ORDER BY oh.TotalDue DESC;

-- 3.2  Find customers who have NEVER ordered (order key is NULL).
SELECT c.CustomerID,
       c.FirstName,
       c.LastName
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS oh
       ON c.CustomerID = oh.CustomerID
WHERE oh.SalesOrderID IS NULL;


/*====================================================================
  SECTION 4 - JOIN + GROUP BY (Day 2 skills applied to joined data)
====================================================================*/

-- 4.1  Total amount spent by each customer (only customers who ordered).
SELECT c.CustomerID,
       c.FirstName,
       c.LastName,
       COUNT(oh.SalesOrderID)        AS OrderCount,
       ROUND(SUM(oh.TotalDue), 2)    AS TotalSpent
FROM SalesLT.Customer AS c
INNER JOIN SalesLT.SalesOrderHeader AS oh
        ON c.CustomerID = oh.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

-- 4.2  Best-selling products by total quantity sold.
SELECT p.ProductID,
       p.Name AS ProductName,
       SUM(od.OrderQty)             AS TotalQtySold,
       ROUND(SUM(od.LineTotal), 2)  AS TotalRevenue
FROM SalesLT.Product AS p
INNER JOIN SalesLT.SalesOrderDetail AS od
        ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalQtySold DESC;


/*====================================================================
  SECTION 5 - Practice questions (write these from memory)
  Attempt each one below, then check against the logic above.
====================================================================*/

-- Q1. List every order with the customer's CompanyName and TotalDue,
--     largest TotalDue first. (INNER JOIN Customer + SalesOrderHeader)


-- Q2. Show all products and the total quantity sold for each.
--     Include products that were never sold (quantity should show as 0 or NULL).
--     (LEFT JOIN Product -> SalesOrderDetail)


-- Q3. For each customer, show OrderCount and TotalSpent,
--     but only customers whose TotalSpent is greater than 10000.
--     (INNER JOIN + GROUP BY + HAVING)


-- Q4. Show the top 10 products by total revenue, with product name
--     and category-friendly output. (Product + SalesOrderDetail)


-- Q5. Find customers who placed an order in 2008 only.
--     (JOIN + WHERE YEAR(OrderDate) = 2008)

---each order + the customer's FirstName, LastName, plus SalesOrderID, 
--OrderDate, TotalDue — biggest TotalDue first.

SELECT 
c.FirstName As F_Name,
c.LastName As l_name,
oh.SalesOrderID,
oh.OrderDate,
oh.TotalDue
FROM SalesLT.Customer c
inner join SalesLT.SalesOrderHeader OH 
ON
c.CustomerID = OH.CustomerID
ORDER BY OH.TotalDue DESC
-----
Select p.ProductID,p.Name, 
ISNULL(sum(OD.OrderQty),0) as TotalQtySold
from SalesLT.Product P LEFT JOIN
SalesLT.SalesOrderDetail OD
ON
P.ProductID = OD.ProductID
Group by p.ProductID,p.Name
ORDER BY TotalQtySold DESC
--------------
'''Problem Statement
The inventory team wants to know which products are selling and which are not moving at all. 
Write a query that lists every product in SalesLT.Product along with the total quantity sold for each. 
Products that have never been sold must still appear in the result, showing a total quantity of 0 (or NULL). 
Return the columns ProductID, ProductName, and TotalQtySold, sorted by TotalQtySold descending.

Tables: SalesLT.Product, SalesLT.SalesOrderDetail

Expected columns (in order): ProductID, ProductName, TotalQtySold'''

WITH ProductSaleDetails AS(
Select P.ProductID,P.Name,
Coalesce(Sum(OD.OrderQty),0) AS TotalQtySold
 from  SalesLT.Product P
LEFT JOIN SalesLT.SalesOrderDetail OD
ON
P.ProductID = OD.ProductID
Group by P.ProductID,P.Name) SELECT P.*,
CASE 
When p.TotalQtySold = 0 then 'NOT SOLD' ELSE 'SOLD'
END as SalesStatus,
Sum(CASE when P.TotalQtySold = 0 then 1 ELSE 0
END ) OVER() AS TotalUnsoldCount
from Productsaledetails P
ORDER BY TotalQtySold

----------------------------------------------
'''Problem Statement
The finance team wants a list of high-value customers for a loyalty program. 
Write a query that shows, for each customer, their CustomerID, FirstName, LastName, 
the number of orders they placed (OrderCount), and their total amount spent (TotalSpent, 
rounded to 2 decimals). Only include customers whose total spending is greater than 10000. 
Sort the result by TotalSpent descending.

Tables: SalesLT.Customer, SalesLT.SalesOrderHeader

Expected columns (in order): CustomerID, FirstName, LastName, OrderCount, TotalSpent'''


With Loyal_customer as(
Select 
C.CustomerID,
C.FirstName,
C.LastName,
count(oh.SalesOrderID) as OrderCount,
Round(sum(oh.TotalDue),2) as TotalSpend,
ROW_NUMBER() OVER(Order by Round(sum(oh.TotalDue),2) DESC) as RNK
from SalesLT.Customer C,
SalesLT.SalesOrderHeader oh
WHERE c.CustomerID = OH.CustomerID
Group by C.CustomerID,C.FirstName,C.LastName
Having Round(sum(oh.TotalDue),2) > 10000) select * from Loyal_customer
where rnk<=10
-------------------------------------------------------------------------------------------------
Select P.ProductID,
P.Name as ProductName,
PC.Name as productcategoryName,
SUM(OD.LineTotal) As TotalRevenue,
SUM(OD.OrderQty) as TotalSoldQty
 FROM
SalesLT.Product P INNER JOIN
 SalesLT.SalesOrderDetail OD  
 ON P.ProductID =OD.ProductID
 INNER JOIN  SalesLT.ProductCategory PC 
 ON PC.ProductCategoryID = P.ProductCategoryID
 Group By P.ProductID,P.Name,Pc.Name
 ORDER BY TotalRevenue DESC
 OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY
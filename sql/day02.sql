

--Display top 5 product from tables--
Select Top 5 * from salesLT.product
---Display the Name, ListPrice, and Color of all products, with the most expensive products first.

Select Name,ListPrice,Color from salesLT.product
order by ListPrice DESC
--Find the total number of products that have the color Red and black

Select --Total Numbers means count function -- 
count(*) as TotalNUmberProductRed
FROM salesLT.product
Where color ='Red'
--Find products with a ListPrice greater than 1000. Display the Name and ListPrice, starting with the cheapest product.--
Select 
Name,ListPrice
FROM salesLT.product
Where ListPrice >1000
order by ListPrice
--Find customers whose LastName starts with the letter B.
Select * from salesLT.customer
Where LastName like '%B'
--Display all distinct colors available in the SalesLT.Product table.
Select Distinct color from saleslt.Product;
Select count(Distinct color ) from saleslt.Product
--Find products that were introduced after July 1, 2002 using the SellStartDate column.

Select name,SellStartDate from  salesLT.Product
where SellStartDate > '2002-07-01'

SELECT Name, SellStartDate
FROM SalesLT.Product
WHERE SellStartDate > '2002-07-01';

--Find the 10 heaviest products that have a valid Weight value. Display the heaviest products first.
--Vlaid weighht means we dont need null , meansfind the heaviest product with value .
Select top 10 ProductID,Name,Color,ListPrice,Weight from salesLT.product
where weight is NOT NULL
order by weight DESC
---From SalesLT.SalesOrderHeader, display SalesOrderID, OrderDate, and TotalDue, with the largest TotalDue first.
Select SalesOrderID, OrderDate,DueDate,TotalDue from SalesLT.SalesOrderHeader
order BY TotalDue DESC

SELECT name AS SchemaName
FROM sys.schemas
ORDER BY name;

SELECT 
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id = t.schema_id
ORDER BY s.name, t.name;

--what are the Schema

SELECT Name AS SCHEMANAME
from sys.schemas
order by name;
--Schema is logical folder , to help the organize tables,
--it is not store the data directly. Store the data in table in row and colum formate
--Bussiness impact -- better organixation 2.Security Control
--User Friendly Easy navigation
--what table exist in Each Schema--
Select 
    s.name As Schem_name,
    t.name as TableName
    From sys.schemas s join 
    sys.tables t ON
    s.schema_id = t.schema_iD
    order by s.name,t.name DESC



SELECT
    c.ORDINAL_POSITION,
    c.COLUMN_NAME,
    c.DATA_TYPE,
    c.CHARACTER_MAXIMUM_LENGTH,
    c.IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = 'SalesLT'
  AND c.TABLE_NAME = 'Product'
ORDER BY c.ORDINAL_POSITION;

SELECT
    KU.TABLE_SCHEMA,
    KU.TABLE_NAME,
    KU.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
  ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
 AND TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
ORDER BY KU.TABLE_SCHEMA, KU.TABLE_NAME;

SELECT
    KU.TABLE_SCHEMA,
    KU.TABLE_NAME,
    KU.COLUMN_NAME,
    KU.ORDINAL_POSITION
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
  ON TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
 AND TC.TABLE_SCHEMA = KU.TABLE_SCHEMA
 AND TC.TABLE_NAME = KU.TABLE_NAME
WHERE TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
  AND KU.TABLE_SCHEMA = 'SalesLT'
  AND KU.TABLE_NAME IN ('Customer','Product','SalesOrderHeader','SalesOrderDetail')
ORDER BY KU.TABLE_NAME, KU.ORDINAL_POSITION;

SELECT COUNT(*) AS TotalRows FROM SalesLT.Customer;
SELECT COUNT(*) AS TotalRows FROM SalesLT.Product;
SELECT COUNT(*) AS TotalRows FROM SalesLT.SalesOrderHeader;
SELECT COUNT(*) AS TotalRows FROM SalesLT.SalesOrderDetail;


SELECT
COUNT(*) AS TotalRows,
COUNT(Weight) AS NonNullWeight,
COUNT(*) - COUNT(Weight) AS NullWeight
FROM SalesLT.Product;

---Question 6: Data volume + data quality check
--Part A: Row count (volume check)
Select 'customer' As TableName, count(*) as TotalRows from SalesLT.Customer
UNION ALL
Select  'Product' AS TableName , count(*) As TotalRows from SalesLT.Product
UNION ALL
Select 'salesOrderHeader' as TableName,count(*) as TotalRows FROM SalesLT.SalesOrderHeader
UNION ALL
Select 'SalesOrderDetails' AS TableName, count(*) As TotalRows from SalesLT.SalesOrderDetail;
---Part B: Null check for important fields (quality check)
SELECT
    COUNT(*) AS TotalRows,
    COUNT(Weight) AS NonNullWeight,
    COUNT(*) - COUNT(Weight) AS NullWeight
FROM SalesLT.Product;

--Part C: Multi-column null health check (recommended)
SELECT
  COUNT(*) AS TotalRows,
  SUM(CASE WHEN Name IS NULL THEN 1 ELSE 0 END) AS NullName,
  SUM(CASE WHEN ListPrice IS NULL THEN 1 ELSE 0 END) AS NullListPrice,
  SUM(CASE WHEN Color IS NULL THEN 1 ELSE 0 END) AS NullColor,
  SUM(CASE WHEN Weight IS NULL THEN 1 ELSE 0 END) AS NullWeight
FROM SalesLT.Product;

'''FROM → SQL identifies the table and gets the data.
WHERE → SQL filters the rows.
GROUP BY → SQL groups the filtered rows.
HAVING → SQL filters the groups, usually based on aggregate functions.
SELECT → SQL selects the columns and creates the column aliases.
ORDER BY → SQL sorts the final result.'''
---F W G H S O T

---From → Where → Group → Having → Select → Order → Top

'''A column alias cannot normally be used in the WHERE clause because WHERE is logically 
processed before SELECT, where the alias is created. The alias can be used 
in ORDER BY because ORDER BY is processed after SELECT, so the alias is already available."'''

--Cast(Expression as data type)

Select CAST('2020-06-01' as date)-- If we want to change data type then can use cast and we 
--If data type not match according to expression in cast then will get error
Select('ABC' AS INT)
--Error-Below
'''4:34:43 PM
Started executing query at  Line 167
Msg 156, Level 15, State 1, Line 167
Incorrect syntax near the keyword 'AS'.
4:34:43 PM
Total execution time: 00:00:00.017'''
Select try_CAST('2020-06-01' as Int)
--But in Try_cast Even expression will not match ,instead error will get output NULL

Select cast('customerID' as INT ) from salesLT.Customer
'''Msg 245, Level 16, State 1, Line 178
Conversion failed when converting the varchar value 'customerID' to data type int.'''
Select try_CAST('customerID' as int ) from salesLT.Customer


SELECT FirstName, COUNT(*) AS DuplicateCount
FROM SalesLT.Customer
GROUP BY FirstName
HAVING COUNT(*) > 1;

---Write a query to return CustomerID, FirstName, LastName, and EmailAddress for customers whose
-- LastName starts with B and whose EmailAddress is not NULL.
--- Sort the result by LastName (A to Z), then FirstName (A to Z)
Select  CustomerID,
        FirstName,
        LastName,
        CompanyName
from SalesLT.Customer
where LastName like 'B%'
and CompanyName is NOT NULL
order by LastName Asc,FirstName ASC
'''---Question 2 — Easy+

Table:
SalesLT.Product

Relevant columns:
ProductID, Name, Color, ListPrice, Weight

Interview task:
Write a query to return ProductID, Name, Color, and ListPrice for products where:

Color is either Red, Black, or Silver
ListPrice is between 500 and 2000 (inclusive)
Weight is not NULL
Sort by ListPrice descending, then Name ascending.'''
SELECT ProductID, Name, Color, ListPrice, Weight
FROM SalesLT.Product
WHERE Color IN ('Red', 'Black', 'Silver')
AND ListPrice BETWEEN 500 AND 2000
AND Weight IS NOT NULL
ORDER BY ListPrice DESC, Name ASC;
 --Write a SQL query on SalesLT.Product to return ProductID, Name, Color, ListPrice, 
 --and a CASE-based PriceBand: below 500 = Budget, 500–1000 = Standard, above 1000 = Premium.

 Select ProductID, Name, Color, ListPrice,
 CASE 
 When ListPrice < 500 then 'Low_bdget'
 When listPrice between 500 and 1000 then 'Standard'
 When ListPrice >1000 then 'Premium'
 END as PriceBand
  from SalesLT.Product;
  5--number 
SELECT ProductID, Name, Color, ListPrice
FROM SalesLT.Product
WHERE Color IN ('Red', 'Black', 'Silver')
AND ListPrice >1000
  ----6 number Table: SalesLT.Customer  Columns: FirstName, LastName
----Return customers whose FirstName contains the text ann (case-insensitive).
Select FirstName, LastName from SalesLT.Customer
where FirstName like '%ann%'

--7==Table: SalesLT.Customer
---olumns: LastName
---Return customers where LastName does NOT start with B.

Select FirstName, LastName from SalesLT.Customer
where LastName not LIKE '%B';
---
Select Name,color FROM SalesLT.Product
where color is not null and 
color <> 'Red';

Select Name,
COALESCE(color,'Uncolored') as colored_Display
from SalesLT.Product
----
SELECT Name,
       COALESCE(Color, 'Uncolored') AS Color_Display
FROM SalesLT.Product
WHERE Color IS NULL;
--Question:12
-- Write a SQL query to return ProductID and NULLIF(Size, '') as CleanSize from SalesLT.Product.
Select ProductID,
Nullif(Size,'') as CleanSize from SalesLT.Product
-----
'''Table: SalesLT.Customer
Relevant columns: CustomerID, FirstName, LastName, CompanyName

Business requirement:
Management wants a customer name-quality report.
 Return CustomerID, FirstName, LastName, and a new column 
 FullNameLength that shows the length of the full name after
  removing leading/trailing spaces from both FirstName and LastName, 
  and combining them with a single space between them. 
  Show only rows where CompanyName is not NULL. Sort by 
  FullNameLength descending, then CustomerID ascending.
'''
SELECT CustomerID, FirstName, LastName,
       LEN(CONCAT_WS(' ', TRIM(FirstName), TRIM(LastName))) AS FullNameLength
FROM SalesLT.Customer
WHERE CompanyName IS NOT NULL
ORDER BY FullNameLength DESC, CustomerID ASC;
---
SELECT
    CustomerID,
    CompanyName,
    CONCAT_WS(
        '-',
        UPPER(TRIM(FirstName)),
        LOWER(LEFT(TRIM(LastName), 3))
    ) AS CustomerLabel
FROM SalesLT.Customer
WHERE CompanyName IS NOT NULL
ORDER BY CustomerLabel ASC;


Select 
     CustomerID,
     CompanyName,
     CONCAT_WS(
        '-',UPPER(TRIM(FirstName)),
        LOWER(LEFT(TRIM(LastName),3))
     ) customer_lebal
FROM SalesLT.Customer
where CompanyName is NOT NULL
ORDER BY customer_lebal ASC
---
SELECT ProductID, Name, ListPrice, Weight,
CASE 
When Weight is null then ListPrice
else ListPrice +(ListPrice*(2.5/100))
END AS AdjustedPrice,
ROUND(CASE 
When Weight is null then ListPrice
else ListPrice +(ListPrice*(2.5/100))
END,2) AS RoundedAdjustedPrice 
 FROM
SalesLT.Product
where ListPrice > 0
order by  RoundedAdjustedPrice DESC

-- =============================================
-- Section 2.2 - Aggregate Functions + GROUP BY
-- =============================================

-- Q1: Find the total number of products per Color.
-- Show Color and ProductCount. Exclude NULL colors. Sort by ProductCount DESC.
SELECT Color, COUNT(*) AS ProductCount
FROM SalesLT.Product
WHERE Color IS NOT NULL
GROUP BY Color
ORDER BY ProductCount DESC;

-- Q2: Find the average, minimum, and maximum ListPrice per Color.
-- Exclude NULL colors and products with ListPrice = 0.
SELECT Color,
       ROUND(AVG(ListPrice), 2) AS AvgPrice,
       MIN(ListPrice)           AS MinPrice,
       MAX(ListPrice)           AS MaxPrice
FROM SalesLT.Product
WHERE Color IS NOT NULL AND ListPrice > 0
GROUP BY Color
ORDER BY AvgPrice DESC;

-- Q3: Find colors where the average ListPrice is greater than 1000.
-- Show Color and AvgPrice. Sort by AvgPrice DESC.
-- HAVING filters after GROUP BY, WHERE filters before GROUP BY
SELECT Color,
       ROUND(AVG(ListPrice), 2) AS AvgPrice
FROM SalesLT.Product
WHERE Color IS NOT NULL
GROUP BY Color
HAVING AVG(ListPrice) > 1000
ORDER BY AvgPrice DESC;

-- Q4: Find the total revenue (SUM of TotalDue) per year from SalesOrderHeader.
-- Use YEAR(OrderDate) to extract year. Sort by OrderYear ASC.
SELECT YEAR(OrderDate)        AS OrderYear,
       ROUND(SUM(TotalDue), 2) AS TotalRevenue
FROM SalesLT.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear ASC;

-- Q5: Find product categories with more than 5 products.
-- Table: SalesLT.Product | Column: ProductCategoryID
-- Show ProductCategoryID and ProductCount.
SELECT ProductCategoryID, COUNT(*) AS ProductCount
FROM SalesLT.Product
WHERE ProductCategoryID IS NOT NULL
GROUP BY ProductCategoryID
HAVING COUNT(*) > 5
ORDER BY ProductCount DESC;

-- =============================================
-- Section 2.3 - Date Functions
-- =============================================

-- Q6: Display SalesOrderID, OrderDate, and the year + month of OrderDate.
-- YEAR() and MONTH() extract parts from a date.
SELECT SalesOrderID,
       OrderDate,
       YEAR(OrderDate)  AS OrderYear,
       MONTH(OrderDate) AS OrderMonth
FROM SalesLT.SalesOrderHeader
ORDER BY OrderDate DESC;

-- Q7: Find how many days have passed since each order was placed.
-- DATEDIFF(day, start_date, end_date) gives difference in days.
SELECT SalesOrderID,
       OrderDate,
       DATEDIFF(DAY, OrderDate, GETDATE()) AS DaysSinceOrder
FROM SalesLT.SalesOrderHeader
ORDER BY DaysSinceOrder ASC;

-- Q8: Find products whose SellStartDate is in the year 2002.
-- Use YEAR() function to filter by year.
SELECT ProductID, Name, SellStartDate
FROM SalesLT.Product
WHERE YEAR(SellStartDate) = 2002
ORDER BY SellStartDate ASC;

-- Q9: Show OrderDate formatted as DD-MM-YYYY string using FORMAT().
-- FORMAT(date, 'dd-MM-yyyy') returns a formatted string.
SELECT SalesOrderID,
       OrderDate,
       FORMAT(OrderDate, 'dd-MM-yyyy') AS FormattedDate
FROM SalesLT.SalesOrderHeader
ORDER BY OrderDate DESC;

-- =============================================
-- Section 2.4 - Combining GROUP BY + CASE + Filters
-- =============================================

-- Q10: For each Color, show total products and label it as
-- 'High Volume' if count > 10, else 'Low Volume'.
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

-- Q11: Find the total TotalDue per year, and label each year as
-- 'Strong' if revenue > 500000, else 'Weak'.
SELECT YEAR(OrderDate)                            AS OrderYear,
       ROUND(SUM(TotalDue), 2)                    AS TotalRevenue,
       CASE
           WHEN SUM(TotalDue) > 500000 THEN 'Strong'
           ELSE 'Weak'
       END                                         AS RevenueLabel
FROM SalesLT.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear ASC;

-- Q12: Show each Color, its average ListPrice rounded to 2 decimals,
-- and a PriceTier: 'Premium' if avg > 1500, 'Mid' if 500-1500, 'Budget' below 500.
-- Only include colors with at least 3 products.
SELECT Color,
       ROUND(AVG(ListPrice), 2) AS AvgPrice,
       CASE
           WHEN AVG(ListPrice) > 1500 THEN 'Premium'
           WHEN AVG(ListPrice) >= 500  THEN 'Mid'
           ELSE 'Budget'
       END AS PriceTier
FROM SalesLT.Product
WHERE Color IS NOT NULL AND ListPrice > 0
GROUP BY Color
HAVING COUNT(*) >= 3
ORDER BY AvgPrice DESC;
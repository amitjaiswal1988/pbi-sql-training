-- 1. Quickly inspect a few product records before deeper analysis.
SELECT TOP (5) *
FROM SalesLT.Product;


-- 2. Show product name, price and color, with the most expensive products first.
SELECT Name, ListPrice, Color
FROM SalesLT.Product
ORDER BY ListPrice DESC;


-- 3. Compare the number of products available in Red and Black colors.
SELECT COUNT(*) AS RedProductCount
FROM SalesLT.Product
WHERE Color = 'Red'; -- Red products: 38


SELECT COUNT(*) AS BlackProductCount
FROM SalesLT.Product
WHERE Color = 'Black'; -- Black products: 89


-- 4. Find products with a ListPrice greater than 1000, starting with the cheapest.
SELECT Name, ListPrice
FROM SalesLT.Product
WHERE ListPrice > 1000 -- WHERE filters the rows based on the specified condition.
ORDER BY ListPrice ASC; -- ASC sorts the results from the lowest price to the highest price.
--5.	Customers whose LastName starts with 'B'.

Select * from salesLT.Customer
where LastName  like '%B';

-- 6. Show each product color only once.
SELECT DISTINCT Color
FROM SalesLT.Product;
-- 7. Find products that were introduced after July 1, 2002.
SELECT Name, SellStartDate
FROM SalesLT.Product
WHERE SellStartDate > '2002-07-01';
-- 8. Find the 10 heaviest products that have a valid Weight value.
SELECT TOP 10 *
FROM SalesLT.Product
where Weight is NOT NULL
order by weight DESC;
-- 9. Show order details with the highest order totals first.
SELECT SalesOrderID,
       OrderDate,
       TotalDue
FROM SalesLT.SalesOrderHeader
ORDER BY TotalDue DESC;

---10.	Count of rows in each table you've touched (SELECT COUNT(*) FROM … per table).

-- Count the total number of rows in the Product table.
SELECT COUNT(*) AS ProductRowCount
FROM SalesLT.Product;

-- Count the total number of rows in the Customer table.
SELECT COUNT(*) AS CustomerRowCount
FROM SalesLT.Customer;

-- Count the total number of rows in the SalesOrderHeader table.
SELECT COUNT(*) AS SalesOrderHeaderRowCount
FROM SalesLT.SalesOrderHeader;
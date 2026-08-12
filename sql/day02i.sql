Select color,Count(color) as product_count from salesLT.Product
WHERE Color IS NOT NULL 
Group by Color
order by product_count DESC

------------------------------
SELECT Color,
       ROUND(AVG(ListPrice), 2) AS AvgPrice,
       MIN(ListPrice)           AS MinPrice,
       MAX(ListPrice)           AS MaxPrice
FROM SalesLT.Product
WHERE Color IS NOT NULL AND ListPrice > 0
GROUP BY Color
ORDER BY AvgPrice DESC;

-----
SELECT color, ROUND(avg(listPrice),2) as avglist FROM salesLT.Product
where color is not null 
group by color
having avg(listPrice) >1000
ORDER BY avglist DESC
-------------
-- ============================================
--- ============================================
-- DATE FUNCTIONS - SQL SERVER PRACTICE
-- ============================================

-- 1. GETDATE() → Current date and time
SELECT GETDATE();

-- 2. SYSDATETIME() → Current date and time with higher precision
SELECT SYSDATETIME();

-- 3. DATEADD() → Add 3 months
SELECT DATEADD(MONTH, 3, GETDATE());

-- 4. DATEADD() → Subtract 3 months
SELECT DATEADD(MONTH, -3, GETDATE());

-- 5. DATEADD() → Add 3 years
SELECT DATEADD(YEAR, 3, GETDATE());

-- 6. DATEADD() → Subtract 2 years
SELECT DATEADD(YEAR, -2, GETDATE());

-- 7. DATEADD() → Subtract 2 days
SELECT DATEADD(DAY, -2, GETDATE());

-- 8. DATEDIFF() → Difference in years
SELECT DATEDIFF(YEAR, '2020-08-01', '2026-08-01');

-- 9. DATEDIFF() → Difference in days
SELECT DATEDIFF(DAY, '2026-01-01', '2026-08-12');

-- 10. DATEDIFF() → Difference in days
SELECT DATEDIFF(DAY, '2026-08-12', '2026-12-31');

-- 11. DATETRUNC() → Start of current month
SELECT DATETRUNC(MONTH, SYSDATETIME());

-- 12. DATETRUNC() → Start of year
SELECT DATETRUNC(YEAR, '2026-08-12');

-- 13. YEAR() → Extract year
SELECT YEAR('2026-08-12');

-- 14. MONTH() → Extract month
SELECT MONTH('2026-08-12');

-- 15. DAY() → Extract day
SELECT DAY('2026-08-12');

-- 16. EOMONTH() → Last day of current month
SELECT EOMONTH(GETDATE());

-- 17. EOMONTH() → Last day of previous month
SELECT EOMONTH(GETDATE(), -1);

-- 18. EOMONTH() → Last day of next month
SELECT EOMONTH(GETDATE(), 1);

-- 19. DATEFROMPARTS() → Create date from Year, Month, Day
SELECT DATEFROMPARTS(2026, 8, 12);


-- ============================================
-- MATH FUNCTIONS - SQL SERVER PRACTICE
-- ============================================

-- 20. ROUND() → Round to 2 decimal places
SELECT ROUND(123.4567, 2);

-- 21. ROUND() → Calculate 90% of ListPrice and round to 2 decimals
SELECT ROUND(ListPrice * 0.9, 2)
FROM SalesLT.Product;

-- 22. CEILING() → Round UP to the next integer
SELECT CEILING(10.2);

-- 23. FLOOR() → Round DOWN to the previous integer
SELECT FLOOR(10.9);

-- 24. ABS() → Convert negative value to positive magnitude
SELECT ABS(-100);

-- 25. % → Return the remainder
SELECT 10 % 3;

-- 26. % → Check even numbers
SELECT CustomerID
FROM SalesLT.Customer
WHERE CustomerID % 2 = 0;

-- 27. % → Check odd numbers
SELECT CustomerID
FROM SalesLT.Customer
WHERE CustomerID % 2 = 1;
----------------------
'''DATE
GETDATE        → Current date/time
SYSDATETIME    → Current date/time + precision
DATEADD        → Add / subtract date
DATEDIFF       → Difference between dates
DATETRUNC      → Start of period
YEAR           → Year
MONTH          → Month
DAY            → Day
EOMONTH        → End of month
DATEFROMPARTS  → Create date


MATH
ROUND          → Decimal control
CEILING        → Up
FLOOR          → Down
ABS            → Positive magnitude
%              → Remainder'''

-------------
Select YEAR(OrderDate) as order_year  ,round(sum(SubTotal),2) as revenue,  
round(sum(TotalDue),2) as Due_amount
from SalesLT.SalesOrderHeader
group by YEAR(OrderDate) 
order by order_year ASC
--------
SELECT ProductCategoryID, count(*) as ProductCount from salesLT.Product
where ProductCategoryID is NOT NULL
Group by ProductCategoryID
having count(*) >5
order by ProductCount DESC
--------------------------------------

Select color ,count(*) as product_Color_count from saleslt.Product
where color is not NULL
group by Color
ORDER BY product_Color_count;

Select color ,count(*) as product_count,
CASE 
when count(*)>10 then 'High Volume' else 'Low volume'
END as product_Color_count from salesLT.Product
where color is not NULL
group by Color
ORDER BY product_Color_count DESC;
------------------------------------------------------
SELECT YEAR(OrderDate)          AS OrderYear,
       ROUND(SUM(TotalDue), 2)  AS TotalRevenue,
       CASE 
           WHEN SUM(TotalDue) > 500000 THEN 'Strong'
           ELSE 'Weak' 
       END AS RevenueLabel
FROM SalesLT.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear ASC;

------------------------------------
SELECT
    Color,
    ROUND(AVG(ListPrice), 2) AS AvgPrice,
    CASE
        WHEN AVG(ListPrice) > 1500 THEN 'Premium'
        WHEN AVG(ListPrice) BETWEEN 500 AND 1500 THEN 'Mid'
        ELSE 'Budget'
    END AS PriceTier
FROM SalesLT.Product
WHERE Color IS NOT NULL
  AND ListPrice > 0
GROUP BY Color
HAVING COUNT(*) >= 3
ORDER BY AvgPrice DESC;




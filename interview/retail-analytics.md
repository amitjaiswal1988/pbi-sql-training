# Retail Analytics

## 1. What is this project?
An end-to-end **retail sales analytics** BI solution built on the AdventureWorksLT
dataset. It analyzes sales, customers, and products to support business decisions.

## 2. Business Problem it Solves
- The business needed to know **what sells, who buys, and when**.
- Poor visibility into top products, top customers, and sales trends.
- Hard to plan inventory and target marketing.

## 3. What I Built (data flow)
```
SQL Server DB → Power Query (clean) → Star Schema Model (TMDL) → DAX measures → Report → Power BI Service
```

## 4. Data Modeling
- **Star schema**: fact table (Sales / order lines) + dimensions
  (Customer, Product, Date).
- Dedicated **Date table** for time intelligence.
- Model written as **TMDL** (model as code), version-controlled in Git.

## 5. Key DAX Measures
```DAX
Total Sales     = SUM( Sales[LineTotal] )
Total Orders    = DISTINCTCOUNT( Sales[SalesOrderID] )
Total Customers = DISTINCTCOUNT( Sales[CustomerID] )
Avg Order Value = DIVIDE( [Total Sales], [Total Orders] )
Sales YTD       = TOTALYTD( [Total Sales], 'Date'[Date] )
```

## 6. Power Query
- Cleaned product and customer data, fixed types, filtered early.
- Kept **query folding** so transformations run as SQL → fast refresh.

## 7. Reports (Sales / Operational Analytics)
- Sales **KPIs**: Total Sales, Orders, Avg Order Value, Customers.
- **Top 10 Products** bar chart.
- **Top Customers** table by total spend.
- **Sales by Category / Region** (column or map).
- **Sales trend** by month (seasonality).
- Slicers: Product Category, Date, Customer segment.

## 8. Power BI Service
- Published to a Workspace; **scheduled refresh** via data gateway.
- Shared with the business through an app / workspace.

## 9. Business Impact
- Found **top-selling products** → better inventory planning.
- Identified **best customers** → targeted marketing and loyalty.
- Showed **trends and seasonality** → promotions at the right time.
- Highlighted weak products/regions to fix or drop.

## 10. Tools Used
SQL Server · Power BI · TMDL · DAX · Power Query · GitHub Copilot · Git & GitHub

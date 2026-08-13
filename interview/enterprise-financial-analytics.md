# Enterprise Financial Analytics

## 1. What is this project?
An end-to-end **financial analytics** BI solution. It turns raw financial data into
clear, always-updated dashboards for management and finance teams.

## 2. Business Problem it Solves
- Leaders waited for slow, manual Excel reports.
- No single source of truth for revenue, cost, and profit.
- Hard to spot cost overruns or low-margin areas early.

## 3. What I Built (data flow)
```
SQL Server DB → Power Query (clean) → Star Schema Model (TMDL) → DAX measures → Report → Power BI Service
```

## 4. Data Modeling
- **Star schema**: central fact table (financial transactions) + dimensions
  (Date, Account, Department, Region).
- Dedicated **Date table** for time intelligence.
- Model written as **TMDL** (model as code), version-controlled in Git.

## 5. Key DAX Measures
```DAX
Total Revenue  = SUM( Fact[Revenue] )
Total Cost     = SUM( Fact[Cost] )
Net Profit     = [Total Revenue] - [Total Cost]
Profit Margin %= DIVIDE( [Net Profit], [Total Revenue] )
Revenue YTD    = TOTALYTD( [Total Revenue], 'Date'[Date] )
Revenue LY     = CALCULATE( [Total Revenue], SAMEPERIODLASTYEAR('Date'[Date]) )
YoY Growth %   = DIVIDE( [Total Revenue] - [Revenue LY], [Revenue LY] )
```

## 6. Power Query
- Removed unused columns, fixed data types, filtered rows early.
- Kept **query folding** so steps run as SQL on the server → fast refresh.

## 7. Reports (Financial / Executive Dashboard)
- Executive **KPI cards**: Revenue, Cost, Net Profit, Margin %.
- **Trend line**: revenue over time with YoY growth.
- **Waterfall chart**: how profit builds up.
- **Actual vs Budget** variance analysis.
- Slicers: Year, Region, Department.

## 8. Power BI Service
- Published to a Workspace; **scheduled refresh** via data gateway.
- **Row-Level Security (RLS)**: each manager sees only their department/region.

## 9. Business Impact
- Replaced manual Excel with an automatic, real-time dashboard.
- Faster decisions and a single source of truth.
- Early view of cost overruns and low-margin areas.

## 10. Tools Used
SQL Server · Power BI · TMDL · DAX · Power Query · GitHub Copilot · Git & GitHub

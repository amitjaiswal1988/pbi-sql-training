# Interview Prep — My Two Power BI Projects

> Projects: **Enterprise Financial Analytics** and **Retail Analytics**
> Tools: SQL Server (T-SQL), Power BI, TMDL, DAX, Power Query, GitHub Copilot, Git & GitHub

---

## 0) The Big Picture — How Data Flows (say this first)

Learn this flow. It is the heart of every BI project.

```
Data Source (SQL Server DB)
      ↓  (Extract)
Power Query  →  clean & shape data (this is the "Transform" step)
      ↓  (Load)
Data Model   →  tables + relationships + DAX measures (TMDL defines this)
      ↓
Report       →  visuals, charts, KPIs (Power BI Desktop)
      ↓  (Publish)
Power BI Service (cloud) → share, schedule refresh, dashboards
```

**One line to say in interview:**
> "I follow the standard ETL flow — extract from SQL Server, transform in Power Query, model the data with relationships and DAX, build the report, and publish to the Power BI Service."

---

## 1) DATA MODELING (most important — interviewers love this)

### What is a data model?
- It is how tables are **connected** to each other.
- Good model = fast reports + correct numbers.

### Star Schema (ALWAYS mention this)
- **Fact table** = the numbers/events (Sales, Orders, Transactions). Big table.
- **Dimension tables** = the descriptions (Customer, Product, Date, Region). Small tables.
- Shape looks like a star: one fact in the middle, dimensions around it.

**Why star schema?**
- It is faster than joining many tables.
- Power BI's engine (VertiPaq) is built for it.
- Easy to understand and maintain.

**Say this:**
> "I designed my model as a **star schema** — a central fact table for sales/transactions, surrounded by dimension tables like Customer, Product, and Date. This keeps queries fast and DAX simple."

### Relationships
- **One-to-Many (1:*)** — the normal one. One customer has many orders.
- **Direction** — filter flows from the "one" side (dimension) to the "many" side (fact).
- **Cardinality** — how rows match between tables.

### Date Table (very important)
- Every model needs a **dedicated Date table**.
- It powers **Time Intelligence** DAX (YTD, last year, month-over-month).
- Mark it as the official "Date Table" in Power BI.

### TMDL (Tabular Model Definition Language)
- TMDL lets me write the **whole data model as text/code**.
- Tables, columns, relationships, and measures are stored as readable code files.

**Why TMDL matters (say this):**
> "With TMDL I treat the data model as code. I can put it in Git, see exactly what changed, review it, and roll back if needed. It brings software engineering discipline to BI."

---

## 2) DAX (formulas for calculations)

### Two types of DAX
1. **Measures** — calculated when you view the report (dynamic). Use these mostly.
2. **Calculated Columns** — calculated when data loads (stored). Use rarely.

**Rule to remember:** Prefer measures over calculated columns (measures are lighter and faster).

### Core DAX functions to know

| Function | What it does | Simple example |
|---|---|---|
| `SUM` | Adds a column | `Total Sales = SUM(Sales[Amount])` |
| `AVERAGE` | Average | `Avg Order = AVERAGE(Sales[Amount])` |
| `COUNTROWS` | Counts rows | `Order Count = COUNTROWS(Sales)` |
| `DISTINCTCOUNT` | Counts unique | `Customers = DISTINCTCOUNT(Sales[CustomerID])` |
| `CALCULATE` | **The most powerful** — changes the filter | see below |
| `DIVIDE` | Safe divide (no error on 0) | `DIVIDE([Profit],[Sales])` |

### CALCULATE — the star function
- `CALCULATE` changes the filters on a calculation.
- Example — sales for only one product category:
  ```DAX
  Bikes Sales = CALCULATE( SUM(Sales[Amount]), Product[Category] = "Bikes" )
  ```

**Say this:**
> "CALCULATE is the most important DAX function. It lets me change the filter context — for example, calculate sales for a specific category, region, or time period."

### Time Intelligence (shows seniority)
```DAX
Sales YTD      = TOTALYTD( SUM(Sales[Amount]), 'Date'[Date] )
Sales LY       = CALCULATE( SUM(Sales[Amount]), SAMEPERIODLASTYEAR('Date'[Date]) )
YoY Growth %   = DIVIDE( [Total Sales] - [Sales LY], [Sales LY] )
```

### Filter Context vs Row Context (interviewers ask this)
- **Row context** — DAX looks at one row at a time (calculated columns, iterators like SUMX).
- **Filter context** — filters coming from visuals, slicers, and CALCULATE.

**Simple line:**
> "Row context is one row at a time. Filter context is the filters applied by the report or by CALCULATE. CALCULATE can turn one into the other."

### My real measures (example set from my projects)
```DAX
Total Sales     = SUM( Sales[LineTotal] )
Total Orders    = DISTINCTCOUNT( Sales[SalesOrderID] )
Total Customers = DISTINCTCOUNT( Sales[CustomerID] )
Avg Order Value = DIVIDE( [Total Sales], [Total Orders] )
Profit Margin % = DIVIDE( [Total Profit], [Total Sales] )
```

---

## 3) POWER QUERY + QUERY FOLDING

### What is Power Query?
- The tool inside Power BI to **clean and transform** data before it loads.
- Written in a language called **M**.
- Common steps: remove columns, filter rows, change data types, merge tables, split columns, group by.

### Query Folding (KEY concept — impress the interviewer)
- **Query folding** = Power BI pushes my transformation steps **back to the SQL Server** to run there, instead of doing them in Power BI.
- The source database does the heavy work and sends back only the final result.

**Why it matters:**
- Much **faster** refresh.
- Less data pulled over the network.
- Less memory used.

**Say this:**
> "I keep query folding intact — my filters and transformations get translated into SQL and run on the server. This makes refresh fast and efficient. I put folding-friendly steps first and avoid steps that break folding early."

**What breaks folding (good to mention):**
- Adding custom columns with complex M logic.
- Some merges or steps not supported by the source.
- I check folding with **"View Native Query"** (right-click a step).

**Rule to remember:** Do filtering and row-reduction **early** so it folds to SQL. Do the "breaking" steps **last**.

---

## 4) POWER BI SERVICE (the cloud part)

### What is it?
- The **online/cloud** version of Power BI (app.powerbi.com).
- Where I **publish, share, and schedule** reports.

### What I do in the Service
- **Publish** report from Desktop to a **Workspace**.
- **Datasets** — the published data model. Reports connect to it.
- **Scheduled Refresh** — auto-refresh data (e.g. every morning). Uses a **Data Gateway** if the source is on-premises (like my local SQL Server).
- **Dashboards** — pin visuals from many reports into one screen.
- **Apps** — package reports and share with business users.
- **Row-Level Security (RLS)** — show each user only their own data (e.g. a regional manager sees only their region).

**Say this:**
> "After building in Desktop, I publish to the Power BI Service. There I set up scheduled refresh through a gateway, apply Row-Level Security, and share reports with the business through a workspace or app."

### On-Premises Data Gateway (because my source is local SQL Server)
- A bridge between the **cloud service** and my **local SQL Server**.
- Lets the cloud refresh data that lives on my machine/company server.

---

## 5) REPORTING — What Reports I Built

### Enterprise Financial Analytics — reporting
This is a **financial/executive** report. Focus: money, profit, trends.

**Report pages / visuals:**
- **Executive KPI cards** — Total Revenue, Total Cost, Net Profit, Profit Margin %.
- **Trend line chart** — Revenue over time (monthly/yearly), with YoY growth.
- **P&L style table** — income vs expenses breakdown.
- **Waterfall chart** — how profit builds up (revenue minus costs).
- **Variance analysis** — Actual vs Budget/Target.
- **Slicers** — by Year, Region, Department.

**Type of reporting:** Financial reporting / Executive dashboard / Management reporting.

### Retail Analytics — reporting
This is a **sales & operations** report. Focus: products, customers, sales.

**Report pages / visuals:**
- **Sales KPIs** — Total Sales, Orders, Avg Order Value, Customers.
- **Top 10 Products** — bar chart (which products sell most).
- **Top Customers** — table with total spend.
- **Sales by Category / Region** — column or map visual.
- **Time trend** — sales by month, seasonality.
- **Slicers** — by Product Category, Date, Customer segment.

**Type of reporting:** Sales analytics / Operational reporting / Customer & product analysis.

### Types of reporting (know the words)
- **Operational reporting** — day-to-day numbers (sales today, orders).
- **Analytical reporting** — trends, comparisons, deep analysis.
- **Strategic / Executive dashboards** — high-level KPIs for managers/CxO.
- **Financial reporting** — revenue, cost, profit, P&L.

---

## 6) BUSINESS IMPACT (why the company cares — say this strongly)

Never just say "I made charts." Say **what business problem it solved**.

### Enterprise Financial Analytics — impact
- Gave leaders a **single source of truth** for financial numbers.
- **Faster decisions** — no more waiting for manual Excel reports.
- Spotted **cost overruns** and **low-margin areas** early.
- Tracked **profit trends and YoY growth** to guide budgets.

**Say this:**
> "The finance project replaced slow manual Excel reports with an automatic, always-updated dashboard. Managers could see profit, cost, and margin in real time and act faster."

### Retail Analytics — impact
- Found the **top-selling products** → better stock/inventory planning.
- Identified **best customers** → focus marketing and loyalty offers.
- Showed **sales trends & seasonality** → plan promotions at the right time.
- Highlighted **weak regions/products** → fix or drop them.

**Say this:**
> "The retail project helped the business know what sells, who buys, and when. That improves inventory decisions, targets marketing to top customers, and increases sales."

### General business value of BI (one-liner)
> "BI turns raw data into decisions. It saves time, reduces guesswork, and helps the business make more money and cut waste."

---

## 7) GITHUB COPILOT + GIT/GITHUB (your modern edge)

### GitHub Copilot
- AI pair programmer inside VS Code.
- Helped me write and fix **T-SQL** and **DAX/TMDL** faster.
- **Important:** I always read and understand the code — Copilot is a helper, not a replacement.

**Say this:**
> "GitHub Copilot sped up my SQL and model coding. It suggested queries and caught mistakes, but I reviewed every line so I fully understand my own code."

### Git & GitHub
- **Local machine** — where I build and test (local SQL Server + Power BI Desktop).
- **GitHub** — remote backup + full version history.
- Because I use **TMDL**, my Power BI model is code, so Git can track model changes too.

**Say this:**
> "I version-control everything with Git. My SQL scripts and my TMDL model live on GitHub, so I have full history and can review or undo any change — a real software-engineering workflow for BI."

---

## 8) COMMON INTERVIEW Q&A (quick answers)

**Q: What is a star schema and why use it?**
> Fact table in the middle, dimensions around it. It's fast and works best with Power BI's engine.

**Q: Measure vs Calculated Column?**
> Measure is dynamic and calculated at view time (light). Calculated column is stored at load time (heavy). Prefer measures.

**Q: What is CALCULATE?**
> The key DAX function that changes filter context to calculate values for specific conditions.

**Q: What is query folding?**
> When Power Query pushes steps back to the source database as SQL, so refresh is faster and lighter.

**Q: How do you refresh data in the cloud?**
> Publish to Service, set scheduled refresh, and use an on-premises data gateway for local sources.

**Q: What is RLS?**
> Row-Level Security — users see only their own data (e.g., only their region).

**Q: Filter context vs row context?**
> Row context = one row at a time. Filter context = filters from visuals/slicers/CALCULATE.

**Q: What was the business impact?**
> Faster decisions, single source of truth, better inventory and marketing, early view of cost/profit problems.

---

## 9) 30-SECOND PITCH (memorize this)

> "I built two BI projects — **Enterprise Financial Analytics** and **Retail Analytics**. I pulled data from SQL Server, cleaned it in Power Query with query folding for speed, and modeled it as a **star schema** using **TMDL** so the model is code in Git. I wrote **DAX measures** for KPIs and time intelligence, built executive and sales dashboards, and published to the **Power BI Service** with scheduled refresh and Row-Level Security. I used **GitHub Copilot** to speed up development. The result: faster, data-driven decisions for finance and retail teams."

---

## 10) One-Line Summaries To Keep In Mind

- **Modeling:** Star schema = fact + dimensions = fast & correct.
- **DAX:** CALCULATE changes filter context; use measures not columns.
- **Power Query:** Query folding pushes work to SQL = fast refresh.
- **Service:** Publish → schedule refresh (gateway) → RLS → share.
- **Reporting:** Finance = profit/cost/margin; Retail = products/customers/sales.
- **Impact:** BI turns data into faster, better business decisions.
- **Modern edge:** TMDL + Git + Copilot = BI done like software engineering.

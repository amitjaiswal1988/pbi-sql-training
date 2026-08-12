# Power BI + SQL — The 3-Week Zero-to-SME Training Kit

A 21-day, SQL-first journey from complete beginner to Power BI subject-matter expert — Azure SQL Database · Power BI Desktop & Service · VS Code + AI · PL-300 ready.

| | |
|---|---|
| **Trainee** | Amit Kumar Jaiswal |
| **Mentor** | Amit Kumar Jaiswal |
| **Start date** | 10 Aug 2026 |
| **Target PL-300 date** | 22 Aug 2026 |

Version 1.0 · August 2026 · Facts verified against Microsoft documentation as of 7 Aug 2026.

---

## Contents

- Part 1 — Welcome: read this first
- Part 2 — Pre-flight: accounts, installs, costs
- Part 3 — Your AI copilot workflow (VS Code + AI agents)
- Part 4 — Week 1: Foundations (Days 1–7)
- Part 5 — Week 2: Intermediate → Advanced (Days 8–14)
- Part 6 — Week 3: Advanced → SME (Days 15–21)
- Part 7 — The PL-300 Certification Guide
- Part 8 — Appendices (A–I)

---

## Part 1 — Welcome: read this first

This kit takes you from never having written a line of SQL to defending a production-grade Power BI solution — in 21 consecutive full-time days. It is a textbook, an exercise book, and a checklist rolled into one document. Your mentor provides the infrastructure (Azure subscription and licensing); you provide the hours and the curiosity.

Two things make this program different from watching tutorial videos:

- **SQL is the spine.** From Day 6 onward, every Power BI model reads only from SQL views you wrote yourself, in a `reporting` schema you designed.
- **Every day ends in proof.** Each day closes with a milestone: a file, a published report, a screenshot, or a graded drill — something checkable.

### The journey at a glance

| Week | You go from → to | Theme | Dataset |
|------|------------------|-------|---------|
| Week 1 (Days 1–7) | Beginner → solid foundations | T-SQL from zero, Power BI Desktop basics, first star schema, first publish | AdventureWorksLT (built-in Azure SQL sample) |
| Week 2 (Days 8–14) | Intermediate → advanced | Load a real 9-table dataset, window functions, layered reporting schema, query folding, DAX in depth, RLS, apps | Olist Brazilian E-Commerce (Kaggle, ~100k orders) |
| Week 3 (Days 15–21) | Advanced → SME | SQL & model performance tuning, storage modes, deployment pipelines, governance, PL-300 readiness, full capstone build & defense | Olist + Formula 1 World Championship (Kaggle) |

### How each day works (budget ~6–8 focused hours)

| Block | What you do | Rough time |
|-------|-------------|-----------|
| Standup | 15 min with mentor: yesterday's milestone, today's plan, blockers | 0:15 |
| Learn | Read the day's concepts and type every example yourself | 2:30–3:30 |
| Build | The hands-on exercise blocks (core mandatory; ➕ stretch optional) | 2:30–3:30 |
| Prove | Complete the ✔ milestone, commit scripts to your training repo | 0:30 |
| Journal | Three lines in `journal/dayNN.md`: what clicked, what's fuzzy, one question | 0:15 |

### The five golden rules

1. **Type everything.** Muscle memory in SQL and DAX is real.
2. **Power BI reads views, not tables.** From Day 6 on, the `rpt` schema is your contract between the database and the report.
3. **Break things on purpose.** Delete a join and predict the row count.
4. **AI explains — you write.** Write your own first attempt at everything.
5. **Commit daily.** Your GitHub repo is your portfolio.

### Master milestone tracker

| Day | Milestone (the proof) | Done |
|-----|-----------------------|------|
| 1 | AdventureWorksLT queryable from VS Code; `day01.sql` with 10 queries committed | ☐ |
| 2 | 10-query graded drill (Appendix C) completed and self-scored ≥ 8/10 | ☐ |
| 3 | Sales-summary query joining 4+ tables, with a written row-count trace | ☐ |
| 4 | A `.pbix` connected to Azure SQL with 5+ visual types, correct data types | ☐ |
| 5 | Playground schema with a dates table; order dates scattered across ~2 years | ☐ |
| 6 | Star-schema `.pbix` fed entirely by `rpt` views, with 3 explicit measures | ☐ |
| 7 | Report published with green scheduled refresh + a dashboard; Gauntlet #1 ≥ 12/15 | ☐ |
| 8 | All 9 Olist tables loaded with row-count validation; data-quality memo | ☐ |
| 9 | 8 window-function queries on Olist, each with a business interpretation | ☐ |
| 10 | Documented `rpt` schema (multi-fact star) + proc; Power BI reconnected as `pbi_reader` | ☐ |
| 11 | Olist `.pbix` where every source query folds (View Native Query proof) | ☐ |
| 12 | 12 documented DAX measures incl. 3 CALCULATE variants | ☐ |
| 13 | Growth page (YTD/YoY/MoM) surviving arbitrary slicing + partial-period diagnosis | ☐ |
| 14 | Published Olist app; RLS verified; Gauntlet #2 ≥ 10/12 | ☐ |
| 15 | Before/after tuning evidence table for all 5 slow queries | ☐ |
| 16 | Model size reduction documented; composite model with aggregation hit; incremental refresh | ☐ |
| 17 | Three-stage deployment pipeline; dataflow-backed table; AI-visuals page | ☐ |
| 18 | Official PL-300 practice assessment ≥ 80%; capstone sign-off; Gauntlet #3 ≥ 10/12 | ☐ |
| 19 | Capstone: design doc approved; F1 data loaded & validated; rpt layer committed | ☐ |
| 20 | Capstone: model + 15 measures + 4 report pages + dynamic RLS live via pipeline | ☐ |
| 21 | Capstone defense graded ≥ 75/100; PL-300 booking date set; 90-day plan written | ☐ |

---

## Part 2 — Pre-flight: accounts, installs, costs

### What your mentor provides

| Item | Details |
|------|---------|
| Azure subscription | Resources in a resource group `rg-pbi-training`. Databases fit the Azure SQL free offer (100,000 vCore-seconds + 32 GB per database/month, free for the life of the subscription — up to 10 databases). |
| Work (Entra ID) account | A Microsoft 365 / Entra ID account in the company tenant. Personal emails cannot use the Power BI Service. |
| Power BI licensing | Day 1: self-activate the free 60-day Power BI individual trial. Day 14: start the 60-day Microsoft Fabric trial capacity. |
| A second test account | Needed on Days 14 and 20 to prove Row-Level Security works. |
| Review slots | 30-minute mentor reviews on Days 7, 14, 18, and 21 (Day 21 is 90 minutes), plus a daily 15-minute standup. |

### What you install (in order)

1. **VS Code** — code.visualstudio.com.
2. **VS Code extensions** — MSSQL (`ms-mssql.mssql`) and GitHub Copilot + Copilot Chat.
3. **Git** — git-scm.com. Create a private GitHub repo `pbi-sql-training` with folders `sql/`, `pbix/`, `journal/`, `docs/`.
4. **Power BI Desktop** — Microsoft Store or `winget install Microsoft.PowerBI` (Windows-only, free).
5. **Week 3 (optional):** DAX Studio (daxstudio.org) and Tabular Editor 2 (tabulareditor.com).

### Setup traps

- **Azure SQL firewall:** add a firewall rule for your client IP or connections fail.
- **Two GitHub things differ:** Copilot (the AI) vs your GitHub repo (version control) — sign in to both.
- **Store vs downloaded Power BI Desktop:** both fine; the Store build auto-updates.

### Cost guardrails

- Azure SQL free offer databases; budget alert at $10.
- Azure Blob Storage (Week 2): a few cents — delete the container after Day 8.
- Power BI + Fabric trials: $0 for 60 days each.

---

## Part 3 — Your AI copilot workflow (VS Code + AI agents)

**The bright line:** AI explains, critiques, and quizzes. You write. Days 7, 14, and 18 have no-AI gauntlets.

### Your SQL cockpit: the MSSQL extension

- **Connect:** server icon → Add Connection → `<yourserver>.database.windows.net`, database, SQL login.
- **Query:** any `.sql` file gets a green ▶ Run once a connection is active.
- **IntelliSense:** refresh with `MS SQL: Refresh IntelliSense Cache` after DDL changes.
- **Execution plans:** Enable Actual Plan toggle (Day 15).
- **Schema Designer / Schema Compare:** visual table design and diffing.

### The five prompt patterns

| Pattern | When | Example |
|---------|------|---------|
| EXPLAIN | Concept/error you don't understand | "Explain a correlated subquery to someone who learned JOINs yesterday." |
| CRITIQUE | Your attempt works, want review | "Critique this: correctness, readability, performance. Don't rewrite." |
| QUIZ | End of a topic; before gauntlets | "Quiz me with 8 questions on window functions, one at a time." |
| DEBUG | Wrong data, stuck 15+ min | "This returns 3× rows. Ask me diagnostic questions instead of guessing." |
| OPTIMIZE | Week 3, slow query | "Given this plan XML, what's the most expensive operator and two fixes?" |

### The verification habit

1. Read it aloud. 2. Predict, then run. 3. Check one authoritative source (Microsoft Learn) for anything load-bearing.

---

## Part 4 — Week 1: Foundations (Days 1–7)

### Day 1 — Setup, first connection, first queries

Provision Azure SQL with the AdventureWorksLT sample, wire up VS Code, and run your first SELECTs.

```sql
SELECT TOP (10) FirstName, LastName, CompanyName   -- which columns
FROM   SalesLT.Customer                            -- which table
WHERE  CompanyName LIKE 'A%'                        -- which rows
ORDER BY LastName;                                  -- in what order
```

- `SELECT *` for exploring only; banned in saved scripts.
- Strings use single quotes; `'A%'` with LIKE = "starts with A".
- `ORDER BY` is the only guarantee of row order.

**Milestone:** `sql/day01.sql` with 10 working queries committed.

### Day 2 — SELECT deep dive — types, predicates, functions, CASE

Logical processing order: `FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → TOP`. A SELECT alias doesn't exist yet in WHERE.

```sql
SELECT CAST(ListPrice AS int)           AS RoundedDown,
       TRY_CAST('not a number' AS int)  AS ReturnsNull,
       FORMAT(SellStartDate, 'yyyy-MM') AS NiceButSlow
FROM   SalesLT.Product;
```

NULL handling: `IS NULL`, `COALESCE(a,b)`, `NULLIF(a,b)`. Any comparison with NULL yields *unknown*.

```sql
SELECT Name, ListPrice,
       CASE WHEN ListPrice >= 2000 THEN 'Premium'
            WHEN ListPrice >=  500 THEN 'Mid'
            WHEN ListPrice >     0 THEN 'Budget'
            ELSE 'Not for sale' END AS PriceBand
FROM SalesLT.Product
ORDER BY ListPrice DESC;
```

**Milestone:** Drill C.1 self-scored ≥ 8/10; `day02.sql` committed.

### Day 3 — Joins and aggregation

| Join | Keeps | Typical use |
|------|-------|-------------|
| INNER | Only rows matching both sides | Facts to their dimensions |
| LEFT | All left rows; NULLs where no right match | "All customers, with orders if any" |
| RIGHT | Mirror of LEFT (rewrite as LEFT) | — |
| FULL | Everything both sides | Reconciliation |
| CROSS | Every combination | Grids (product × month) |

Row-count discipline: predict the count before running; check with `COUNT(*)`.

```sql
SELECT c.Name AS Category, COUNT(*) AS ProductCount, AVG(p.ListPrice) AS AvgPrice
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS c ON c.ProductCategoryID = p.ProductCategoryID
GROUP BY c.Name
HAVING COUNT(*) >= 5
ORDER BY AvgPrice DESC;
```

WHERE filters rows before grouping; HAVING filters groups after.

**Milestone:** `day03.sql` with a 4+-table sales summary and a written row-count trace.

### Day 4 — First Power BI day — Desktop, Import, core visuals

- Desktop = author; Service = operate.
- Get Data → Azure SQL Database → Import mode → Transform Data (always visit Power Query first).
- Verify column types, remove unused columns, rename applied steps.

| You want to show | Reach for | Avoid |
|------------------|-----------|-------|
| One number | Card / KPI | Fake-target gauge |
| Compare categories | Bar / column | Pie with 7+ slices |
| Change over time | Line / area | 3-D anything |
| Composition | Stacked/100% stacked, treemap | Pie again |
| Detail lookup | Table / matrix | 40-column table |
| Two measures | Scatter | — |

**Milestone:** `day04-sales-overview.pbix` with 5+ visual types, correct types, renamed steps, one slicer.

### Day 5 — Subqueries, DDL & DML — and fixing the calendar

```sql
-- Scalar subquery
SELECT Name, ListPrice FROM SalesLT.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM SalesLT.Product);

-- EXISTS (correlated)
SELECT c.CustomerID, c.CompanyName FROM SalesLT.Customer AS c
WHERE EXISTS (SELECT 1 FROM SalesLT.SalesOrderHeader AS h WHERE h.CustomerID = c.CustomerID);
```

Set operators: `UNION` (dedupes), `UNION ALL` (keeps dupes), `INTERSECT`, `EXCEPT`.

DML in a transaction (the seatbelt lab): `BEGIN TRAN; UPDATE ...; SELECT ...; ROLLBACK;`

Build a real `DimDate` and scatter AWLT's single-date orders across ~24 months using `DATEADD(MONTH, -(SalesOrderID % 24), OrderDate)`.

**Milestone:** `day05.sql` with `play` schema, populated `DimDate` (1,461 rows), scattered order dates.

### Day 6 — Data modeling — your first star schema

Fact table = events at a fixed grain (one row = one order line). Dimension tables = one row per thing you slice by. **Power BI never reads raw tables again** — it consumes `rpt` views.

```sql
CREATE OR ALTER VIEW rpt.FactSales AS
SELECT d.SalesOrderID, d.SalesOrderDetailID,
       CAST(h.OrderDate AS date) AS OrderDate,
       h.CustomerID, d.ProductID, d.OrderQty, d.UnitPrice,
       CAST(d.LineTotal AS decimal(18,2)) AS LineTotal
FROM SalesLT.SalesOrderDetail AS d
JOIN SalesLT.SalesOrderHeader AS h ON h.SalesOrderID = d.SalesOrderID;
```

Explicit measures:

```DAX
Total Revenue   = SUM ( FactSales[LineTotal] )
Units Sold      = SUM ( FactSales[OrderQty] )
Order Count     = DISTINCTCOUNT ( FactSales[SalesOrderID] )
Avg Order Value = DIVIDE ( [Total Revenue], [Order Count] )
```

**Milestone:** `day06-star.pbix` — clean star over four `rpt` views, DimDate marked, FKs hidden, 3+ explicit measures.

### Day 7 — The Power BI Service + Week 1 gauntlet

- Publish to a workspace; understand report vs semantic model vs dashboard.
- Scheduled refresh with stored credentials (cloud source = no gateway).
- Role ladder: Viewer < Contributor < Member < Admin.
- Gauntlet #1 (no AI, 60 min, ≥ 12/15).

**Milestone:** Report + dashboard live with green refresh; mentor added as Viewer; Gauntlet #1 ≥ 12/15.

---

## Part 5 — Week 2: Intermediate → Advanced (Days 8–14)

### Day 8 — The data-engineering day — Kaggle → Azure SQL

Read the Olist dataset docs and note each file's grain before writing code. Draft DDL with AI, then correct it yourself (nvarchar for Portuguese text, nvarchar(5) for zip prefixes with leading zeros, etc.). Load via Blob Storage + `BULK INSERT` (CODEPAGE 65001 for UTF-8). Validate row counts; attempt keys; document failures (duplicate review_id, geolocation grain).

**Milestone:** All 9 tables in `stg` with validated counts; `day08-data-quality-memo.md` committed.

### Day 9 — Advanced SQL I — CTEs and window functions

```sql
WITH monthly AS (
    SELECT DATETRUNC(MONTH, o.order_purchase_timestamp) AS order_month,
           SUM(oi.price) AS revenue
    FROM stg.orders o JOIN stg.order_items oi ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY DATETRUNC(MONTH, o.order_purchase_timestamp)
)
SELECT * FROM monthly ORDER BY order_month;
```

Window functions compute across rows without collapsing: `ROW_NUMBER / RANK / DENSE_RANK / NTILE`, `SUM() OVER (PARTITION BY ... ORDER BY ... ROWS ...)`, `LAG / LEAD`.

**Milestone:** `day09.sql` — 8 analytics queries, each with a one-line interpretation.

### Day 10 — Advanced SQL II — the reporting layer

Layered `stg → rpt` architecture. Build dimensions, a multi-fact star (item grain vs payment grain), a review dedup, an aggregate geolocation view. Parameterized procs with TRY/CATCH. Least-privilege reader:

```sql
CREATE USER pbi_reader WITH PASSWORD = '<strong password>';
GRANT SELECT ON SCHEMA::rpt TO pbi_reader;
```

**Milestone:** `sql/rpt/` with dims + 3 facts + DimDate + proc; Power BI connects as `pbi_reader`.

### Day 11 — Power Query depth and query folding

Query folding pushes steps down as native SQL. Right-click a step → **View Native Query**; grayed = folding broke. Keep foldable steps first; push heavy logic into `rpt` views. Assemble the multi-fact Olist model with an inactive role-playing date relationship.

**Milestone:** `day11-olist.pbix` — multi-fact star; every source query folds; folding-break screenshots.

### Day 12 — DAX I — evaluation context and CALCULATE

- **Row context** = "the current row" (calculated columns, iterators).
- **Filter context** = "which rows are visible" (visuals, slicers, filters).

```DAX
Delivered Revenue = CALCULATE ( [Revenue], FactOrderItems[order_status] = "delivered" )
Revenue % of Total = DIVIDE ( [Revenue], CALCULATE ( [Revenue], ALL ( DimCustomer[state] ) ) )
Avg Order Value = AVERAGEX ( VALUES ( FactOrderItems[order_id] ), CALCULATE ( SUM ( FactOrderItems[price] ) ) )
```

Context transition: every measure reference carries an invisible CALCULATE.

**Milestone:** 12 documented measures; the wrong-on-purpose "Card Revenue" diagnosed.

### Day 13 — DAX II — time intelligence and analytical patterns

```DAX
Revenue YTD = TOTALYTD ( [Revenue], DimDate[DateKey] )
Revenue PY  = CALCULATE ( [Revenue], SAMEPERIODLASTYEAR ( DimDate[DateKey] ) )
Revenue YoY% = DIVIDE ( [Revenue] - [Revenue PY], [Revenue PY] )
```

Partial-period trap: guard YoY% so empty current periods don't read as "−100%". `USERELATIONSHIP` activates role-playing dates. `RANKX`, `VAR/RETURN`, field parameters.

**Milestone:** `day13-olist.pbix` — Growth page correct under arbitrary slicing; partial-period write-up.

### Day 14 — Report craft, RLS, and shipping an app

4-page report; tooltips, drillthrough, bookmarks, mobile layout, accessibility. RLS static (`[state] = "SP"`) and dynamic (`LOOKUPVALUE(...) = USERPRINCIPALNAME()`). Prove it with the second account. Ship an app with audiences; subscriptions and alerts. Gauntlet #2 (≥ 10/12).

**Milestone:** App published with two audiences; RLS verified; Gauntlet #2 ≥ 10/12.

---

## Part 6 — Week 3: Advanced → SME (Days 15–21)

### Day 15 — SQL performance — indexes and execution plans

Heap vs clustered vs nonclustered vs covering vs columnstore. Read plans right-to-left: Index Seek vs Scan, Key Lookup, join operators, arrow thickness. Measure with `SET STATISTICS IO, TIME ON`. SARGability: never wrap the filtered column in a function.

```sql
-- NOT SARGable
WHERE YEAR(order_purchase_timestamp) = 2018
-- SARGable
WHERE order_purchase_timestamp >= '2018-01-01' AND order_purchase_timestamp < '2019-01-01'
```

**Milestone:** `day15-tuning.md` — before/after logical reads + duration for all five queries.

### Day 16 — Power BI performance — VertiPaq, storage modes, aggregations

Compression depends on cardinality. Diet the model; measure with DAX Studio / VertiPaq Analyzer. Storage modes: Import (default), DirectQuery (freshness/size), Dual, Direct Lake (Fabric). User-defined aggregations + incremental refresh (`RangeStart`/`RangeEnd`).

**Milestone:** `day16-perf.md` — model size before/after; aggregation-hit proof; incremental refresh live.

### Day 17 — Deployment, governance, and the wider platform

Dev→Test→Prod deployment pipelines with data-source rules (Day 11 parameters pay off). Gateways: cloud source → none; private network → standard/VNet. Endorsement (Promoted/Certified), sensitivity labels, lineage, Build permission. Dataflows, AI visuals, PBIP + TMDL source control.

**Milestone:** Pipeline through all three stages with a deployment rule; dataflow feeding DimProduct; `.pbip` folder committed.

### Day 18 — PL-300 readiness day

Sweep the four exam domains against your actual work. Sit the official practice assessment (≥ 80%). Build a personal weak-topics cheat sheet. Gauntlet #3 (≥ 10/12). Get the capstone brief.

**Milestone:** Practice assessment ≥ 80%; Gauntlet #3 ≥ 10/12; capstone kickoff signed.

### Days 19–21 — The Capstone: Formula 1 Analytics, end to end

Dataset: Formula 1 World Championship 1950–2024 (14 CSVs; `\N` as null marker; lap_times ≈ 575k rows).

- **Day 19 — Data platform:** design doc first; load 14 CSVs; ≥ 6 rpt views; ≥ 1 proc; indexing pass with evidence.
- **Day 20 — Model, DAX, report, ship:** star model; ≥ 15 measures across five families; ≥ 4 report pages; dynamic RLS; publish via pipeline.
- **Day 21 — Defense:** 30-min walkthrough + Q&A, rubric scored live (≥ 75 passes, ≥ 90 = SME distinction). Then a DP-600 stretch taste (OneLake, lakehouse, Direct Lake) and a 90-day plan.

**Milestone:** Capstone graded ≥ 75/100; PL-300 booking date set; 90-day plan committed.

---

## Part 7 — The PL-300 Certification Guide

Exam **PL-300: Microsoft Power BI Data Analyst** → Microsoft Certified: Power BI Data Analyst Associate. Pass mark 700/1000, ~100 minutes, case studies included, annual free online renewal.

### The four domains, mapped to your three weeks

| Domain (weight) | Where you did it |
|-----------------|------------------|
| Prepare the data (25–30%) | Days 4, 8, 11, 16, 17 |
| Model the data (25–30%) | Days 6, 11, 12, 13, 16 |
| Visualize & analyze the data (25–30%) | Days 4, 13, 14, 17 |
| Manage & secure Power BI (15–20%) | Days 7, 14, 16, 17 |

### Gap-closers (light-touch topics)

- **Calculation groups** — reusable calculation items (YTD, PY, YoY%) via `SELECTEDMEASURE()`.
- **Visual calculations** — DAX on the visual's own result grid.
- **Copilot in Power BI** — requires paid Fabric capacity (not trial).
- **Direct Lake** — Fabric-native storage mode.
- **Personalize visuals & export settings** — report/tenant settings.

### Exam-day tactics

1. Read case-study requirements tabs first; you cannot return after leaving a case study.
2. Pick the Microsoft-recommended answer (least privilege, star schemas, measures over calculated columns).
3. Flag-and-move on anything over 90 seconds; guess before submitting.
4. Sleep.

### After PL-300: DP-600 (Fabric Analytics Engineer)

| Domain (weight) | Your head start |
|-----------------|-----------------|
| Maintain a data analytics solution (25–30%) | Days 10, 14, 17 |
| Prepare data (45–50%) | Weeks 1–2 (minus KQL) |
| Implement & manage semantic models (25–30%) | Days 12, 13, 16, 21 |

---

## Part 8 — Appendices

### Appendix A — Olist load kit (Day 8 safety net)
Full corrected `stg` DDL for all nine tables, nine `BULK INSERT` statements (CODEPAGE 65001, FIELDQUOTE, FIRSTROW=2), a `bcp` fallback, and a validation block comparing counts against Kaggle's published numbers.

### Appendix B — F1 capstone loader skeleton (Day 19)
File inventory + grains, the `\N` null-marker pattern (land as nvarchar, clean with `NULLIF(col,'\N')` + `TRY_CAST`), one worked `rpt.FactResults` example.

### Appendix C — Drill banks, gauntlets, and answer keys
- C.1 Day-2 drill (10 queries, ≥ 8).
- C.2 Gauntlet #1 (Days 1–6, 15 tasks, ≥ 12).
- C.3 Gauntlet #2 (Week 2, 12 tasks, ≥ 10).
- C.4 The five slow queries (Day 15 lab) with intended fixes.
- C.5 Gauntlet #3 (exam-shaped, 12 tasks, ≥ 10).

### Appendix D — Templates
Daily journal, data-quality memo, capstone design doc, standup format.

### Appendix E — Capstone rubric (mentor grading sheet)
SQL layer 20 · Model design 20 · DAX 15 · Report & UX 15 · Deployment & security 15 · Performance 10 · Docs & presentation 5. Pass ≥ 75; ≥ 90 = SME distinction.

### Appendix F — Cheat sheets
T-SQL (logical order, EXISTS, NULL handling, windows, safety, speed), DAX (CALCULATE, ALL family, iterators, time intelligence, relationships), Power Query / M (profiling, combine, reshape, folding).

### Appendix G — Troubleshooting (the greatest hits)
Firewall errors, login failures, serverless auto-pause, refresh credential errors, folding grayed out, BULK INSERT truncation, UTF-8 mojibake, blank measures, RLS "doesn't work", doubled numbers.

### Appendix H — Glossary
Aggregation table, app, calculation group, cardinality, composite model, conformed dimension, context transition, CTE, dataflow, DAX, deployment pipeline, dimension, Direct Lake, DirectQuery, drillthrough, endorsement, fact table, field parameter, filter context, gateway, grain, implicit/explicit measure, Import mode, incremental refresh, lakehouse/warehouse, M/Power Query, measure, OneLake, PBIP/TMDL, query folding, RLS/OLS, row context, SARGable, semantic model, semi-additive, star schema, VertiPaq, workspace roles.

### Appendix I — Mentor's guide (one page)
Pre-flight checklist, review agendas (Days 7/14/18/21), grading duties, master link list.

---

_End of kit. Version 1.0 — August 2026. When Power BI's monthly release moves a button this document names, trust the concept, find the button, and update the doc._

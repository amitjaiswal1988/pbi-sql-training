# Day 2 - SQL Practice Log

**Topic:** SELECT deep dive

**Date:** 2026-08-11

## What I covered

- Learned what a schema is and how it groups tables inside a database.
- Learned how to list schemas and tables from system views.
- Read a table column by column using `INFORMATION_SCHEMA.COLUMNS`.
- Identified primary keys for key tables.
- Understood foreign keys as relationship links between tables.
- Checked table row counts and null values for basic data quality.
- Practiced using `COUNT`, `DISTINCT`, `TOP`, `ORDER BY`, `LIKE`, `IS NULL`, `CASE`, `COALESCE`, and `TRY_CAST` concepts from Day 2.

## Tables reviewed

- `SalesLT.Product`
- `SalesLT.Customer`
- `SalesLT.SalesOrderHeader`
- `SalesLT.SalesOrderDetail`
- `SalesLT.Address`
- `SalesLT.CustomerAddress`
- `SalesLT.ProductCategory`
- `SalesLT.ProductDescription`
- `SalesLT.ProductModel`

## Queries practiced

- List all schemas
- List all tables by schema
- Inspect columns in `SalesLT.Product`
- Find primary keys
- Find foreign key relationships
- Count rows in the main tables
- Check nulls in product columns

## Notes

- Schema is a logical grouping, not a data table.
- Table stores the actual data in rows and columns.
- Primary key = unique row identity.
- Foreign key = link between tables.
- Null checks help spot reporting risk early.

## What to practice next

- Explain each query line by line without looking at notes.
- Run the queries again from memory.
- Move from metadata queries to real joins between Customer, Order, and Product.
- Write one short business summary for each table.

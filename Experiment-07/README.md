# Experiment 7 - Star/Snowflake Schema for a Business Case and OLAP Operations

**Syllabus module:** 4 - Data Warehousing & OLAP  
**Source:** `Experiment_7_Star_snowflake_Schema_OLAP_Opeations_-_Copy.docx` (schema diagram + output screenshots are in the file)  
**Validation:** NOT EXECUTED - reviewed only. **1 correction** (Roll-up needs `GROUP BY`).

## Aim
Design a Sales data warehouse (star schema: 1 fact + 4 dimensions) and perform Roll-up, Drill-down, Slice, Dice and Pivot.

## Required software
MySQL 8 + Workbench (EER diagram via *Database -> Reverse Engineer*).

## How to run
```bash
mysql -u root -p < code.sql
```

## Expected output (derived by hand from the data)
| Operation | Result |
|---|---|
| Roll-up | 2026 -> 374500.00 |
| Drill-down | Jan 120000 · Feb 150000 · Apr 63000 · May 11500 · Jul 30000 |
| Slice | all 8 fact rows (all dates are in 2026) |
| Dice | Laptop 180000 · Mobile 150000 · Printer 30000 |

## Observations
- **Snowflake not implemented.** The syllabus says Star/Snowflake; the source only builds the star. A snowflake would normalise e.g. `dim_product.category` into its own `dim_category` table. Not added by me.
- The Pivot query in the source is a grouped listing. A true pivot (months as columns) uses `SUM(CASE WHEN t.month_name='January' THEN f.sales_amount END) AS January, ...` - mention this if asked; it is *supplementary* and not in your source.
- `dim_customer` and `dim_location` both hold city/state; the fact table links to both.

## Viva questions
1. **Fact vs dimension table?** Fact = numeric measures + foreign keys; dimension = descriptive attributes.
2. **Star vs snowflake?** Star has denormalised dimensions; snowflake normalises dimensions into sub-tables (less redundancy, more joins).
3. **Roll-up vs drill-down?** Roll-up summarises to a higher level; drill-down goes to finer detail.
4. **Slice vs dice?** Slice fixes one dimension value; dice selects ranges/values on several dimensions.
5. **What is a pivot?** Rotating dimension values from rows to columns.

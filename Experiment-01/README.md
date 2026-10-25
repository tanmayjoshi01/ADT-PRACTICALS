# Experiment 1 - MySQL Database/Table Creation and Complex Querying to Analyze Execution Plans

**Syllabus module:** 1 - Query Processing and Optimization  
**Source:** `Experiment_NO_1_DATABASE.docx` (22 numbered items; screenshots of outputs are in the source file)  
**Validation:** NOT EXECUTED - syntax and logic reviewed only. No corrections were needed.

## Aim
Create a MySQL database and tables, run basic-to-complex queries (filters, aggregates, GROUP BY, joins, subqueries) and study execution plans using `EXPLAIN` / `EXPLAIN ANALYZE`.

## Required software
MySQL Server 8.0.18 or newer + MySQL Workbench (or `mysql` CLI). `EXPLAIN ANALYZE` does not work on older versions.

## Procedure (follows `code.sql` numbering)
1. Create `techworld`; create `Department` (parent) and `Employee` (child, FK to Department).
2. Insert 5 departments, then 7 employees.
3. Display both tables; filter with `WHERE`.
4. `EXPLAIN` a query; `UPDATE` and `DELETE` rows; `ORDER BY`.
5. Aggregates (SUM/AVG/MAX), GROUP BY, INNER/LEFT/RIGHT JOIN, two nested queries.
6. Compare `EXPLAIN` with `EXPLAIN ANALYZE` on both tables.

## How to run
```bash
mysql -u root -p < code.sql
# or open code.sql in MySQL Workbench and run it statement by statement
```
(Run statement by statement if you want to capture each output.)

## Expected output (derived by hand from the data - compare with your screenshots)
| Item | Expected result |
|---|---|
| 5 | Arjun (52000), Vikram (65000), Rohan (57000) |
| 6 | Arjun, Vikram, Sahil |
| After 8 + 9 | Arjun 57000, Vikram 70000; Sahil removed |
| 11 / 12 / 13 | SUM 322000, AVG 53666.6667, MAX 70000 |
| 14 | 201 -> 127000, 202 -> 47000, 203 -> 42000, 204 -> 57000, 205 -> 49000 |
| 19 | Vikram, Arjun, Rohan |
| 18 (RIGHT JOIN) | all 5 departments appear |

`EXPLAIN` on a table with no WHERE normally shows `type = ALL` (full table scan).

## Observations
- Items 7 and 21 are the same `EXPLAIN` statement; 21 adds `EXPLAIN ANALYZE` for actual timing.
- Order matters: update/delete (8, 9) run **before** the aggregates, so aggregate values reflect the changed data.
- Employee 7 can be deleted freely because Employee is the child table.

## Viva questions
1. **What is the difference between EXPLAIN and EXPLAIN ANALYZE?** EXPLAIN shows the estimated plan; EXPLAIN ANALYZE executes the query and shows actual time and rows.
2. **What does `type = ALL` mean?** A full table scan - every row is read.
3. **Why insert into Department before Employee?** The foreign key requires the parent row to exist.
4. **INNER vs LEFT vs RIGHT JOIN?** INNER keeps only matches; LEFT keeps all left-table rows; RIGHT keeps all right-table rows.
5. **What is a nested query?** A query inside another query; the inner one is evaluated first (here to get AVG or a DeptID).

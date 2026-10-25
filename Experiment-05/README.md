# Experiment 5 - MySQL Replication and Fragmented Data Management in Distributed Databases

**Syllabus module:** 3 - Distributed Databases (item 1)  
**Source:** `exp5adt.docx` (output screenshots are inside the file)  
**Validation:** NOT EXECUTED - reviewed only. No code corrections.

## Aim
Demonstrate horizontal fragmentation (split a table by a condition) and replication (a second copy of the data).

## Required software
MySQL 8 + Workbench (single server is enough - everything is simulated with two databases).

## Procedure
1. `masterr` DB, `Employee` table with 10 rows.
2. Fragment by city: `Emp_Pune`, `Emp_Mumbai`.
3. `UNION ALL` to reassemble.
4. Create `Slavee` DB and copy all rows from `masterr.Employee`.

## How to run
```bash
mysql -u root -p < code.sql
```

## Expected output
`Emp_Pune`: ids 1, 5, 9, 10 · `Emp_Mumbai`: ids 2, 4, 6, 7, 8 · replica: all 10 rows.

## Important observations (please read before the viva)
- **Fragmentation is not complete.** Employee 3 (*Radha, Delhi*) is in neither fragment, so the `UNION ALL` returns **9 rows, not 10**. A correct horizontal fragmentation must be *complete* and *reconstructable*. Fix (optional, not in your source): add `CREATE TABLE Emp_Delhi AS SELECT * FROM Employee WHERE city='Delhi';` and union all three. I have **not** changed your code.
- **Replication here is a one-time copy**, not MySQL's real master-slave replication (binary logs, `CHANGE REPLICATION SOURCE TO`, `START REPLICA`). Later changes in `masterr` will not reach `Slavee`. Describe it as "simulated replication".

## Viva questions
1. **Horizontal vs vertical fragmentation?** Horizontal splits rows; vertical splits columns (each keeps the primary key).
2. **Three rules of fragmentation?** Completeness, reconstruction, disjointness.
3. **Why UNION ALL, not UNION?** Fragments are disjoint, so no de-duplication is needed; it is faster.
4. **What is replication?** Keeping copies of data on multiple sites for availability and speed.
5. **What does real MySQL replication use?** The source's binary log, replayed by a replica's I/O and SQL threads.

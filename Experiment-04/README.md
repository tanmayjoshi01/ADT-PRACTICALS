# Experiment 4 - Implementation of Temporal Data Storage and Retrieval in MySQL

**Syllabus module:** 2 - Advanced Database Systems (item 2)  
**Source:** `Exp4_Temporal_Databases.docx` (15 output screenshots inside the file)  
**Validation:** NOT EXECUTED - reviewed only. **2 corrections** (typos `101ORDER BY` and `ND Valid_To`).

## Aim
Store versions of a customer record with valid time and transaction time, and retrieve current, historical and "as-of-date" data.

## Required software
MySQL 8 + Workbench.

## How to run
```bash
mysql -u root -p < code.sql
```

## Expected output (derived by hand - compare with your screenshots)
- After step 2: 1 row (Pune). After step 3: 2 rows - Pune (`Valid_To 2024-12-31`, `Transaction_End` set) and Mumbai (`9999-12-31`, `Transaction_End NULL`).
- Steps 4, 9, practice 1 and 5: only the Mumbai row.
- Step 6: 15-Jun-2024 -> Pune; 10-Feb-2025 -> Mumbai. Practice 2 (15-Aug-2024) -> Pune.
- Practice 4: `101 | 2`.

## Observations
- Rows are never overwritten; an update = close old row + insert new row.
- `9999-12-31` is a sentinel meaning "still valid".
- Transaction timestamps depend on when you ran the script, so yours will differ.

## Viva questions
1. **Valid time vs transaction time?** Valid time = when a fact is true in reality; transaction time = when the database knew/stored it.
2. **What is a bi-temporal table?** One that stores both.
3. **Why is the primary key (Customer_ID, Valid_From)?** One customer can have many versions, each starting on a different date.
4. **Why not just UPDATE the address?** History would be lost.
5. **How do you find the version valid on a date?** `date BETWEEN Valid_From AND Valid_To`.

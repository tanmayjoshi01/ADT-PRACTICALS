# Experiment 8 - Basic ETL Pipeline (CSV/SQL -> transform types -> target schema)

**Syllabus module:** 5 - ETL Process  
**Source:** `EXP_8_ETL.docx` (output screenshots are in the file)  
**Validation:** NOT EXECUTED - reviewed only. **1 correction** (`ETL_Demo;` -> `USE ETL_Demo;`).

## Aim
Extract raw data (from another MySQL table and from a CSV), transform it (trim, case, type casts, date format) and load it into a typed target schema.

## Required software
MySQL 8 + Workbench (Table Data Import Wizard). `students.csv` is included in this folder.

## Procedure
Method 1: source table -> target table via one `INSERT ... SELECT`. Method 2: CSV -> `student_staging` (import wizard) -> transform -> `student_target` -> validate.

## How to run
Run `code.sql` in Workbench. When you reach PART C, **pause** and import `students.csv` with the wizard, then continue. (`LOAD DATA INFILE` is an alternative but is not used in your source.)

## Expected output (derived)
- Method 1 target: `E101 RAHUL 45000.00 IT`, `E102 PRIYA 55000.00 HR`, `E103 AMIT 60000.00 IT`.
- Method 2 target: 5 rows, names/departments upper-case, dates like `2025-06-15`.
- Marks > 80: 101, 102, 104, 105. IT students: 101, 102, 104. Average marks: 86.60. Counts: IT 3, CSE 2.

## Observations
- The source's procedure text calls the staging table `Source` ("`SELECT * FROM Source;`") but the code uses `student_staging` - code kept.
- Staging tables use VARCHAR so dirty data loads without errors; casting happens in the load step.
- Lowercase `it` and uppercase `IT` in the CSV only match in `WHERE Department='IT'` because `UPPER()` was applied during transform.

## Viva questions
1. **Expand ETL.** Extract, Transform, Load.
2. **Why a staging table?** Holds raw data safely before cleaning and validation.
3. **What does `STR_TO_DATE` do?** Converts text to DATE using a format string (`%d-%m-%Y`).
4. **Immediate vs deferred extraction?** Immediate captures changes in real time (triggers/logs); deferred captures them later (timestamps, file comparison).
5. **Name some ETL tools.** Talend, Informatica, SSIS, Pentaho.

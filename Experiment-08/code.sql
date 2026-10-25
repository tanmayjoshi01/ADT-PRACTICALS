-- =====================================================================
-- Experiment 8: Basic ETL pipeline (Extract -> Transform -> Load) in MySQL
-- Source : EXP_8_ETL.docx  (Method 1: table-to-table, Method 2: CSV file)
-- Status : NOT EXECUTED - syntax and logic reviewed only
-- [CORRECTION] marks the one invalid statement in the source.
-- =====================================================================

-- ################### METHOD 1: extract from another MySQL table ###################
CREATE DATABASE IF NOT EXISTS Companyy_db;
USE Companyy_db;

-- Source table: everything is VARCHAR and "dirty" (spaces, lowercase).
CREATE TABLE employee_source1 (
    Emp_ID VARCHAR(10),
    Emp_Name VARCHAR(100),
    Salary VARCHAR(20),
    Department VARCHAR(50)
);

-- Insert raw data (note the extra spaces and lowercase values).
INSERT INTO employee_source1 VALUES
('E101',' rahul ','45000','it'),
('E102',' priya ','55000','hr'),
('E103',' amit ','60000','it');

-- Verify the extracted data.
select * from employee_source1;

-- Target table with proper data types (Salary becomes DECIMAL).
CREATE TABLE employee_target1 (
    Emp_ID VARCHAR(10),
    Emp_Name VARCHAR(100),
    Salary DECIMAL(10,2),
    Department VARCHAR(50)
);

-- ETL in one statement: SELECT = extract, functions = transform, INSERT = load.
--   TRIM  removes leading/trailing spaces, UPPER makes capitals,
--   CAST  changes the data type.
INSERT INTO employee_target1
SELECT
    TRIM(Emp_ID),
    UPPER(TRIM(Emp_Name)),
    CAST(Salary AS DECIMAL(10,2)),
    UPPER(TRIM(Department))
FROM employee_source1;

-- Verify: names like 'RAHUL', salary 45000.00, dept 'IT'.
SELECT * FROM employee_target1;

-- ################### METHOD 2: extract from a CSV file ###################
-- PART A: the CSV file is students.csv (in this folder; the source saves it as
--         C:\ETL\students.csv). Dates are dd-mm-yyyy and some text is lowercase.

-- PART B: create source database
CREATE DATABASE ETL_Demo;
USE ETL_Demo;

-- Staging table: raw text only, so the import never fails on data types.
CREATE TABLE student_staging (
    Student_ID VARCHAR(20),
    Name VARCHAR(100),
    Age VARCHAR(10),
    Department VARCHAR(20),
    Marks VARCHAR(20),
    Admission_Date VARCHAR(30)
);

-- PART C: EXTRACT - import students.csv into student_staging using the
--   Workbench Table Data Import Wizard (right-click table > Table Data
--   Import Wizard > choose students.csv > map columns > Import).
-- Original text:   ETL_Demo;
-- [CORRECTION] "ETL_Demo;" alone is not valid SQL; it should be USE ETL_Demo;
USE ETL_Demo;
SELECT * FROM student_staging;

-- PART D: TRANSFORM
-- Target table with proper types (INT, DECIMAL, DATE).
CREATE TABLE student_target (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Department VARCHAR(20),
    Marks DECIMAL(5,2),
    Admission_Date DATE
);

-- Trial transformations, one column at a time:
SELECT UPPER(Name) AS Name FROM student_staging;                  -- Step 6
SELECT UPPER(Department) AS Department FROM student_staging;      -- Step 7
SELECT CAST(Age AS UNSIGNED) AS Age FROM student_staging;         -- Step 8
SELECT CAST(Marks AS DECIMAL(5,2)) AS Marks FROM student_staging; -- Step 9 (85 -> 85.00)
-- Step 10: 15-06-2025 (dd-mm-yyyy) -> 2025-06-15 (MySQL DATE format)
SELECT STR_TO_DATE(Admission_Date, '%d-%m-%Y') AS Admission_Date FROM student_staging;

-- PART E: LOAD - all transformations combined (the key statement).
INSERT INTO student_target
(
    Student_ID,
    Name,
    Age,
    Department,
    Marks,
    Admission_Date
)
SELECT
    CAST(Student_ID AS UNSIGNED),
    UPPER(TRIM(Name)),
    CAST(Age AS UNSIGNED),
    UPPER(TRIM(Department)),
    CAST(Marks AS DECIMAL(5,2)),
    STR_TO_DATE(Admission_Date, '%d-%m-%Y')
FROM student_staging;

-- Step 12: verify the loaded data.
SELECT * FROM student_target;

-- Step 13: data validation queries
SELECT * FROM student_target WHERE Marks > 80;                    -- students above 80
SELECT * FROM student_target WHERE Department = 'IT';             -- IT students
SELECT AVG(Marks) AS Average_Marks FROM student_target;           -- average marks
SELECT Department, COUNT(*) AS Total_Students
FROM student_target GROUP BY Department;                          -- count per department

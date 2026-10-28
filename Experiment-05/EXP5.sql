-- =====================================================================
-- Experiment 5: Fragmentation and Replication in MySQL
-- Source : exp5adt.docx (Fragmentation steps 1-9, Replication steps 1-4)
-- Status : NOT EXECUTED - syntax and logic reviewed only
-- Original code is unchanged. Observations are in the README.
-- =====================================================================

-- ============ PART 1: HORIZONTAL FRAGMENTATION (master DB) ============
-- Step 1: Master database.
create database masterr;
use masterr;

-- Step 2: Global (un-fragmented) Employee table.
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(50),
    salary INT,
    city VARCHAR(50)
);

-- Step 3: Insert 10 records.
INSERT INTO Employee VALUES
(1, 'Ayan', 'IT', 40000, 'Pune'),
(2, 'Parth', 'HR', 35000, 'Mumbai'),
(3, 'Radha', 'IT', 50000, 'Delhi'),
(4, 'Siya', 'Sales', 45000, 'Mumbai'),
(5, 'Ankush', 'HR', 38000, 'Pune'),
(6, 'Priya', 'IT', 55000, 'Mumbai'),
(7, 'Roshan', 'Sales', 42000, 'Mumbai'),
(8, 'Bhushan', 'IT', 85000, 'Mumbai'),
(9, 'Sonal', 'IT', 78000, 'Pune'),
(10, 'Sanket', 'HR', 23400, 'Pune');

-- Step 4: Display all 10 rows.
SELECT * FROM Employee;

-- Step 5: Fragment 1 - only rows where city = 'Pune'
--         (CREATE TABLE ... AS SELECT copies structure + selected rows).
CREATE TABLE Emp_Pune AS
SELECT * FROM Employee
WHERE city = 'Pune';

-- Step 6: Show fragment 1 (expected ids 1, 5, 9, 10).
SELECT * FROM Emp_Pune;

-- Step 7: Fragment 2 - only rows where city = 'Mumbai'.
CREATE TABLE Emp_Mumbai AS
SELECT * FROM Employee
WHERE city = 'Mumbai';

-- Step 8: Show fragment 2 (expected ids 2, 4, 6, 7, 8).
SELECT * FROM Emp_Mumbai;

-- Step 9: Reconstruct the global table: UNION ALL joins fragments
--         (keeps duplicates, faster than UNION). Returns 9 rows - see README.
SELECT * FROM Emp_Pune
UNION ALL
SELECT * FROM Emp_Mumbai;

-- ============ PART 2: REPLICATION (copy to a "slave" DB) ============
-- Step 1: Second database acting as the replica.
CREATE DATABASE Slavee;
USE Slavee;

-- Step 2: Same structure as the master table.
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(50),
    salary INT,
    city VARCHAR(50)
);

-- Step 3: Copy all master rows into the replica (database.table notation
--         lets one statement read masterr and write Slavee).
INSERT INTO Slavee.Employee
SELECT * FROM masterr.Employee;

-- Step 4: Verify the replica has the same 10 rows.
SELECT * FROM Employee;

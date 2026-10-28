-- =====================================================================
-- Experiment 1: MySQL Database Creation, Table Creation and Complex
--               Querying to Analyze Execution Plans
-- Source : Experiment_NO_1_DATABASE.docx (items 1-22, original order)
-- Status : NOT EXECUTED - syntax and logic reviewed only
-- Needs  : MySQL 8.0.18+ (for EXPLAIN ANALYZE in item 21-22)
-- =====================================================================

-- ---------- 1) Create Database and Tables ----------
-- Step 1: Create a new database for this practical.
DROP DATABASE techworld;
CREATE DATABASE techworld;

-- Step 2: Select it so every following statement runs inside techworld.
USE techworld;

-- Step 3: Parent table. DeptID is the PRIMARY KEY (unique, not NULL).
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);

-- Step 4: Child table. DeptID here is a FOREIGN KEY, so an employee can
--         only belong to a department that exists in Department.
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    DeptID INT,
    Designation VARCHAR(50),
    Salary INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- ---------- 2) Insert records ----------
-- Parent rows must be inserted FIRST (foreign-key rule).
INSERT INTO Department VALUES
(201, 'Development', 'Mumbai'),
(202, 'HR', 'Pune'),
(203, 'Sales', 'Delhi'),
(204, 'Finance', 'Bangalore'),
(205, 'Marketing', 'Hyderabad');

INSERT INTO Employee VALUES
(1, 'Arjun', 201, 'Software Engineer', 52000),
(2, 'Meera', 202, 'HR Manager', 47000),
(3, 'Vikram', 201, 'Developer', 65000),
(4, 'Kavya', 203, 'Sales Executive', 42000),
(5, 'Rohan', 204, 'Accountant', 57000),
(6, 'Ananya', 205, 'Marketing Executive', 49000),
(7, 'Sahil', 201, 'Tester', 38000);

-- ---------- 3) Display Department table ----------
SELECT * FROM Department;

-- ---------- 4) Display Employee table ----------
SELECT * FROM Employee;

-- ---------- 5) Employees with salary > 50000 (WHERE filters rows) ----------
SELECT * FROM Employee
WHERE Salary > 50000;

-- ---------- 6) Employees in Development department (DeptID 201) ----------
SELECT * FROM Employee
WHERE DeptID = 201;

-- ---------- 7) EXPLAIN: shows the execution plan WITHOUT running the query ----------
-- Look at: type (ALL = full table scan), rows (estimate), key (index used).
EXPLAIN SELECT * FROM Employee;

-- ---------- 8) Update salary: +5000 for everyone in Development ----------
UPDATE Employee
SET Salary = Salary + 5000
WHERE DeptID = 201;

-- ---------- 9) Delete employee with EmpID 7 ----------
DELETE FROM Employee
WHERE EmpID = 7;

-- ---------- 10) ORDER BY: highest salary first ----------
SELECT * FROM Employee
ORDER BY Salary DESC;

-- ================= Aggregate Functions =================
-- ---------- 11) SUM: total salary of all employees ----------
SELECT SUM(Salary)
FROM Employee;

-- ---------- 12) AVG: average salary ----------
SELECT AVG(Salary)
FROM Employee;

-- ---------- 13) MAX: highest salary ----------
SELECT MAX(Salary)
FROM Employee;

-- ================= GROUP BY Queries =================
-- ---------- 14) Total salary department-wise (one row per DeptID) ----------
SELECT DeptID,
       SUM(Salary) AS TotalSalary
FROM Employee
GROUP BY DeptID;

-- ---------- 15) Average salary department-wise ----------
SELECT DeptID,
       AVG(Salary) AS AverageSalary
FROM Employee
GROUP BY DeptID;

-- ================= JOIN Queries =================
-- ---------- 16) INNER JOIN: only employees that have a matching department ----------
SELECT e.EmpID, e.Name, d.DeptName,
       e.Designation, e.Salary
FROM Employee e
INNER JOIN Department d
ON e.DeptID = d.DeptID;

-- ---------- 17) LEFT JOIN: ALL employees, department data if present ----------
SELECT e.EmpID, e.Name, d.DeptName,
       d.Location
FROM Employee e
LEFT JOIN Department d
ON e.DeptID = d.DeptID;

-- ---------- 18) RIGHT JOIN: ALL departments, even those with no employee ----------
SELECT e.Name, d.DeptName,
       d.Location
FROM Employee e
RIGHT JOIN Department d
ON e.DeptID = d.DeptID;

-- ================= Nested Queries (subqueries) =================
-- ---------- 19) Employees earning more than the average salary ----------
-- The inner query runs first and returns one number (the average).
SELECT * FROM Employee
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
);

-- ---------- 20) Employees of the 'Development' department ----------
-- '=' is safe here because the subquery returns exactly one DeptID (201).
SELECT * FROM Employee
WHERE DeptID = (
    SELECT DeptID
    FROM Department
    WHERE DeptName = 'Development'
);

-- ---------- 21) Execution plan vs. actual execution (Employee) ----------
-- EXPLAIN         = estimated plan only.
-- EXPLAIN ANALYZE = actually runs the query and reports real timings/rows.
EXPLAIN SELECT * FROM Employee;

EXPLAIN ANALYZE
SELECT * FROM Employee;

-- ---------- 22) Same comparison for Department ----------
EXPLAIN SELECT * FROM Department;

EXPLAIN ANALYZE
SELECT * FROM Department;

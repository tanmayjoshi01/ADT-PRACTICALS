-- Experiment 6: Horizontal fragmentation + replication simulation
DROP DATABASE IF EXISTS CompanyDist;
CREATE DATABASE CompanyDist;
USE CompanyDist;

CREATE TABLE Employee (
    id      INT PRIMARY KEY,
    name    VARCHAR(50),
    address VARCHAR(50),
    salary  INT
);
INSERT INTO Employee VALUES
(1,'Amit','Pune',50000),(2,'Neha','Mumbai',60000),(3,'Rahul','Pune',45000),
(4,'Sneha','Mumbai',55000),(5,'Karan','Pune',48000);

-- Horizontal fragments by city
CREATE TABLE Emp_Pune   AS SELECT * FROM Employee WHERE address = 'Pune';
CREATE TABLE Emp_Mumbai AS SELECT * FROM Employee WHERE address = 'Mumbai';
SELECT * FROM Emp_Pune;
SELECT * FROM Emp_Mumbai;

-- Reconstruct the original table
SELECT * FROM Emp_Pune UNION ALL SELECT * FROM Emp_Mumbai ORDER BY id;

-- Replication simulation: primary and replica databases
DROP DATABASE IF EXISTS PrimaryDB;  CREATE DATABASE PrimaryDB;
DROP DATABASE IF EXISTS ReplicaDB;  CREATE DATABASE ReplicaDB;

CREATE TABLE PrimaryDB.Employee LIKE CompanyDist.Employee;
INSERT INTO PrimaryDB.Employee SELECT * FROM CompanyDist.Employee;

CREATE TABLE ReplicaDB.Employee LIKE PrimaryDB.Employee;
INSERT INTO ReplicaDB.Employee SELECT * FROM PrimaryDB.Employee;   -- initial sync

-- Change on primary, then synchronize
INSERT INTO PrimaryDB.Employee VALUES (6,'Pooja','Pune',52000);
UPDATE PrimaryDB.Employee SET salary = 65000 WHERE id = 2;

REPLACE INTO ReplicaDB.Employee SELECT * FROM PrimaryDB.Employee;  -- sync inserts/updates
DELETE FROM ReplicaDB.Employee WHERE id NOT IN (SELECT id FROM PrimaryDB.Employee);

SELECT * FROM PrimaryDB.Employee;
SELECT * FROM ReplicaDB.Employee;

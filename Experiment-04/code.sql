-- =====================================================================
-- Experiment 4: Implementation of Temporal Data Storage and Retrieval in MySQL
-- Source : Exp4_Temporal_Databases.docx (steps 1-9 + 5 practice queries)
-- Status : NOT EXECUTED - syntax and logic reviewed only
-- Two typing errors in the source are fixed and marked [CORRECTION].
-- Idea   : a BI-TEMPORAL table keeps every version of a row.
--   Valid time       (Valid_From, Valid_To)            = when the fact is true in the real world
--   Transaction time (Transaction_Start/End)           = when the row was stored in the database
-- =====================================================================

-- Database Creation
CREATE DATABASE TemporalDB1;
USE TemporalDB1;

-- Step 1: Temporal table. The primary key is (Customer_ID, Valid_From) so the
--         same customer can have many versions, one per validity period.
CREATE TABLE Customer_Temporal
(
    Customer_ID INT,
    Customer_Name VARCHAR(100),
    Address VARCHAR(100),
    Phone VARCHAR(15),
    Valid_From DATE,
    Valid_To DATE,                                     -- 9999-12-31 = "until further notice"
    Transaction_Start TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Transaction_End TIMESTAMP NULL,                    -- NULL = row is still the active version
    PRIMARY KEY(Customer_ID, Valid_From)
);

-- Step 2: Insert the initial record (customer lives in Pune from 2024-01-01).
INSERT INTO Customer_Temporal VALUES
(101,'Amit Sharma','Pune','9876543210','2024-01-01','9999-12-31',CURRENT_TIMESTAMP,NULL);

-- Table after insertion
Select * from Customer_Temporal;

-- Step 3: On 1-Jan-2025 the customer moves to Mumbai. Never overwrite - version it.
-- 3a: Close the previous record (end its validity and its transaction time).
UPDATE Customer_Temporal SET Valid_To='2024-12-31',
Transaction_End=CURRENT_TIMESTAMP WHERE Customer_ID=101 AND Valid_To='9999-12-31';

-- 3b: Insert the new version.
INSERT INTO Customer_Temporal
(
Customer_ID,Customer_Name,Address,Phone,Valid_From,Valid_To,
Transaction_Start,
Transaction_End)VALUES(101,'Amit Sharma','Mumbai','9876543210','2025-01-01','9999-12-31',CURRENT_TIMESTAMP,NULL);

-- Table after update (2 rows: Pune closed, Mumbai open)
Select * from Customer_Temporal;

-- Step 4: Retrieve the current record (open-ended validity).
SELECT * FROM Customer_Temporal WHERE Valid_To='9999-12-31';

-- Step 5: Complete history of customer 101, oldest first.
-- Original: ...Customer_ID=101ORDER BY Valid_From;
-- [CORRECTION] space added before ORDER BY.
SELECT * FROM Customer_Temporal WHERE Customer_ID=101 ORDER BY Valid_From;

-- Step 6: "As of" queries - which version was valid on a given date?
-- Address on 15-June-2024 (expected: Pune)
-- Original: ... BETWEEN Valid_From ND Valid_To;
-- [CORRECTION] ND -> AND.
SELECT * FROM Customer_Temporal WHERE '2024-06-15' BETWEEN Valid_From AND Valid_To;
-- Address on 10-Feb-2025 (expected: Mumbai)
SELECT * FROM Customer_Temporal WHERE '2025-02-10' BETWEEN Valid_From AND Valid_To;

-- Step 7: Valid-time information.
SELECT Customer_Name,Address,Valid_From,Valid_To FROM Customer_Temporal ORDER BY Valid_From;

-- Step 8: Transaction-time information (when rows were recorded/closed).
SELECT Customer_ID,Transaction_Start, Transaction_End FROM Customer_Temporal;

-- Step 9: Active records = not yet superseded in the database.
SELECT * FROM Customer_Temporal WHERE Transaction_End IS NULL;

-- ================= Sample queries for practice =================
-- 1. Current customers
SELECT * FROM Customer_Temporal WHERE Transaction_End IS NULL;
-- 2. Customer details valid on a given date
SELECT * FROM Customer_Temporal WHERE '2024-08-15' BETWEEN Valid_From AND Valid_To;
-- 3. Complete address history
SELECT Customer_ID,Address,Valid_From, Valid_To FROM Customer_Temporal ORDER BY Customer_ID, Valid_From;
-- 4. Count record versions per customer (expected 2 for customer 101)
SELECT Customer_ID,COUNT(*) AS Versions FROM Customer_Temporal GROUP BY Customer_ID;
-- 5. Current addresses
SELECT Customer_Name, Address FROM Customer_Temporal WHERE Valid_To='9999-12-31';

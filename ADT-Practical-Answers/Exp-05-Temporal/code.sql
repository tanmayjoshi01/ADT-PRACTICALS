-- Experiment 5: Bitemporal Customer History
-- (Valid Time + Transaction Time)

DROP DATABASE IF EXISTS TemporalDB;
CREATE DATABASE TemporalDB;
USE TemporalDB;

-- Create Customer table
CREATE TABLE Customer (
    id                INT,
    name              VARCHAR(50),
    address           VARCHAR(100),
    valid_from        DATE,
    valid_to          DATE,
    Transaction_start DATETIME,
    Transaction_end   DATETIME
);

-- 1) Insert 5 records and display all records
INSERT INTO Customer VALUES
(1, 'Amit',  'Pune',      '2020-01-01', '2021-12-31',
 '2020-01-01 10:00:00', '9999-12-31 00:00:00'),

(2, 'Neha',  'Mumbai',    '2021-01-01', '9999-12-31',
 '2021-01-01 10:00:00', '9999-12-31 00:00:00'),

(3, 'Rohit', 'Nashik',    '2019-06-01', '2022-05-31',
 '2019-06-01 10:00:00', '9999-12-31 00:00:00'),

(4, 'Sneha', 'Ratnagiri', '2022-01-01', '9999-12-31',
 '2022-01-01 10:00:00', '9999-12-31 00:00:00'),

(5, 'Karan', 'Nagpur',    '2018-03-01', '9999-12-31',
 '2018-03-01 10:00:00', '9999-12-31 00:00:00');

SELECT * FROM Customer;


-- 2) Retrieve records valid on a particular date
SELECT *
FROM Customer
WHERE '2021-06-15' BETWEEN valid_from AND valid_to;


-- 3) Retrieve currently valid records using valid time
SELECT *
FROM Customer
WHERE valid_to = '9999-12-31';


-- 4) Retrieve records currently active in the database
SELECT id, name, Transaction_start, Transaction_end
FROM Customer
WHERE Transaction_end = '9999-12-31 00:00:00';


-- 5) Change address of customer 1
-- Close the old record
UPDATE Customer
SET valid_to = CURDATE() - INTERVAL 1 DAY,
    Transaction_end = NOW()
WHERE id = 1
  AND Transaction_end = '9999-12-31 00:00:00';

-- Insert the new record
INSERT INTO Customer VALUES
(1, 'Amit', 'Mumbai', CURDATE(), '9999-12-31',
 NOW(), '9999-12-31 00:00:00');

-- Display customer history
SELECT *
FROM Customer
WHERE id = 1
ORDER BY Transaction_start;

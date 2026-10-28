-- Experiment 9: Basic ETL pipeline in MySQL
DROP DATABASE IF EXISTS ETLDB;
CREATE DATABASE ETLDB;
USE ETLDB;

-- EXTRACT: raw source table (dirty data, salary as VARCHAR)
CREATE TABLE employee_source1 (
    id INT, name VARCHAR(50), salary VARCHAR(20), department VARCHAR(50)
);
INSERT INTO employee_source1 VALUES
(1,'  amit  ','50000.50','  it '),
(2,' neha','60000','hr  '),
(3,'rahul   ','45000.75',' sales'),
(4,'  sneha ','55000','finance '),
(5,'karan','48000.25','  it');

-- Target table
CREATE TABLE employee_target (
    id INT PRIMARY KEY, name VARCHAR(50), salary DECIMAL(10,2), department VARCHAR(50)
);

-- TRANSFORM + LOAD
INSERT INTO employee_target
SELECT id, UPPER(TRIM(name)), CAST(salary AS DECIMAL(10,2)), UPPER(TRIM(department))
FROM employee_source1;

-- Verify
SELECT * FROM employee_source1;
SELECT * FROM employee_target;
SELECT (SELECT COUNT(*) FROM employee_source1) AS src_rows,
       (SELECT COUNT(*) FROM employee_target)  AS tgt_rows;
SELECT COUNT(*) AS untrimmed_or_lowercase
FROM employee_target
WHERE name <> UPPER(TRIM(name)) OR department <> UPPER(TRIM(department));

-- Experiment 1: MySQL database with 2 tables, complex querying, execution plans
DROP DATABASE IF EXISTS CompanyDB;
CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Department (
    dept_id   INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location  VARCHAR(50)
);

CREATE TABLE Employee (
    emp_id      INT PRIMARY KEY,
    emp_name    VARCHAR(50) NOT NULL,
    dept_id     INT,
    designation VARCHAR(50),
    salary      INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

INSERT INTO Department VALUES
(1,'Development','Pune'),(2,'HR','Mumbai'),(3,'Sales','Delhi'),
(4,'Finance','Bangalore'),(5,'Marketing','Hyderabad');

INSERT INTO Employee VALUES
(101,'Arjun',1,'Software Engineer',52000),
(102,'Meera',2,'HR Manager',47000),
(103,'Vikram',1,'Developer',65000),
(104,'Kavya',3,'Sales Executive',42000),
(105,'Rohan',4,'Accountant',57000),
(106,'Ananya',5,'Marketing Executive',49000),
(107,'Sahil',1,'Tester',38000);

-- Complex queries
SELECT * FROM Employee WHERE salary > 50000;

SELECT d.dept_name, COUNT(*) AS emp_count, SUM(e.salary) AS total_salary,
       AVG(e.salary) AS avg_salary
FROM Employee e JOIN Department d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 45000
ORDER BY total_salary DESC;

SELECT d.dept_name, e.emp_name
FROM Department d LEFT JOIN Employee e ON d.dept_id = e.dept_id;

-- Nested query: employees earning above average
SELECT emp_name, salary FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);

-- Correlated: highest paid employee in each department
SELECT e.emp_name, e.dept_id, e.salary FROM Employee e
WHERE e.salary = (SELECT MAX(salary) FROM Employee WHERE dept_id = e.dept_id);

-- Execution plans
EXPLAIN SELECT * FROM Employee WHERE salary > 50000;                 -- full scan (type=ALL)
EXPLAIN SELECT * FROM Employee WHERE emp_id = 103;                   -- type=const (primary key)
EXPLAIN SELECT e.emp_name, d.dept_name
        FROM Employee e JOIN Department d ON e.dept_id = d.dept_id;  -- join plan

-- Add an index and compare plans
CREATE INDEX idx_salary ON Employee(salary);
EXPLAIN SELECT * FROM Employee WHERE salary > 50000;                 -- now can use idx_salary
EXPLAIN FORMAT=TREE SELECT * FROM Employee WHERE salary > 50000;
EXPLAIN ANALYZE SELECT e.emp_name, d.dept_name
        FROM Employee e JOIN Department d ON e.dept_id = d.dept_id;  -- actual timings (8.0.18+)

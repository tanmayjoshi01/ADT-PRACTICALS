-- =====================================================================
-- Experiment 10: Cassandra - Table Operations, CRUD and CQL Types
-- Source : adt_EXP_10.docx (text for steps; employee rows 2-5 and the two
--          UPDATEs were read from screenshots - verify the digits)
-- Environment: Killercoda (Docker) -> see the shell commands in the README
-- Status : NOT EXECUTED - syntax and logic reviewed only
-- [CORRECTION] marks the one statement with a typing error.
-- =====================================================================

-- ---------- Keyspace ----------
DESCRIBE KEYSPACES;                      -- list existing keyspaces

-- A keyspace is like a database. SimpleStrategy + factor 1 = one copy of data
-- (fine for a single-node practical).
CREATE KEYSPACE b3 WITH replication = {
    'class': 'SimpleStrategy',
    'replication_factor': 1
};
DESCRIBE KEYSPACES;                      -- b3 is now listed
USE b3;                                  -- select it

-- ======================= TABLE OPERATIONS =======================
-- Step 1: Create a table. PRIMARY KEY (roll_no) = partition key.
CREATE TABLE students (
    roll_no INT PRIMARY KEY,
    name TEXT,
    department TEXT,
    age INT,
    city TEXT,
    percentage DECIMAL
);
DESCRIBE students;                       -- table structure
DESCRIBE TABLES;                         -- all tables in the keyspace

-- Step 2: Alter - add a column.
ALTER TABLE students ADD email TEXT;
DESCRIBE students;

-- Step 3: Truncate - delete all rows, keep the table.
TRUNCATE students;

-- Step 5 (numbered so in the source): Drop - removes table AND data.
DROP TABLE students;

-- ======================= CRUD OPERATIONS =======================
-- Recreate the table (it was dropped above).
CREATE TABLE students (
    roll_no INT PRIMARY KEY,
    name TEXT,
    department TEXT,
    age INT,
    city TEXT,
    percentage DECIMAL
);

-- C - CREATE (INSERT)
INSERT INTO students
(roll_no, name, department, age, city, percentage) VALUES
(101, 'Amit', 'IT', 20, 'Mumbai', 85.50);
INSERT INTO students
(roll_no, name, department, age, city, percentage) VALUES
(102, 'Priya', 'CSE', 21, 'Pune', 91.20);
INSERT INTO students
(roll_no, name, department, age, city, percentage) VALUES
(103, 'Rahul', 'IT', 20, 'Ratnagiri', 78.75);
INSERT INTO students
(roll_no, name, department, age, city, percentage) VALUES
(104, 'Sneha', 'ENTC', 21, 'Nashik', 88.40);

-- R - READ (SELECT)
SELECT * FROM students;                                  -- all rows
SELECT roll_no, name, department FROM students;          -- chosen columns
SELECT * FROM students WHERE roll_no = 101;              -- by primary key

-- U - UPDATE
UPDATE students SET city = 'Thane' WHERE roll_no = 101;
UPDATE students SET age = 21,
    percentage = 87.25 WHERE roll_no = 101;              -- several columns
SELECT * FROM students WHERE roll_no = 101;              -- verify

-- D - DELETE
DELETE FROM students WHERE roll_no = 104;                -- whole row
-- Original: DELETE cityFROM studentsWHERE roll_no = 103;   (missing spaces)
-- [CORRECTION] spaces restored. This removes only the city value of row 103.
DELETE city FROM students WHERE roll_no = 103;
SELECT * FROM students;                                  -- verify

-- ======================= CQL DATA TYPES =======================
-- Collections: LIST (ordered, duplicates allowed), SET (unique values),
-- MAP (key-value pairs).
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name TEXT,
    salary DECIMAL,
    joining_date DATE,
    active BOOLEAN,
    skills SET<TEXT>,
    phone_numbers LIST<TEXT>,
    address MAP<TEXT, TEXT>
);

INSERT INTO employee
(emp_id, emp_name, salary, joining_date, active, skills, phone_numbers, address)
VALUES
(1, 'Raj', 65000.50, '2026-01-15', true,
 {'Java', 'Cassandra', 'Python'},
 ['9876543210', '9123456780'],
 {'city': 'Mumbai', 'state': 'Maharashtra'});

SELECT * FROM employee;

-- Second record (read from screenshot)
INSERT INTO employee
(emp_id, emp_name, salary, joining_date, active, skills, phone_numbers, address)
VALUES
(2, 'Priya', 72000.75, '2026-02-10', true,
 {'Python', 'SQL', 'C++'},
 ['9988776655', '9001122334'],
 {'city': 'Pune', 'state': 'Maharashtra'});
SELECT * FROM employee;

-- Display one employee
SELECT * FROM employee WHERE emp_id = 1;

-- Add an element to a SET (+) and to a LIST (+)
UPDATE employee
SET skills = skills + {'MongoDB'}
WHERE emp_id = 1;
UPDATE employee
SET phone_numbers = phone_numbers + ['9988776655']
WHERE emp_id = 1;
SELECT * FROM employee;

-- Insert 3 more records (read from screenshot)
INSERT INTO employee
(emp_id, emp_name, salary, joining_date, active, skills, phone_numbers, address)
VALUES
(3, 'Amit', 58000.25, '2026-03-05', true,
 {'Java', 'HTML', 'CSS'},
 ['9876501234', '9012345678'],
 {'city': 'Nashik', 'state': 'Maharashtra'});
INSERT INTO employee
(emp_id, emp_name, salary, joining_date, active, skills, phone_numbers, address)
VALUES
(4, 'Sneha', 80000.00, '2026-04-20', false,
 {'Cassandra', 'Java', 'SQL'},
 ['9898989898', '9112233445'],
 {'city': 'Bangalore', 'state': 'Karnataka'});
INSERT INTO employee
(emp_id, emp_name, salary, joining_date, active, skills, phone_numbers, address)
VALUES
(5, 'Rohan', 60000.50, '2026-05-12', true,
 {'Python', 'JavaScript', 'React'},
 ['9765432109', '9345678901'],
 {'city': 'Goa', 'state': 'Goa'});
SELECT * FROM employee;

-- =====================================================================
-- Experiment 7: Star Schema (Sales Data Warehouse) and OLAP Operations
-- Source : Experiment_7_Star_snowflake_Schema_OLAP_Opeations_-_Copy.docx
-- Status : NOT EXECUTED - syntax and logic reviewed only
-- The source implements the STAR schema only (no snowflake tables).
-- [CORRECTION] marks the one query that fails on default MySQL settings.
-- =====================================================================

-- Step 1: Data-warehouse database.
CREATE DATABASE sales_dw;
USE sales_dw;

-- ---------- Dimension tables (descriptive context) ----------
-- A. Time dimension
CREATE TABLE dim_time (
    time_id INT PRIMARY KEY,
    date_value DATE,
    month_name VARCHAR(20),
    quarter_name VARCHAR(10),
    year INT
);
INSERT INTO dim_time VALUES
(1, '2026-01-10', 'January',  'Q1', 2026),
(2, '2026-02-15', 'February', 'Q1', 2026),
(3, '2026-04-20', 'April',    'Q2', 2026),
(4, '2026-05-25', 'May',      'Q2', 2026),
(5, '2026-07-10', 'July',     'Q3', 2026);
SELECT * FROM dim_time;

-- B. Product dimension
CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
INSERT INTO dim_product VALUES
(101, 'Laptop',   'Electronics', 60000),
(102, 'Mobile',   'Electronics', 30000),
(103, 'Keyboard', 'Accessories', 1500),
(104, 'Mouse',    'Accessories', 800),
(105, 'Printer',  'Electronics', 15000);
SELECT * FROM dim_product;

-- C. Customer dimension
CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50)
);
INSERT INTO dim_customer VALUES
(201, 'Amit',  'Mumbai',    'Maharashtra'),
(202, 'Sneha', 'Pune',      'Maharashtra'),
(203, 'Rahul', 'Delhi',     'Delhi'),
(204, 'Priya', 'Bangalore', 'Karnataka'),
(205, 'Neha',  'Nashik',    'Maharashtra');
SELECT * FROM dim_customer;

-- D. Location dimension
CREATE TABLE dim_location (
    location_id INT PRIMARY KEY,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);
INSERT INTO dim_location VALUES
(301, 'Mumbai',    'Maharashtra', 'India'),
(302, 'Pune',      'Maharashtra', 'India'),
(303, 'Delhi',     'Delhi',       'India'),
(304, 'Bangalore', 'Karnataka',   'India'),
(305, 'Nashik',    'Maharashtra', 'India');
SELECT * FROM dim_location;

-- ---------- Fact table (measures + foreign keys to every dimension) ----------
CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    time_id INT,
    location_id INT,
    quantity INT,
    sales_amount DECIMAL(12,2),
    FOREIGN KEY (product_id)  REFERENCES dim_product(product_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (time_id)     REFERENCES dim_time(time_id),
    FOREIGN KEY (location_id) REFERENCES dim_location(location_id)
);
INSERT INTO fact_sales VALUES
(1, 101, 201, 1, 301, 2, 120000),
(2, 102, 202, 2, 302, 3, 90000),
(3, 103, 203, 3, 303, 2, 3000),
(4, 104, 204, 4, 304, 5, 4000),
(5, 105, 205, 5, 305, 2, 30000),
(6, 101, 202, 2, 302, 1, 60000),
(7, 102, 201, 3, 301, 2, 60000),
(8, 103, 205, 4, 305, 5, 7500);

-- Verify the star schema (EER diagram: Workbench > Database > Reverse Engineer).
SELECT * FROM fact_sales;

-- ======================= OLAP OPERATIONS =======================
-- A. ROLL-UP: detailed -> summarised (here: all sales -> total per year).
-- Original had no GROUP BY:
--   SELECT t.year, SUM(f.sales_amount) AS total_sales
--   FROM fact_sales f JOIN dim_time t ON f.time_id = t.time_id;
-- [CORRECTION] With default sql_mode ONLY_FULL_GROUP_BY this errors because
--   t.year is not aggregated. Add GROUP BY t.year.
SELECT t.year, SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_time t ON f.time_id = t.time_id
GROUP BY t.year;

-- B. DRILL-DOWN: summarised -> more detail (year -> month).
SELECT t.month_name, SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_time t ON f.time_id = t.time_id
GROUP BY t.month_name;

-- C. SLICE: fix ONE value of ONE dimension (year = 2026).
SELECT * FROM fact_sales f
JOIN dim_time t ON f.time_id = t.time_id
WHERE t.year = 2026;

-- D. DICE: fix values on MULTIPLE dimensions
--    (category = Electronics AND state = Maharashtra).
SELECT p.product_name, SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_product p  ON f.product_id  = p.product_id
JOIN dim_location l ON f.location_id = l.location_id
WHERE p.category = 'Electronics'
AND l.state = 'Maharashtra'
GROUP BY p.product_name;

-- E. PIVOT (as given in the source): product x month sales.
--    This returns rows, not true columns; see README for the CASE-based pivot.
SELECT p.product_name, t.month_name,
SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
JOIN dim_time t    ON f.time_id = t.time_id
GROUP BY p.product_name, t.month_name;

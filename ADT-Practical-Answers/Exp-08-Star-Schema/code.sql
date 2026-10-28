-- Experiment 8: Star schema for Sales
DROP DATABASE IF EXISTS SalesDW;
CREATE DATABASE SalesDW;
USE SalesDW;

CREATE TABLE DIM_PRODUCT  (Product_ID INT PRIMARY KEY, Product_Name VARCHAR(50), Brand VARCHAR(50));
CREATE TABLE DIM_CUSTOMER (Customer_ID INT PRIMARY KEY, Customer_Name VARCHAR(50), address VARCHAR(100));
CREATE TABLE DIM_TIME     (Time_ID INT PRIMARY KEY, `Date` DATE, `Month` INT, `Year` INT);

INSERT INTO DIM_PRODUCT VALUES (1,'Laptop','Dell'),(2,'Phone','Samsung'),(3,'Headphones','Sony');
INSERT INTO DIM_CUSTOMER VALUES (1,'Amit','Pune'),(2,'Neha','Mumbai'),(3,'Rahul','Ratnagiri');
INSERT INTO DIM_TIME VALUES (1,'2025-01-15',1,2025),(2,'2025-02-20',2,2025),(3,'2025-03-10',3,2025);

CREATE TABLE FACT_SALES (
    Sales_ID      INT PRIMARY KEY AUTO_INCREMENT,
    Product_ID    INT,
    Customer_ID   INT,
    Time_ID       INT,
    Sales_amount  DECIMAL(10,2),
    Quantity_sold INT,
    FOREIGN KEY (Product_ID)  REFERENCES DIM_PRODUCT(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES DIM_CUSTOMER(Customer_ID),
    FOREIGN KEY (Time_ID)     REFERENCES DIM_TIME(Time_ID)
);

INSERT INTO FACT_SALES (Product_ID,Customer_ID,Time_ID,Sales_amount,Quantity_sold) VALUES
(1,1,1,60000.00,1),(2,2,2,40000.00,2),(3,3,3,6000.00,3);

-- Star join query
SELECT p.Product_Name, c.Customer_Name, t.`Month`, f.Sales_amount, f.Quantity_sold
FROM FACT_SALES f
JOIN DIM_PRODUCT p  ON f.Product_ID  = p.Product_ID
JOIN DIM_CUSTOMER c ON f.Customer_ID = c.Customer_ID
JOIN DIM_TIME t     ON f.Time_ID     = t.Time_ID;

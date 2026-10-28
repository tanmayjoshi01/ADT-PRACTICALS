-- Step 1: Create Database
CREATE DATABASE AAL;
USE AAL;

-- Step 2: Create College Table
CREATE TABLE COLLEGE (
    ID INT PRIMARY KEY,
    CLGNAME VARCHAR(100),
    LOCATION POINT NOT NULL
);

-- Step 3: Insert College Locations
INSERT INTO COLLEGE (ID, CLGNAME, LOCATION) VALUES
(1, 'FINOLEX ACADEMY OF MANAGEMENT AND TECHNOLOGY',
 ST_GeomFromText('POINT(73.335696 17.011680)')),
(2, 'Government Polytechnic Ratnagiri',
 ST_GeomFromText('POINT(73.312632 16.983857)')),
(3, 'Government College of Engineering Ratnagiri',
 ST_GeomFromText('POINT(73.312804 16.984514)')),
(4, 'Gogate Joglekar College',
 ST_GeomFromText('POINT(73.299455 16.986440)')),
(5, 'Sample College',
 ST_GeomFromText('POINT(73.400000 16.620000)'));

-- 1. Display Location as Text
SELECT CLGNAME, ST_AsText(LOCATION) AS Location_Text
FROM COLLEGE;

-- 2. Find X and Y Coordinates
SELECT CLGNAME,
       ST_X(LOCATION) AS X_Coordinate,
       ST_Y(LOCATION) AS Y_Coordinate
FROM COLLEGE;

-- 3. Calculate Distance Between Two Colleges (Metres)
SELECT ST_Distance_Sphere(a.LOCATION, b.LOCATION) AS Distance_Metres
FROM COLLEGE a
JOIN COLLEGE b ON a.ID = 1 AND b.ID = 2;

-- 4. Find Colleges Near a Location (Within 5 KM)
SELECT CLGNAME,
       ROUND(ST_Distance_Sphere(
           LOCATION, POINT(73.312804, 16.984514)
       )) AS Distance_Metres
FROM COLLEGE
WHERE ST_Distance_Sphere(
    LOCATION, POINT(73.312804, 16.984514)
) <= 5000
ORDER BY Distance_Metres;

-- 5. Display Complete Information
SELECT ID, CLGNAME,
       ST_AsText(LOCATION) AS Location_Text,
       ST_X(LOCATION) AS X_Coordinate,
       ST_Y(LOCATION) AS Y_Coordinate
FROM COLLEGE;

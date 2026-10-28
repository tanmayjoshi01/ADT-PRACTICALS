-- =====================================================================
-- Experiment 3: Implementation of Spatial Data Storage and Retrieval in MySQL
-- Primary source : Exp_3_Spatial_Data_Storage_docx.pdf  (college locations,
--                  database AAL, pages 1-4 - the most complete version)
-- Status : NOT EXECUTED - syntax and logic reviewed only
-- Needs  : MySQL 8.0 (ST_Distance_Sphere, ST_Buffer, ST_Contains)
-- Marked [CORRECTION] where the original would fail.
-- =====================================================================

-- ======================= PART A: POINT data =======================
-- Step 1: Create a database.
CREATE DATABASE AAL;

-- Step 2: Select it.
USE AAL;

-- Step 3: Table with a POINT column. NOT NULL is required if you ever
--         want a SPATIAL INDEX on the column.
CREATE TABLE COLLEGE(
    ID INT PRIMARY KEY,
    CLGNAME VARCHAR(100),
    LOCATION POINT NOT NULL
);

-- Step 4: Insert spatial data. ST_GeomFromText converts WKT text to a
--         geometry. In WKT a point is POINT(x y) = POINT(longitude latitude).
INSERT INTO COLLEGE (ID, CLGNAME, LOCATION) VALUES
(1, 'FINOLEX ACADEMY OF MANAGEMENT AND TECHNOLOGY',
 ST_GeomFromText('POINT(73.3356962714195 17.011679910953386)')),
(2, 'Government Polytechnic Ratnagiri',
 ST_GeomFromText('POINT(73.31263229735558 16.98385744476506)')),
(3, 'Government College of Engineering, Ratnagiri',
 ST_GeomFromText('POINT(73.31280395871835 16.984514142502654)')),
(4, 'Gogate Joglekar College',
 ST_GeomFromText('POINT(73.29945515294067 16.986439585728345)')),
(5, 'Massachusetts Institute of Technology',
 ST_GeomFromText('POINT(-71.09424583430655 42.36010682680285)'));

-- Step 5: Display data. LOCATION shows as BLOB (internal binary format);
--         use ST_AsText() to read it (Query 1).
SELECT * FROM College;

-- ---------- Spatial Retrieval Queries ----------
-- Query 1: Show locations as readable WKT text.
SELECT CLGNAME, ST_AsText(LOCATION) FROM COLLEGE;

-- Query 2: Extract X (longitude) and Y (latitude) of each point.
SELECT CLGNAME, ST_X(LOCATION) AS Longitude, ST_Y(LOCATION) AS Latitude
FROM COLLEGE;

-- Query 3: Straight-line distance between two points.
--          The result is in coordinate units (degrees), NOT metres.
SELECT
  ST_Distance(
    ST_GeomFromText('POINT(73.3356962714195 17.011679910953386)'),
    ST_GeomFromText('POINT(73.31263229735558 16.98385744476506)')
  ) AS Distance;

-- Query 4: Distance on the Earth's surface in METRES (great-circle).
--          Arguments must be (longitude latitude).
SELECT
  ST_Distance_Sphere(
    ST_GeomFromText('POINT(73.3356962714195 17.011679910953386)'),
    ST_GeomFromText('POINT(73.31263229735558 16.98385744476506)')
  ) AS DistanceInMeters;

-- Query 5: Colleges inside a region. First build a polygon (rectangle,
--          first and last point must be identical to close the ring) ...
SET @poly = ST_GeomFromText('POLYGON((
  72 16,
  74 16,
  74 20,
  72 20,
  72 16
))');
--          ... then test containment. MIT (USA) falls outside.
SELECT CLGNAME FROM COLLEGE WHERE
ST_Contains(@poly, Location);

-- Query 6: Colleges within 200000 m (200 km) of a point.
SELECT CLGNAME
FROM COLLEGE
WHERE ST_Distance_Sphere(LOCATION, POINT(73.3000, 16.9900)) < 200000;

-- Query 7: Buffer = a circle-like polygon of radius 0.1 degree around each point.
SELECT CLGNAME, ST_AsText(ST_Buffer(LOCATION, 0.1)) AS Location_Buffer
FROM COLLEGE;

-- Query 8: Which geometry type is stored? (POINT)
SELECT CLGNAME, ST_GeometryType(LOCATION) AS Geometry_Type
FROM COLLEGE;

-- Query 9: Count rows.
SELECT COUNT(*) AS Total_Colleges
FROM COLLEGE;

-- Query 10: Complete information with readable location.
SELECT ID, CLGNAME, ST_AsText(LOCATION) AS Location_Text
FROM COLLEGE;

-- ======================= PART B: LINESTRING data =======================
-- A LINESTRING is an ordered list of 2+ connected points (road, river...).

-- Query 1: Table for roads.
CREATE TABLE Roads(
    road_id INT PRIMARY KEY,
    road_name VARCHAR(100),
    route LINESTRING NOT NULL
);

-- Query 2: Insert a road passing through four locations.
-- Original omitted road_id:
--   INSERT INTO Roads(road_name, route) VALUES ('FAMT-gct', ST_GeomFromText('LINESTRING(17.0125 73.3359, ...)'));
-- [CORRECTION 1] road_id is a PRIMARY KEY without AUTO_INCREMENT, so it needs
--   a value (otherwise "Field 'road_id' doesn't have a default value" in strict mode).
-- [CORRECTION 2 - WARNING, coordinates kept as in original] The original writes
--   the pairs as (latitude longitude) here, but POINT data above is
--   (longitude latitude). To be consistent use 73.3359 17.0125, ... (as the
--   other source file practical3_adt.docx does). Kept original order so your
--   recorded outputs still match.
INSERT INTO Roads(road_id, road_name, route) VALUES
(
 1,
 'FAMT-gct',
 ST_GeomFromText(
  'LINESTRING(
   17.0125 73.3359,
   17.0025 73.3249,
   16.9884 73.3171,
   16.9856 73.3125
  )'
 )
);

-- Query 3: View the route as text.
SELECT road_name, ST_AsText(route) AS Road_Path FROM Roads;

-- Query 4: Length of the line (in coordinate units, NOT metres).
SELECT road_name, ST_Length(route) AS Length FROM Roads;

-- Query 5: Start point and end point.
SELECT road_name, ST_AsText(ST_StartPoint(route)) AS Start_Point FROM Roads;
SELECT road_name, ST_AsText(ST_EndPoint(route)) AS End_Point FROM Roads;

-- Query 6: Number of points that make up the line (4).
SELECT road_name, ST_NumPoints(route) AS Total_Points FROM Roads;

-- Query 7: The 2nd point of the route (ST_PointN is 1-based).
SELECT ST_AsText(ST_PointN(route, 2)) AS Second_Point FROM Roads;

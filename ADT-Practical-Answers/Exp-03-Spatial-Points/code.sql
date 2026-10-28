-- Experiment 3: Spatial data (POINT) - colleges near Ratnagiri
-- Coordinates are approximate; replace with real ones from Google Maps. SRID 4326 uses (latitude longitude) order in MySQL 8.
DROP DATABASE IF EXISTS SpatialDB;
CREATE DATABASE SpatialDB;
USE SpatialDB;

CREATE TABLE College (
    id       INT PRIMARY KEY,
    name     VARCHAR(100),
    location POINT NOT NULL SRID 4326
);

INSERT INTO College VALUES
(1,'Finolex Academy of Management and Technology', ST_GeomFromText('POINT(17.011680 73.335696)',4326)),
(2,'Government Polytechnic Ratnagiri',             ST_GeomFromText('POINT(16.983857 73.312632)',4326)),
(3,'Government College of Engineering Ratnagiri',  ST_GeomFromText('POINT(16.984514 73.312804)',4326)),
(4,'Gogate Joglekar College',                      ST_GeomFromText('POINT(16.986440 73.299455)',4326)),
(5,'Sample College (approx. location)',          ST_GeomFromText('POINT(16.620000 73.400000)',4326));
-- NOTE: with SRID 4326 MySQL 8 uses (latitude longitude) axis order.

-- 1) Display location as text
SELECT name, ST_AsText(location) AS location_text FROM College;

-- 2) X and Y coordinates (for SRID 4326: ST_X = latitude, ST_Y = longitude)
SELECT name, ST_Latitude(location) AS latitude, ST_Longitude(location) AS longitude FROM College;

-- 3) Distance between two colleges (metres)
SELECT ST_Distance(a.location, b.location) AS distance_m
FROM College a, College b WHERE a.id = 2 AND b.id = 1;

-- 4) Colleges near a location (within 5 km of GCE Ratnagiri)
SELECT c.name, ROUND(ST_Distance(c.location, ref.location)) AS dist_m
FROM College c, (SELECT location FROM College WHERE id = 3) ref
WHERE ST_Distance(c.location, ref.location) <= 5000 AND c.id <> 3
ORDER BY dist_m;

-- 5) Display complete information
SELECT id, name, ST_AsText(location) AS wkt,
       ST_Latitude(location) AS latitude, ST_Longitude(location) AS longitude
FROM College;

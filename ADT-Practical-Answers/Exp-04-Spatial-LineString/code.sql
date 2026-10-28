-- Experiment 4: LineString route FAMT -> GIT (route points are APPROXIMATE sample points; replace with real GPS points from Google Maps)
DROP DATABASE IF EXISTS RouteDB;
CREATE DATABASE RouteDB;
USE RouteDB;

CREATE TABLE Route (
    route_id   INT PRIMARY KEY,
    route_name VARCHAR(100),
    path       LINESTRING NOT NULL SRID 4326
);

-- points are (latitude longitude) for SRID 4326
INSERT INTO Route VALUES
(1,'FAMT to GIT',
 ST_GeomFromText('LINESTRING(17.011680 73.335696, 17.004000 73.328000, 16.995000 73.320000, 16.987000 73.314000, 16.984514 73.312804)',4326));

-- 1) View the route
SELECT route_name, ST_AsText(path) AS route FROM Route;

-- 2) Length of the line (metres)
SELECT route_name, ROUND(ST_Length(path),2) AS length_m FROM Route;

-- 3) Number of points
SELECT route_name, ST_NumPoints(path) AS total_points FROM Route;

-- 4) Start and end point
SELECT ST_AsText(ST_StartPoint(path)) AS start_point,
       ST_AsText(ST_EndPoint(path))   AS end_point FROM Route;

-- 5) Get a particular point (3rd point)
SELECT ST_AsText(ST_PointN(path,3)) AS third_point FROM Route;

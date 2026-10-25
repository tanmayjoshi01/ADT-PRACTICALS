# Experiment 3 - Implementation of Spatial Data Storage and Retrieval in MySQL

**Syllabus module:** 2 - Advanced Database Systems (item 1)  
**Source (final choice):** `Exp_3_Spatial_Data_Storage_docx.pdf` / `Exp_3_Spatial_Data_Storage.docx` (colleges, database `AAL`) - the only version with every query and output complete. Other versions (schools, `collegedetails`, unfinished draft) were dropped.

**Validation:** NOT EXECUTED - reviewed only. 
## Aim
Store locations as spatial `POINT` and `LINESTRING` data in MySQL and run spatial queries (coordinates, distance, containment, buffer, length).

## Required software
MySQL 8.0 + Workbench (spatial functions `ST_Distance_Sphere`, `ST_Buffer`, `ST_Contains`).

## Procedure
Part A: create DB/table -> insert 5 points -> 10 retrieval queries. Part B: `Roads` table with a LINESTRING -> 7 queries. All in `code.sql`.

## How to run
```bash
mysql -u root -p < code.sql
```

## Outputs recorded in the PDF
| Query | Result in your PDF |
|---|---|
| Q3 `ST_Distance` | `0.03613912733425336` (degrees) |
| Q4 `ST_Distance_Sphere` | `3947.922728832136` metres |
| Q5 inside polygon | FINOLEX, Govt Polytechnic, GCE Ratnagiri, Gogate Joglekar (MIT excluded) |
| Q6 within 200 km | the same 4 Indian colleges |
| Q8 | POINT for all 5 rows |
| Q9 | 5 |
| LINESTRING length | `0.036364892356842635` |
| Start / End / 2nd point | `POINT(73.3359 17.0125)` / `POINT(73.3125 16.9856)` / `POINT(73.3249 17.0025)` |

## Corrections / issues found
1. **Roads insert** omits `road_id` (PRIMARY KEY, no AUTO_INCREMENT) - fixed by adding `1`.
2. **Coordinate order:** points use `(lon lat)` but the LINESTRING uses `(lat lon)`. Kept as in your PDF so outputs match; the other draft uses `(lon lat)`. Consistency is recommended.
3. In the PDF, the screenshot under LINESTRING *Query 6 (Count Number of Points)* shows the End_Point result instead of a count - looks like a wrong screenshot; the expected value is `4`.
4. `ST_Length` / `ST_Distance` return degrees, not metres (noted in the source too).

## Viva questions
1. **Which spatial data types does MySQL support?** POINT, LINESTRING, POLYGON, MULTI* types and GEOMETRYCOLLECTION.
2. **What is WKT?** Well-Known Text, e.g. `POINT(73.3 16.9)`.
3. **ST_Distance vs ST_Distance_Sphere?** The first is planar in coordinate units; the second gives metres on a sphere (lon, lat order).
4. **What does ST_Contains(a, b) check?** Whether geometry `a` completely contains `b`.
5. **What is a buffer?** A polygon around a geometry at a given distance.
6. **Why must a polygon's first and last points match?** To close the ring.

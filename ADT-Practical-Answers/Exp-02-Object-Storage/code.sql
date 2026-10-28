-- Experiment 2: Object (image) storage and retrieval in MySQL using LONGBLOB
-- Place two image files (image1.jpg, image2.png) in the folder shown by:
--   SHOW VARIABLES LIKE 'secure_file_priv';
-- and change the path below (use forward slashes, even on Windows).
DROP DATABASE IF EXISTS ObjectDB;
CREATE DATABASE ObjectDB;
USE ObjectDB;

CREATE TABLE Images (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    file_name  VARCHAR(255),
    file_type  VARCHAR(100),
    file_data  LONGBLOB
);

-- 1) Insert image files and verify storage
INSERT INTO Images (file_name, file_type, file_data) VALUES
('image1.jpg','image/jpeg', LOAD_FILE('/var/lib/mysql-files/image1.jpg')),
('image2.png','image/png',  LOAD_FILE('/var/lib/mysql-files/image2.png'));

SELECT id, file_name, file_type, (file_data IS NOT NULL) AS is_stored FROM Images;

-- 2) Retrieve object information
SELECT id, file_name, file_type FROM Images WHERE id = 1;

-- 3) Display file sizes
SELECT file_name, LENGTH(file_data) AS size_bytes,
       ROUND(LENGTH(file_data)/1024, 2) AS size_kb
FROM Images;

-- 4) Update an existing object
UPDATE Images
SET file_name = 'image1_updated.jpg',
    file_data = LOAD_FILE('/var/lib/mysql-files/image2.png'),
    file_type = 'image/png'
WHERE id = 1;
SELECT id, file_name, file_type, LENGTH(file_data) AS size_bytes FROM Images;

-- 5) Count stored objects
SELECT COUNT(*) AS total_objects FROM Images;

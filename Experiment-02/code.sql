-- =====================================================================
-- Experiment 2: Implementation of Object Storage and Retrieval in MySQL
-- Source : Database_Exp2_output.docx (Steps 1-15, original order)
-- Status : NOT EXECUTED - syntax and logic reviewed only
-- NOTE   : This file is "Experiment 2" in YOUR numbering. In the syllabus
--          list this practical is the 3rd item of Module 2 (see root README).
-- Corrections are marked [CORRECTION] with the original kept in a comment.
-- =====================================================================

-- Step 1: Create a database and select it.
CREATE DATABASE ObjectStorageDB;
USE ObjectStorageDB;

-- Step 2: Table to store files ("objects").
--   LONGBLOB holds the raw bytes of the file (up to 4 GB).
--   The other columns store metadata (name, MIME type, size).
CREATE TABLE Documents (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- auto-generated unique id
    file_name VARCHAR(255),
    file_type VARCHAR(100),              -- MIME type, e.g. application/pdf
    file_size INT,                       -- size in bytes
    file_data LONGBLOB                   -- the file content itself
);

-- Step 3: Insert a file using LOAD_FILE().
--   LOAD_FILE() reads a file from the SERVER's disk and returns its bytes.
--   It works only if: the MySQL user has the FILE privilege, the file is
--   inside the folder shown by  SHOW VARIABLES LIKE 'secure_file_priv';
--   and the path is absolute.
-- Original:
--   insert into Documents VALUES (1,'output.pdf','application/pdf',40960,
--       load_file("C:\Users\student\Desktop\B63"));
-- [CORRECTION] Backslashes are escape characters inside MySQL strings, so
--   use forward slashes; also the path must end with a FILE name, not a
--   folder (B63). Replace the path with your real file.
INSERT INTO Documents VALUES
(1, 'output.pdf', 'application/pdf', 40960,
 LOAD_FILE('C:/Users/student/Desktop/B63/output.pdf'));

-- Step 4: Insert an image the same way.
-- [CORRECTION] same path fix as Step 3 (original used "...\B63").
INSERT INTO Documents VALUES
(2, 'image.png', 'image/png', 102400,
 LOAD_FILE('C:/Users/student/Desktop/B63/image.png'));

-- Step 5: Verify what is stored (the BLOB column is left out on purpose).
SELECT id, file_name, file_type, file_size FROM Documents;

-- Step 6: Retrieve information about one object.
SELECT id, file_name, file_type, file_size FROM Documents WHERE id = 1;

-- Step 7: Search objects by file name (LIKE with % wildcards).
SELECT * FROM Documents WHERE file_name LIKE '%output%';

-- Step 8: Display file sizes in KB.
-- Original: ROUND(file_size/10242)
-- [CORRECTION] 1 KB = 1024 bytes, so the divisor must be 1024 (typo 10242).
SELECT file_name, ROUND(file_size/1024) AS Size_KB FROM Documents;

-- Step 9: Replace an existing object with a new version.
UPDATE Documents
SET file_name = 'output.pdf',
    file_data = LOAD_FILE('C:/Documents/output.pdf')
WHERE id = 1;

-- Step 10: Count stored objects.
SELECT COUNT(*) AS TotalFiles FROM Documents;

-- Step 11: Retrieve the stored file (binary data).
--   An application (Python/Java/PHP) would write these bytes back to a file.
SELECT file_data FROM Documents WHERE id = 1;

-- Step 12: Delete an object.
DELETE FROM Documents WHERE id = 1;

-- Step 13: Insert an audio object.
-- [CORRECTION] path fixed (original ended in the folder name B63).
INSERT INTO Documents VALUES
(3, 'audio.wav', 'audio/wav', 155648,
 LOAD_FILE('C:/Users/student/Desktop/B63/audio.wav'));

-- Step 14: Insert a video object.
INSERT INTO Documents VALUES
(4, 'cat.mp4', 'video/mp4', 155648,
 LOAD_FILE('C:/Users/student/Desktop/B63/cat.mp4'));

-- Step 15: Final verification.
SELECT id, file_name, file_type, file_size FROM Documents;

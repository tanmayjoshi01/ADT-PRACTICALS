# Experiment 2 - Object Storage and Retrieval (image BLOB)

**Technology:** MySQL 8  
**Code:** [`code.sql`](code.sql)

## How to run
```bash
mysql -u root -p < code.sql   # or run step by step in MySQL Workbench
```

## Status
SQL script executed on MySQL 8.0 with no errors. Sample output is in `output.txt`.

**Setup:** `LOAD_FILE()` needs the FILE privilege and the images inside the folder from `SHOW VARIABLES LIKE 'secure_file_priv';`. Edit the paths in `code.sql` to your two images.

# Experiment 9 - MongoDB Exercises: CRUD, Indexing, Sharding and Deployment

**Syllabus module:** 6 - NoSQL Databases (item 1)  
**Source:** `exp_9_CRUD_operations.docx` - all commands/outputs are screenshots; I transcribed them.  
**Status: PARTIALLY AVAILABLE** - CRUD and Indexing present; **Sharding and Deployment are absent** from the file even though the title and syllabus list them.  
**Validation:** NOT EXECUTED - reviewed only.

## Aim
Perform CRUD operations on a student collection and study indexes. (Sharding + deployment: see "Missing".)

## Required software
MongoDB 8.x + `mongosh`.

## How to run
```bash
mongosh
# paste code.js section by section
```

## Expected output (from screenshots)
- insertMany -> 5 ids · `find({dept:"IT"})` -> 101, 102, 103 · `CGPA > 8.5` -> 101, 103, 105.
- Descending sort: 103 (9.1), 105 (8.9), 101 (8.8), 104 (8.4), 102 (7.9).
- updateOne -> matched 1, modified 1 · updateMany IT -> matched 3 · deleteOne -> 1 · deleteMany CSE -> 2.
- `createIndex` -> `rollno_1`; compound -> `Department_1_CGPA_-1`; `dropIndex` -> `{ nIndexesWas: 3, ok: 1 }`.
- The `explain()` output is long - see page 9 of the source.

## Inconsistencies found (code NOT silently altered)
1. Source text uses `db.students`, `RollNo`, `Department`; screenshots use `db.b3`, `rollno`, `dept`. `code.js` follows the screenshots.
2. Compound index on `Department` indexes a non-existent field (documents use `dept`).
3. `dropIndex({RollNo: 1})` - capitalisation could not be read reliably in the screenshot; MongoDB index keys are case-sensitive, so the key must match `rollno`.

## Missing - what I need from you
Screenshots/commands for **Sharding** (e.g. `sh.enableSharding`, `sh.shardCollection`, sharded cluster set-up) and **Deployment** (e.g. install/run `mongod`, replica set or Atlas/Docker). I will not invent these.

## Viva questions
1. **What is an index and its cost?** A structure that speeds reads; costs storage and slows writes.
2. **What does IXSCAN vs COLLSCAN mean?** Index scan vs full collection scan.
3. **What is a compound index?** An index on several fields; order matters.
4. **What is sharding?** Splitting data across servers by a shard key for horizontal scaling.
5. **CAP theorem?** A distributed store can guarantee only two of Consistency, Availability, Partition tolerance.

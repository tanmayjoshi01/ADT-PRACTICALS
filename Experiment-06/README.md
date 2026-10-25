# Experiment 6 - Mobile Database Query Processing using Open-Source DB (MongoDB)

**Syllabus module:** 3 - Distributed Databases (item 2)  
**Sources:** `Exp_6_...Processing.docx` (database `b3Shravanee`) and `Share_Exp_6_...Processing.docx` (database `MobileDB`). Insert/query commands for steps 4-6 exist only as screenshots; I transcribed them (documents 102-104, coordinates).  
**Validation:** NOT EXECUTED - reviewed only. No corrections; the only difference between the two sources is the database name.

## Aim
Store mobile-user data (device, city, latitude/longitude, network, usage) in MongoDB and process queries: filter, range, sort, update, delete, multi-condition.

## Required software
MongoDB Community 8.x (`mongod`) and `mongosh` (your screenshot shows MongoDB 8.3.8 on Windows).

## How to run
```bash
mongod --version          # prompt 1: check install (server must be running)
mongosh                   # prompt 2: open the shell, then paste code.js step by step
```
`mongosh --file code.js` may also work, but the `use`/`show` helpers were not tested in script mode.

## Expected output (from your screenshots)
- Step 4: `acknowledged: true` and 1 / 3 inserted ids.
- F: Priya (12.3), Ananya (15.8). G: Rahul (8.5), Priya (12.3).
- Sort ascending starts with Aarav (4.1); descending starts with Ananya (15.8).
- After steps 7-8: Rahul has `network: '4G'`, `data_usage: 10.5`. After step 9: users 101, 102, 104.
- Step 10: Priya and Ananya.

## Observations
- A database/collection is physically created only when data is first written.
- `latitude`/`longitude` are plain numbers here; for real geo-queries MongoDB needs GeoJSON + a `2dsphere` index (not part of this practical).
- Transcription uncertainty: values of documents 102-104 were read from screenshots - compare with your originals.

## Viva questions
1. **What is a document / collection?** A JSON-like record / a group of documents (like row / table).
2. **`find` vs `findOne`?** `find` returns a cursor of all matches; `findOne` returns the first.
3. **What does `$set` do?** Updates only the named fields instead of replacing the document.
4. **Why are NoSQL/document DBs good for mobile apps?** Flexible schema, JSON-friendly, easy horizontal scaling.
5. **What does `sort({field: -1})` mean?** Descending order.

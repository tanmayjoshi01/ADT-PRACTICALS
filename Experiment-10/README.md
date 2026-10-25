# Experiment 10 - Cassandra: Table Operations, CRUD Operations and CQL Types

**Syllabus module:** 6 - NoSQL Databases (item 2)  
**Source:** `adt_EXP_10.docx` (text + screenshots)  
**Validation:** NOT EXECUTED - reviewed only. **1 correction** (`DELETE cityFROM studentsWHERE` -> spaces added).  
**Uncertain transcription:** employee rows 2-5 and the two `UPDATE ... +` statements came from small screenshots (phone numbers especially) - please compare with your originals.

## Aim
Run Cassandra in Docker (Killercoda) and perform table operations, CRUD and CQL collection types (SET, LIST, MAP).

## Required software
Killercoda Ubuntu playground with Docker (or any Docker host), image `cassandra:5.0`.

## Procedure / how to run
```bash
bash setup.sh            # pulls image, starts container, opens cqlsh
```
Then paste `code.cql` into the `cqlsh>` prompt (or `docker exec -i cassandra cqlsh < code.cql`). Wait ~1-2 min after `docker run` before opening `cqlsh`.

## Expected output (from the source)
- `DESCRIBE KEYSPACES` lists `b3` after creation.
- After the CRUD section: 101 updated (Thane -> age 21, 87.25), 104 deleted, 103 has `city = null`.
- Employee table: 5 rows; Raj has `MongoDB` added to skills and one extra phone number.

## Observations
- Cassandra `INSERT` is an upsert (re-inserting the same key overwrites).
- Only non-primary-key columns can be deleted individually.
- The source's section "CQL Data Types" lists only the collection types, not the full native list (int, text, decimal, date, boolean...).
- Source step numbering skips "Step 4" (Truncate -> Step 5 Drop); kept in comments.

## Viva questions
1. **What is a keyspace?** The top-level namespace, like a database; it holds replication settings.
2. **SimpleStrategy vs NetworkTopologyStrategy?** Simple for one data centre/testing; NetworkTopology for multi-DC production.
3. **TRUNCATE vs DROP TABLE?** TRUNCATE removes rows only; DROP removes table and data.
4. **LIST vs SET vs MAP?** Ordered with duplicates / unique values / key-value pairs.
5. **BASE and CAP for Cassandra?** AP system - highly available, eventually consistent.

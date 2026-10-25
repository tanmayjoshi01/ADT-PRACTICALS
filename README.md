# ADT-Practicals - Advanced Database Technologies Lab (23451182)

Lab practicals for **Advanced Database Technologies Lab**, T.Y. IT (Sem V/VI). Code is extracted from my own practical write-ups and annotated with step-by-step comments for exam/viva revision.

## Technologies
MySQL 8 (SQL, spatial types, data-warehouse/ETL) · MongoDB 8 + `mongosh` · Apache Cassandra 5.0 (CQL, Docker/Killercoda) · MySQL Workbench

## Experiments
| No. | Title | Technology | Folder | Status |
|---|---|---|---|---|
| 1 | Query processing: DB/table creation and complex querying, execution plans | MySQL | [Experiment-01](Experiment-01) | Complete |
| 2 | Object storage and retrieval (BLOB) | MySQL | [Experiment-02](Experiment-02) | Complete (4 corrections) |
| 3 | Spatial data storage and retrieval | MySQL | [Experiment-03](Experiment-03) | Complete |
| 4 | Temporal data storage and retrieval | MySQL | [Experiment-04](Experiment-04) | Complete (2 typo corrections) |
| 5 | Fragmentation and replication | MySQL | [Experiment-05](Experiment-05) | Complete |
| 6 | Mobile database query processing | MongoDB | [Experiment-06](Experiment-06) | Complete |
| 7 | Star schema and OLAP operations | MySQL | [Experiment-07](Experiment-07) | Complete (snowflake not done) |
| 8 | ETL pipeline (table and CSV) | MySQL | [Experiment-08](Experiment-08) | Complete (1 correction) |
| 9 | MongoDB: CRUD, indexing, sharding, deployment | MongoDB | [Experiment-09](Experiment-09) | **Partial - sharding and deployment missing** |
| 10 | Cassandra: table ops, CRUD, CQL types | Cassandra | [Experiment-10](Experiment-10) | Complete (1 correction) |

> Numbering follows my lab files. The syllabus lists Module 2 as spatial -> temporal -> object, so on paper those are practicals 2, 3, 4; my files number object = 2 and spatial = 3.

## Prerequisites
- MySQL Server 8.0.18+ and MySQL Workbench (Exp 1, 2, 3, 5, 7, 8)
- MongoDB Community 8.x and `mongosh` (Exp 6, 9)
- Docker (Killercoda or local) for Cassandra (Exp 10)

## Running the code
```bash
# MySQL experiments
mysql -u root -p < Experiment-05/code.sql      # or run in Workbench step by step
# MongoDB experiments
mongosh                                         # then paste Experiment-06/code.js
# Cassandra
bash Experiment-10/setup.sh                     # then paste Experiment-10/code.cql in cqlsh
```
Never commit real passwords; use `-p` to be prompted.

## Verification note
No experiment has been executed against a live server by the preparer. Each code file is labelled **NOT EXECUTED - syntax and logic reviewed only**. Corrections are marked `[CORRECTION]` in the code and listed in each README.

## Known gaps
Experiment 9 sharding + deployment, Experiment 7 snowflake variant. See `REPORT.md`.

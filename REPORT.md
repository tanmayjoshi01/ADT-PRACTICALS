# Coverage and Validation Report

## Syllabus -> files
Syllabus (23451182) practical list: 1 Query processing · 2.1 Spatial · 2.2 Temporal · 2.3 Object · 3.1 Replication & fragmentation · 3.2 Mobile DB query processing · 4 Star/Snowflake + OLAP · 5 ETL · 6.1 MongoDB (CRUD, indexing, sharding, deployment) · 6.2 Cassandra. = 10 practicals.

| No. | Title | In syllabus | Output evidence | Code | Status |
|---|---|---|---|---|---|
| 1 | Query processing | Yes | Screenshots in docx | Yes | COMPLETE |
| 2 | Object storage | Yes (2.3) | Screenshots in docx | Yes | COMPLETE |
| 3 | Spatial data | Yes (2.1) | PDF has outputs; schools docx has screenshots | Yes | COMPLETE |
| 4 | Temporal data | Yes (2.2) | 15 screenshots in docx | Yes | COMPLETE (added in 2nd upload) |
| 5 | Fragmentation/replication | Yes (3.1) | Screenshots | Yes | COMPLETE |
| 6 | Mobile DB (MongoDB) | Yes (3.2) | Screenshots | Yes | COMPLETE |
| 7 | Star/Snowflake + OLAP | Yes | Screenshots | Star only | COMPLETE for star; snowflake not shown |
| 8 | ETL | Yes | Screenshots | Yes | COMPLETE |
| 9 | MongoDB exercises | Yes (6.1) | CRUD + indexing only | CRUD + indexing | **PARTIALLY AVAILABLE** (no sharding, no deployment) |
| 10 | Cassandra | Yes (6.2) | Screenshots | Yes | COMPLETE |

Files that were not turned into separate experiments: `practical3_adt.docx` (incomplete draft of Exp 3), `Share_Exp_6_...docx` (template of Exp 6, merged), `Exp_3_Spatial_Data_Storage_docx.pdf` (used as primary for Exp 3).

## What I need from you
1. ~~Experiment 4~~ - received.
2. **Experiment 9:** sharding and deployment commands/screenshots.
4. Optional: confirm Exp 7 should have a snowflake variant added.
5. Please check the small-screenshot transcriptions flagged in Exp 6 (docs 102-104), Exp 9 (`dropIndex` key) and Exp 10 (employee rows 2-5).

## Validation summary
| Experiment | Executed? | Corrections |
|---|---|---|
| 1 | No | none |
| 2 | No | path slashes/file name (4 inserts), `/10242` -> `/1024` |
| 3 | No | Roads insert needs `road_id`; coordinate-order inconsistencies flagged |
| 4 | No | `101ORDER BY` spacing, `ND` -> `AND` |
| 5 | No | none (design issues flagged: Delhi row missing from fragments; replication is a copy) |
| 6 | No | none |
| 7 | No | `GROUP BY t.year` added to Roll-up |
| 8 | No | `ETL_Demo;` -> `USE ETL_Demo;` |
| 9 | No | none (naming inconsistencies flagged, not altered) |
| 10 | No | `DELETE city FROM students ...` spacing |

**Limitation:** the expected-output sections are taken from outputs I could read in the PDF/screenshots, or are marked "derived by hand". I did not transcribe every output screenshot in the .docx files; the images stay in your original documents.

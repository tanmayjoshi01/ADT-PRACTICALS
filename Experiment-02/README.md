# Experiment 2 - Implementation of Object Storage and Retrieval in MySQL

**Syllabus module:** 2 - Advanced Database Systems (item 3, "object storage and retrieval in MySQL")  
**Source:** `Database_Exp2_output.docx` (15 steps; output screenshots are in the source file)  
**Validation:** NOT EXECUTED - reviewed only. **4 corrections** (below).

## Aim
Store files (PDF, image, audio, video) inside MySQL using a `LONGBLOB` column and retrieve/search/update/delete them.

## Required setup
MySQL 8 + Workbench. `LOAD_FILE()` needs: (1) the `FILE` privilege, (2) the file inside the `secure_file_priv` folder (`SHOW VARIABLES LIKE 'secure_file_priv';`), (3) an absolute path readable by the MySQL server process. If it returns `NULL`, one of these is the reason.

## Procedure
Create DB -> create `Documents` table -> insert objects with `LOAD_FILE()` -> verify -> search -> compute size in KB -> update -> count -> retrieve binary -> delete -> insert audio/video -> verify.

## Corrections made (original kept as comments in `code.sql`)
| Where | Original | Fixed | Why |
|---|---|---|---|
| Steps 3, 4, 13, 14 | `"C:\Users\student\Desktop\B63"` | `'C:/Users/student/Desktop/B63/<file>'` | `\` is an escape character in MySQL strings; path pointed to a folder, not a file |
| Step 8 | `file_size/10242` | `file_size/1024` | typo; KB = bytes / 1024 |
| Step 4 heading | line began with `#` | removed | Word heading artefact, not SQL |

Unverified: `file_size` values (40960, 102400, 155648) are typed by hand in the original and do not come from the real files.

## How to run
Run statement by statement in Workbench; adjust the file paths to files that exist on the **server** machine.

## Viva questions
1. **BLOB vs LONGBLOB?** Both store binary data; LONGBLOB holds up to 4 GB, BLOB only 64 KB.
2. **What does LOAD_FILE() do?** Reads a server-side file and returns its content as a string/binary value; returns NULL if it cannot read it.
3. **Why not `SELECT *` on a BLOB table?** It floods the screen with binary data; select only metadata columns.
4. **Drawback of storing files in the DB?** Database size/backup grows and performance drops; many systems store a file path instead.
5. **What is AUTO_INCREMENT?** MySQL generates the next integer id automatically.

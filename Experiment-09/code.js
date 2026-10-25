// =====================================================================
// Experiment 9: MongoDB - CRUD Operations and Indexing
// Source : exp_9_CRUD_operations.docx (code read from screenshots; the typed
//          index commands in the source use students/RollNo/Department, which do
//          NOT match the screenshots - the screenshot names are used here).
// Run as : mongosh (paste step by step)   -- NOT EXECUTED, reviewed only
// MISSING: Sharding and Deployment (named in the title/syllabus) - no
//          content in the uploaded file. See README.
// =====================================================================

// ======================= Exercise 1: CRUD =======================
// Step 1: create/select database and collection.
use collegedb                      // switch to (and lazily create) collegedb
db.createCollection("b3")          // { ok: 1 }

// Step 2: insert documents.
db.b3.insertMany([
  { rollno: 101, name: "Alaka", dept: "IT",  semester: 6, CGPA: 8.8 },
  { rollno: 102, name: "Bunny", dept: "IT",  semester: 6, CGPA: 7.9 },
  { rollno: 103, name: "Rohan", dept: "IT",  semester: 6, CGPA: 9.1 },
  { rollno: 104, name: "Sahil", dept: "CSE", semester: 6, CGPA: 8.4 },
  { rollno: 105, name: "Iffat", dept: "CSE", semester: 6, CGPA: 8.9 }
])

// Step 3: read.
db.b3.find()                              // I.   all students
db.b3.find({ dept: "IT" })                // II.  students of IT department
db.b3.find({ CGPA: { $gt: 8.5 } })        // III. CGPA greater than 8.5
db.b3.find().sort({ CGPA: -1 })           // IV.  descending by CGPA (-1 = desc)
db.b3.find().sort({ CGPA: 1 })            //      ascending by CGPA  (1 = asc)

// Step 4: update.
db.b3.updateOne(                          // one student's CGPA
  { rollno: 101 },
  { $set: { CGPA: 9.0 } }
)
db.b3.updateMany(                         // all IT students -> semester 8
  { dept: "IT" },
  { $set: { semester: 8 } }               // matchedCount: 3, modifiedCount: 3
)

// Step 5: delete.
db.b3.deleteOne({ rollno: 101 })          // deletedCount: 1
db.b3.deleteMany({ dept: "CSE" })         // deletedCount: 2

// ======================= Exercise 2: Indexing =======================
// An index lets MongoDB find documents without scanning the whole collection.
db.b3.createIndex({ rollno: 1 })          // single-field index -> "rollno_1"

// Compound index (two fields). Screenshot output: "Department_1_CGPA_-1".
// NOTE: the screenshot used the field name Department, but the documents use
// "dept", so this index is on a field that does not exist. Kept as in source:
db.b3.createIndex({ Department: 1, CGPA: -1 })
// Probably intended:  db.b3.createIndex({ dept: 1, CGPA: -1 })

db.b3.getIndexes()                        // lists _id_, rollno_1, Department_1_CGPA_-1

// Test performance: look at winningPlan (IXSCAN = index used) and totalDocsExamined.
db.b3.find({ rollno: 101 }).explain("executionStats")

// Drop the index (screenshot shows nIndexesWas: 3, ok: 1).
// The source text writes RollNo; the index created above is on rollno.
db.b3.dropIndex({ rollno: 1 })

// ======================= Exercise 3 / 4 =======================
// Sharding   : NOT FOUND in uploaded files - not written.
// Deployment : NOT FOUND in uploaded files - not written.

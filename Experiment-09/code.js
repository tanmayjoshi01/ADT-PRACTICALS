```javascript
// Experiment 9: MongoDB CRUD Operations, Indexing, Sharding and Deployment

// ======================= EXERCISE 1: CRUD =======================

// Step 1: Select Database and Create Collection
use collegedb
db.createCollection("b3")

// Step 2: Insert Documents
db.b3.insertMany([
    { rollno: 101, name: "Alaka", dept: "IT", semester: 6, CGPA: 8.8 },
    { rollno: 102, name: "Bunny", dept: "IT", semester: 6, CGPA: 7.9 },
    { rollno: 103, name: "Rohan", dept: "IT", semester: 6, CGPA: 9.1 },
    { rollno: 104, name: "Sahil", dept: "CSE", semester: 6, CGPA: 8.4 },
    { rollno: 105, name: "Iffat", dept: "CSE", semester: 6, CGPA: 8.9 }
])

// Step 3: Read Operations
db.b3.find()
db.b3.find({ dept: "IT" })
db.b3.find({ CGPA: { $gt: 8.5 } })
db.b3.find().sort({ CGPA: -1 })
db.b3.find().sort({ CGPA: 1 })

// Step 4: Update Operations
db.b3.updateOne(
    { rollno: 101 },
    { $set: { CGPA: 9.0 } }
)

db.b3.updateMany(
    { dept: "IT" },
    { $set: { semester: 8 } }
)

// Step 5: Delete Operations
db.b3.deleteOne({ rollno: 101 })
db.b3.deleteMany({ dept: "CSE" })


// ======================= EXERCISE 2: INDEXING =======================

// Step 1: Create Single-Field Index
db.b3.createIndex({ rollno: 1 })

// Step 2: Create Compound Index
db.b3.createIndex({ dept: 1, CGPA: -1 })

// Step 3: Display Indexes
db.b3.getIndexes()

// Step 4: Check Query Performance
db.b3.find({ rollno: 101 }).explain("executionStats")

// Step 5: Drop Index
db.b3.dropIndex("rollno_1")


// ======================= EXERCISE 3: SHARDING =======================
// IMPORTANT: Run these commands only on a configured sharded cluster
// connected through mongos. They will not work on a standalone server.

// Step 1: Enable Sharding
sh.enableSharding("collegedb")

// Step 2: Create Shard-Key Index
db.b3.createIndex({ rollno: 1 })

// Step 3: Shard the Collection
sh.shardCollection("collegedb.b3", { rollno: 1 })

// Step 4: Check Sharding Status
sh.status()


// ======================= EXERCISE 4: DEPLOYMENT =======================
// LOCAL DEPLOYMENT
// Open Command Prompt 1 and start the MongoDB server:
// mongod
//
// Open Command Prompt 2 and connect to MongoDB:
// mongosh

// Step 1: Create/Select Deployment Database
use college_deploy

// Step 2: Create Collection
db.createCollection("students")

// Step 3: Insert Documents
db.students.insertMany([
    { rollno: 1, name: "Amit", dept: "IT" },
    { rollno: 2, name: "Priya", dept: "CSE" },
    { rollno: 3, name: "Rahul", dept: "IT" }
])

// Step 4: Display Database and Collection
show dbs
show collections

// Step 5: Display Documents
db.students.find()

// Step 6: Update a Document
db.students.updateOne(
    { rollno: 1 },
    { $set: { dept: "CSE" } }
)

// Step 7: Delete a Document
db.students.deleteOne({ rollno: 3 })

// Step 8: Verify Final Data
db.students.find()
```

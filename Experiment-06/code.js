// =====================================================================
// Experiment 6: Mobile Database Query Processing using MongoDB
// Sources : Exp_6_Implementation_of_Mobile_Database_Query_Processing.docx (your run,
//           database b3Shravanee) and Share_Exp_6_...docx (template, database MobileDB).
//           The two files differ only in the database name (and the template adds an
//           example document). Documents 102-104 were read from screenshots.
// Run as  : mongosh   (paste step by step)   -- NOT EXECUTED, reviewed only
// =====================================================================

// ---- Step 1: start MongoDB (run in two Command Prompts) ----
//   Prompt 1:  mongod --version     (checks MongoDB is installed)
//   Prompt 2:  mongosh              (opens the shell; server must be running)
show dbs                           // lists databases -> confirms connection

// ---- Step 2: create/select the database (created on first insert) ----
use b3Shravanee                    // template uses:  use MobileDB
db                                 // prints the current database name

// ---- Step 3: create the collection ----
db.createCollection("MobileUsers") // { ok: 1 }
show collections                   // -> MobileUsers

// ---- Step 4: insert data ----
// Single document (a mobile user with device, location and network info)
db.MobileUsers.insertOne({
    user_id: 101,
    name: "Rahul",
    device: "Samsung Galaxy S24",
    city: "Mumbai",
    latitude: 19.0760,
    longitude: 72.8777,
    network: "5G",
    data_usage: 8.5,               // in GB
    status: "Active"
})

// Multiple documents (3 records)
db.MobileUsers.insertMany([
  { user_id: 102, name: "Priya",  device: "iPhone 15 Pro", city: "Delhi",
    latitude: 28.6139, longitude: 77.2090, network: "5G",
    data_usage: 12.3, status: "Active" },
  { user_id: 103, name: "Aarav",  device: "OnePlus 12",    city: "Bengaluru",
    latitude: 12.9716, longitude: 77.5946, network: "4G",
    data_usage: 4.1,  status: "Inactive" },
  { user_id: 104, name: "Ananya", device: "Google Pixel 8", city: "Hyderabad",
    latitude: 17.3850, longitude: 78.4867, network: "5G",
    data_usage: 15.8, status: "Active" }
])

// ---- Step 5: query processing operations ----
db.MobileUsers.find()                              // A. all users
db.MobileUsers.findOne({ user_id: 101 })           // B. one particular user
db.MobileUsers.find({ city: "Mumbai" })            // C. users from Mumbai
db.MobileUsers.find({ network: "5G" })             // D. users on 5G
db.MobileUsers.find({ status: "Active" })          // E. active users
db.MobileUsers.find({ data_usage: { $gt: 10 } })   // F. usage > 10 GB  ($gt = greater than)
db.MobileUsers.find({                              // G. usage between 5 and 15 GB
    data_usage: { $gte: 5, $lte: 15 }              //    ($gte >=, $lte <=)
})

// ---- Step 6: sorting (1 = ascending, -1 = descending) ----
db.MobileUsers.find().sort({ data_usage: 1 })
db.MobileUsers.find().sort({ data_usage: -1 })

// ---- Step 7: update - Rahul's network 5G -> 4G ----
db.MobileUsers.updateOne(
    { user_id: 101 },                              // filter: which document
    { $set: { network: "4G" } }                    // $set changes only this field
)
db.MobileUsers.findOne({ user_id: 101 })           // verify

// ---- Step 8: update data usage ----
db.MobileUsers.updateOne(
    { user_id: 101 },
    { $set: { data_usage: 10.5 } }
)

// ---- Step 9: delete a user, then verify ----
db.MobileUsers.deleteOne({ user_id: 103 })
db.MobileUsers.find()                              // 101, 102, 104 remain

// ---- Step 10: multiple conditions (implicit AND) ----
db.MobileUsers.find({ status: "Active", network: "5G" })   // -> 102 and 104

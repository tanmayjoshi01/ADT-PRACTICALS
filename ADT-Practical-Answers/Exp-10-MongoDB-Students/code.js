// Experiment 10: MongoDB CRUD on Students (3 IT + 2 CSE)
use CollegeDB
db.createCollection("Students")

db.Students.insertMany([
  { id: 1, name: "Amit",  address: "Pune",      department: "IT"  },
  { id: 2, name: "Neha",  address: "Mumbai",    department: "IT"  },
  { id: 3, name: "Rahul", address: "Ratnagiri", department: "IT"  },
  { id: 4, name: "Sneha", address: "Nashik",    department: "CSE" },
  { id: 5, name: "Karan", address: "Nagpur",    department: "CSE" }
])

// Read
db.Students.find()
db.Students.find({ department: "IT" })
db.Students.findOne({ id: 4 })
db.Students.countDocuments({ department: "CSE" })
// Update
db.Students.updateOne({ id: 1 }, { $set: { address: "Satara" } })
db.Students.updateMany({ department: "CSE" }, { $set: { year: "TY" } })
// Delete
db.Students.deleteOne({ id: 5 })
db.Students.find()

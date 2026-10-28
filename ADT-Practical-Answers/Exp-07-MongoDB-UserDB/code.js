// Experiment 7: Mobile database query processing - MongoDB (UserDB / Users)
use UserDB
db.createCollection("Users")

db.Users.insertMany([
  { id: 1, name: "Amit",  city: "Pune",      latitude: 18.5204, longitude: 73.8567 },
  { id: 2, name: "Neha",  city: "Mumbai",    latitude: 19.0760, longitude: 72.8777 },
  { id: 3, name: "Rahul", city: "Ratnagiri", latitude: 16.9902, longitude: 73.3120 },
  { id: 4, name: "Sneha", city: "Nashik",    latitude: 19.9975, longitude: 73.7898 },
  { id: 5, name: "Karan", city: "Pune",      latitude: 18.5300, longitude: 73.8470 }
])

// Read
db.Users.find()
db.Users.find({ city: "Pune" })
db.Users.findOne({ id: 3 })
db.Users.find({ latitude: { $gt: 18.6 } })          // mobile users north of 18.6
// Update
db.Users.updateOne({ id: 2 }, { $set: { city: "Navi Mumbai" } })
db.Users.updateMany({ city: "Pune" }, { $set: { state: "Maharashtra" } })
// Delete
db.Users.deleteOne({ id: 4 })
db.Users.find()

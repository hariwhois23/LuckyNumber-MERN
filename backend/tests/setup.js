const mongoose = require('mongoose');
const { MongoMemoryServer } = require('mongodb-memory-server');

let mongoServer;

// This runs ONCE before ALL tests
beforeAll(async () => {
  // Create an in-memory MongoDB instance
  mongoServer = await MongoMemoryServer.create();
  
  // Get the connection string for the in-memory database
  const mongoUri = mongoServer.getUri();
  
  // Connect mongoose to the test database
  await mongoose.connect(mongoUri);
});

// This runs ONCE after ALL tests are complete
afterAll(async () => {
  // Clean up: drop the database
  if (mongoose.connection.db) {
    await mongoose.connection.db.dropDatabase();
  }
  
  // Disconnect from MongoDB
  await mongoose.disconnect();
  
  // Stop the in-memory MongoDB server
  await mongoServer.stop();
});

// This runs AFTER EACH individual test
afterEach(async () => {
  // Clean up: delete all data from all collections
  const collections = mongoose.connection.collections;
  for (const key in collections) {
    await collections[key].deleteMany({});
  }
});
const { MongoClient } = require('mongodb');
const { Pool } = require('pg'); 

let mongoClient; // Declare mongoClient in the module scope

// PostgreSQL Connection Pool
const pgPool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'moviedatabase', // Change this to your PostgreSQL database name
  password: 'art2200',
  port: 5432,
});

async function connectToMongoDB() {
  if (!mongoClient || !mongoClient.topology || !mongoClient.topology.isConnected()) {
    mongoClient = new MongoClient('mongodb://127.0.0.1:27017');

    try {
      await mongoClient.connect();
      console.log('Connected to MongoDB');
    } catch (error) {
      console.error('Error connecting to MongoDB:', error);
      throw error;
    }
  }

  return mongoClient;
}

// Close MongoDB connection
function closeMongoDB() {
  if (mongoClient && mongoClient.topology && mongoClient.topology.isConnected()) {
    mongoClient.close();
    console.log('Closed MongoDB connection');
  }
}

// User Authentication

  async function authenticateUserPostgres(username, providedPassword) {
    const query = 'SELECT * FROM Users WHERE Username = $1 AND Password = $2';
    const values = [username, providedPassword];
    const result = await pgPool.query(query, values);
    return result.rows[0] || null;
  }

async function registerUserPostgres(user) {
    const query = 'INSERT INTO Users (Username, Password, Email, FirstName, LastName) VALUES ($1, $2, $3, $4, $5) RETURNING *';
    const values = [user.Username, user.Password, user.Email, user.FirstName, user.LastName];
    const result = await pgPool.query(query, values);
    return result.rows[0];
}

// MongoDB Operations


async function findMoviesByRegexMongo(regex) {
  let client; // Declare the client variable

  try {
    // Connect to MongoDB
    client = await connectToMongoDB();

    // Build the query object based on provided parameters
    const query = {
      $or: [
        { Title: { $regex: regex, $options: 'i' } },
        { Director: { $regex: regex, $options: 'i' } },
        { Genres: { $regex: regex, $options: 'i' } },
      ],
    };

    const db = client.db('moviedatabase');
    return db.collection('Movies').find(query).toArray();
  } catch (error) {
    console.error('Error finding movies in MongoDB:', error);
    throw error;
  } finally {
    // Close MongoDB connection
   // closeMongoDB();
  }
}

// PostgreSQL Operations

async function findMoviesByRegexPostgres(regex) {
  const query = `
    SELECT * FROM Movies
    WHERE Title ~* $1 OR Director ~* $2 OR Genres ~* $3
  `;
  const values = [regex, regex, regex];
  const result = await pgPool.query(query, values);
  return result.rows;
}

async function findUserByEmailPostgres(email) {
  const query = 'SELECT * FROM Users WHERE Email = $1';
  const values = [email];
  const result = await pgPool.query(query, values);
  return result.rows[0];
}

async function findUserByUsernamePostgres(username) {
  const query = 'SELECT * FROM Users WHERE Username = $1';
  const values = [username];
  const result = await pgPool.query(query, values);
  return result.rows[0];
}

module.exports = {
  connectToMongoDB,
  closeMongoDB,
  authenticateUserPostgres,
  findMoviesByRegexMongo,
  findMoviesByRegexPostgres,
  registerUserPostgres
};

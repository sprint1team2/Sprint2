const { MongoClient } = require('mongodb');
const { Pool } = require('pg'); 

// MongoDB Connection
const mongoClient = new MongoClient('mongodb://localhost:27017');
// Removed useNewUrlParser: true and useUnifiedTopology: true, as these are deprecated options in Node.js 4.0.0.

// PostgreSQL Connection Pool
const pgPool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'moviedatabase', // Change this to your PostgreSQL database name
    password: 'Keyin2021',
    port: 5432,
});

// Connect to MongoDB
async function connectToMongoDB() {
  try {
    await mongoClient.connect();
    console.log('Connected to MongoDB');
  } catch (error) {
    console.error('Error connecting to MongoDB:', error);
  }
}

// Close MongoDB connection
function closeMongoDB() {
  mongoClient.close();
  console.log('Closed MongoDB connection');
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


async function findMoviesByTitleRegexMongo(titleRegex, directorRegex, genreRegex) {
  const db = mongoClient.db('moviedatabase');
  
  // Build the query object based on provided parameters
  const query = {
    $or: [
      { Title: { $regex: titleRegex, $options: 'i' } },
      { Director: { $regex: directorRegex, $options: 'i' } },
      { Genres: { $regex: genreRegex, $options: 'i' } },
    ],
  };

  return db.collection('Movies').find(query).toArray();
}

// PostgreSQL Operations

async function findMoviesByTitleRegexPostgres(titleRegex, directorRegex, genreRegex) {
  const query = `
    SELECT * FROM Movies
    WHERE Title ~* $1 OR Director ~* $2 OR Genres ~* $3
  `;
  const values = [titleRegex, directorRegex, genreRegex];
  const result = await pgPool.query(query, values);
  return result.rows;
}

<<<<<<< Updated upstream
=======
async function findMoviesByTitleRegexPostgres(titleRegex) {
    const query = 'SELECT * FROM Movies WHERE Title ~* $1';
    const values = [titleRegex];
    const result = await pgPool.query(query, values);
    return result.rows;
}

>>>>>>> Stashed changes
module.exports = {
  connectToMongoDB,
  closeMongoDB,
//   authenticateUserMongo,
  authenticateUserPostgres,
  findMovieByTitleMongo,
  findMovieByTitlePostgres,
  findMoviesByTitleRegexMongo,
  findMoviesByTitleRegexPostgres,
  registerUserPostgres
};

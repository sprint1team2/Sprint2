const { MongoClient } = require('mongodb');
const { Pool } = require('pg'); 

// MongoDB Connection
const mongoClient = new MongoClient('mongodb://localhost:27017', { useNewUrlParser: true, useUnifiedTopology: true });

// PostgreSQL Connection Pool
const pgPool = new Pool({
  user: 'your_pg_user',
  host: 'localhost',
  database: 'moviedatabase', // Change this to your PostgreSQL database name
  password: 'your_pg_password',
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

async function authenticateUserMongo(username, providedPassword) {
    const db = mongoClient.db('moviedatabase');
    const user = await db.collection('Users').findOne({ Username: username, Password: providedPassword });
    return user || null;
  }
  
  async function authenticateUserPostgres(username, providedPassword) {
    const query = 'SELECT * FROM Users WHERE Username = $1 AND Password = $2';
    const values = [username, providedPassword];
    const result = await pgPool.query(query, values);
    return result.rows[0] || null;
  }

// Movies CRUD operations

// MongoDB Operations

async function insertMovieMongo(movie) {
  const db = mongoClient.db('moviedatabase');
  const result = await db.collection('Movies').insertOne(movie);
  return result.ops[0];
}

async function findMovieByTitleMongo(title) {
  const db = mongoClient.db('moviedatabase');
  return db.collection('Movies').findOne({ Title: title });
}

async function updateMovieMongo(movieId, updatedFields) {
  const db = mongoClient.db('moviedatabase');
  const result = await db.collection('Movies').updateOne({ _id: movieId }, { $set: updatedFields });
  return result.modifiedCount > 0;
}

async function deleteMovieMongo(movieId) {
  const db = mongoClient.db('moviedatabase');
  const result = await db.collection('Movies').deleteOne({ _id: movieId });
  return result.deletedCount > 0;
}

// PostgreSQL Operations

async function insertMoviePostgres(movie) {
  const query = 'INSERT INTO Movies (Title, ReleaseDate, Genres, Director, UserID) VALUES ($1, $2, $3, $4, $5) RETURNING *';
  const values = [movie.Title, movie.ReleaseDate, movie.Genres, movie.Director, movie.UserID];
  const result = await pgPool.query(query, values);
  return result.rows[0];
}

async function findMovieByTitlePostgres(title) {
  const query = 'SELECT * FROM Movies WHERE Title = $1';
  const values = [title];
  const result = await pgPool.query(query, values);
  return result.rows[0];
}

async function updateMoviePostgres(movieId, updatedFields) {
  const query = 'UPDATE Movies SET Title = $1, ReleaseDate = $2, Genres = $3, Director = $4, UserID = $5 WHERE MovieID = $6 RETURNING *';
  const values = [updatedFields.Title, updatedFields.ReleaseDate, updatedFields.Genres, updatedFields.Director, updatedFields.UserID, movieId];
  const result = await pgPool.query(query, values);
  return result.rows[0];
}

async function deleteMoviePostgres(movieId) {
  const query = 'DELETE FROM Movies WHERE MovieID = $1 RETURNING *';
  const values = [movieId];
  const result = await pgPool.query(query, values);
  return result.rows[0];
}

module.exports = {
  connectToMongoDB,
  closeMongoDB,
  authenticateUserMongo,
  authenticateUserPostgres,
  insertMovieMongo,
  findMovieByTitleMongo,
  updateMovieMongo,
  deleteMovieMongo,
  insertMoviePostgres,
  findMovieByTitlePostgres,
  updateMoviePostgres,
  deleteMoviePostgres,
};

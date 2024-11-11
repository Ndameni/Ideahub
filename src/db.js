
require('dotenv').config(); // .env variables

const { Pool } = require('pg');

// Check if your environment variables are loaded correctly by logging them
console.log('DB User:', process.env.DB_USER); // Logs DB_USER to the console


// Set up PostgreSQL connection
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT || 5432, // Default PostgreSQL port
});

console.log("Database password:",process.env.DB_HOST, );  // Log the password to check if it's loaded


// Testing database connection
pool.connect()
    .then(client => {
        console.log('Connected to the database successfully!');
    })
    .catch(err => {
        console.error('Database connection error', err.stack);
    });

module.exports = pool;  // Export the pool so it can be used in other files

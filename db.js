const { Pool } = require('pg');

const pool = new Pool({
    user:'postgres',
    host:'localhost',
    database:'IdeaHub',
    password: 'admin',
    port: 5432,
});

// Testing database connection
pool.connect()
    .then(client => {
        console.log('Connected to the database successfully!');
        client.release();
    })
    .catch(err => {
        console.error('Database connection error', err.stack);
    });

module.exports = pool;  // Export the pool so it can be used in other files

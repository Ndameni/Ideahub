const express = require('express');
const path = require('path'); // Import path module
const { Pool } = require('pg');
const multer = require('multer');
const upload = multer({ dest: 'uploads/' });

const app = express();
const port = process.env.PORT || 3000;

// Middleware to parse JSON and URL-encoded data
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Middleware to serve static files
// app.use(express.static(path.join(__dirname, '../css')));

// Middleware to serve static files from the root directory
app.use('/css', express.static(path.join(__dirname, '../css')));  // This ensures that the CSS folder is served correctly
// Serve the css folder
// You can also serve other static folders if needed (e.g., public, js, etc.)

// Define a route for the form page
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'SubmitIdeas.html')); // Updated to use path.join
});

// Set up PostgreSQL connection
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'IdeaHub',
    password: 'admin',
    port: 5432,
});

// Testing database connection
pool.connect()
.then(client => {
    console.log('Connected to the database successfully!');
})

.catch(err => {
    console.error('Database connection server', err.stack)
})

// Route to submit an idea
app.post('/submit-idea', upload.single('file'), async (req, res) => {
    const { title, description, categoryId} = req.body;
    const documentPath = req.file ? req.file.path : null;
    const userId = null; //This is a placeholder until login system is implemented 
    // const categoryId = parseInt(req.body.category) // Default to 1 if not provided

    const isAnonymous = req.body.anonymous === 'on'; // This sets true if checked, false otherwise


    try {
        const query = `
            INSERT INTO "Idea" (title, description, user_id, category_id, is_anonymous,document_path)
            VALUES ($1, $2, $3, $4, $5, $6)
            RETURNING idea_id
        `;
        const values = [title, description, userId,categoryId, isAnonymous, documentPath];
        const result = await pool.query(query, values);

        res.send(`Idea submitted successfully with ID: ${result.rows[0].idea_id}`);
    } catch (error) {
        console.error('Error submitting idea:', error);
        res.status(500).send('Error submitting idea');
    }
});

// Start the server
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});

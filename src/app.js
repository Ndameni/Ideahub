const express = require('express');
const path = require('path');
const multer = require('multer');
const upload = multer({ dest: 'uploads/' });
const { pool } = require('./db');
const authRoutes = require('./auth'); // Include your auth routes here
const jwt = require('jsonwebtoken');
const cors = require('cors');

const app = express();
const port = process.env.PORT || 3000;

// Middleware to parse JSON and URL-encoded data
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Middleware for CORS
app.use(cors()); // Enable cross-origin requests

// Middleware for serving static files
app.use('/css', express.static(path.join(__dirname, 'css')));

// Middleware for JWT authentication
function authenticateUser(req, res, next) {
    const token = req.header('Authorization')?.split(' ')[1];
    if (!token) return res.status(403).json({ message: 'Access denied' });

    try {
        const decoded = jwt.verify(token, 'your_jwt_secret');
        req.user = decoded;
        next();
    } catch (error) {
        res.status(400).json({ message: 'Invalid token', error });
    }
}

// Auth routes
app.use('/auth', authRoutes); // All /auth routes handled in auth.js

// Route for the root page
app.get('/', (req, res) => {
    res.redirect('/auth/login'); // Redirect to login page by default
});

// Route for submitting ideas (secured with JWT)
app.get('/submit-idea', authenticateUser, (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'SubmitIdeas.html'));
});

app.post('/submit-idea', authenticateUser, upload.single('file'), async (req, res) => {
    const { title, description, categoryId } = req.body;
    const documentPath = req.file ? req.file.path : null;
    const userId = req.user.userId; // Get user ID from the authenticated user
    const isAnonymous = req.body.anonymous === 'on';

    try {
        const query = `
            INSERT INTO "Idea" (title, description, user_id, category_id, is_anonymous, document_path)
            VALUES ($1, $2, $3, $4, $5, $6)
            RETURNING idea_id
        `;
        const values = [title, description, userId, categoryId, isAnonymous, documentPath];
        const result = await pool.query(query, values);

        res.send(`Idea submitted successfully with ID: ${result.rows[0].idea_id}`);
    } catch (error) {
        console.error('Error submitting idea:', error);
        res.status(500).send('Error submitting idea');
    }
});

// Start the server directly in app.js
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});

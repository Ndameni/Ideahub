// routes/ideas.js
const express = require('express');
const authenticateUser = require('../middleware/authMiddleware'); // Import the middleware
const router = express.Router();
const pool = require('../db'); // Adjust the path if necessary

// GET route to fetch ideas with pagination
router.get('/', async (req, res) => {
    const page = parseInt(req.query.page) || 1; 
    const itemsPerPage = 5;
    const offset = (page - 1) * itemsPerPage;

    try {
        const ideasQuery = `
            SELECT idea_id, title, description, user_id, submit_date 
            FROM ideas 
            ORDER BY submit_date DESC 
            LIMIT $1 OFFSET $2`;
        
        const ideasResult = await pool.query(ideasQuery, [itemsPerPage, offset]);
        res.status(200).json({ ideas: ideasResult.rows });
    } catch (error) {
        console.error('Error fetching ideas:', error);
        res.status(500).json({ message: 'Failed to retrieve ideas' });
    }
});


module.exports = router;

// Protected route to submit an idea
router.post('/submit', authenticateUser, async (req, res) => {
    const { title, description, categoryId, isAnonymous } = req.body;
    const userId = req.user.userId; // Access user ID from the JWT payload

    try {
        // Query to insert idea into the database
        const query = `INSERT INTO "Idea" (title, description, user_id, category_id, is_anonymous) 
                       VALUES ($1, $2, $3, $4, $5) RETURNING idea_id`;

        const result = await pool.query(query, [title, description, userId, categoryId, isAnonymous]);

        res.json({ message: 'Idea submitted successfully', ideaId: result.rows[0].idea_id });
    } catch (error) {
        console.error('Error submitting idea:', error);
        res.status(500).json({ message: 'Error submitting idea' });
    }
});

module.exports = router;



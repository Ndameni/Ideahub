// auth.js
const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const path = require('path');
const { pool } = require('./db'); // Correctly importing the pool
require('dotenv').config();
const router = express.Router();

// Get the JWT secret from environment variables
const jwtSecret = process.env.JWT_SECRET;

// Route to serve signup page
router.get('/signup', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'SignUp.html'));
});

// Route to serve login page
router.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'Login.html')); // Serve Login.html for /auth/login
});

// Signup Route for user registration
router.post('/signup', async (req, res) => {
    try {
        const { name, email, password, department } = req.body;

        // Basic input validation
        if (!email || !password || !name || !department) {
            return res.status(400).json({ message: 'All fields are required' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const defaultRole = 6; // For ordinary user 

        const query = 'INSERT INTO "Users" (name, email, department_id, defaultRole, password) VALUES ($1, $2, $3, $4, $5) RETURNING user_id';
        const values = [name, email, hashedPassword, department, defaultRole];
        const result = await pool.query(query, values);

        res.status(201).json({ message: 'User registered successfully', user: result.rows[0] });
    } catch (error) {
        console.error("Signup failed:", error); // Improved error logging
        res.status(500).json({ message: 'Sign-up failed', error });
    }
});

// Login Route
router.post('/login', async (req, res) => {
    try {
        const { email, password } = req.body;

        // Input validation
        if (!email || !password) {
            return res.status(400).json({ message: 'Email and password are required' });
        }

        console.log(`Received login request for email: ${email}`);

        const query = 'SELECT * FROM "Users" WHERE email = $1';
        const userResult = await pool.query(query, [email]);

        if (userResult.rows.length === 0) {
            console.log('User not found');
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        const user = userResult.rows[0];

        if (await bcrypt.compare(password, user.password)) {
            const token = jwt.sign({ userId: user.user_id, role: user.role_id }, jwtSecret, { expiresIn: '1h' });
            console.log(`Login successful for user: ${email}`);
            res.json({ message: 'Login successful', token });
        } else {
            console.log('Incorrect password');
            res.status(401).json({ message: 'Invalid credentials' });
        }
    } catch (error) {
        console.error("Login failed:", error); // Improved error logging
        res.status(500).json({ message: 'Login failed', error });
    }
});

module.exports = router;

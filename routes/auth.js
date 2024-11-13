const express = require('express');
const jwt = require('jsonwebtoken');
const path = require('path');
const pool = require('../db'); // Updated to match modular folder structure
const { hashPassword } = require('../scripts/hashPassword'); // Import the hash function
const bcrypt = require('bcrypt');
const router = express.Router();

// JWT secret from environment variables
const jwtSecret = process.env.JWT_SECRET || 'secret'; // Always load from env

// Route to serve signup page
router.get('/signup', (req, res) => {
    res.sendFile(path.join(__dirname, '../views', 'SignUp.html'));
});

// Signup Route for user registration
router.post('/signup', async (req, res) => {
    try {
        const { name, email, password, department } = req.body;

        // Validate inputs
        if (!email || !password || !name || !department) {
            return res.status(400).json({ message: 'All fields are required' });
        }

        // Use helper script for password hashing
        const hashedPassword = await hashPassword(password);
        const defaultRole = 6;

        // Insert the new user
        const query = 'INSERT INTO "Users" (name, email, department_id, role_id, password) VALUES ($1, $2, $3, $4, $5) RETURNING user_id';
        const values = [name, email, department, defaultRole, hashedPassword];
        const result = await pool.query(query, values);

        // Generate token for the user
        const token = jwt.sign({ userId: result.rows[0].user_id, role: defaultRole }, jwtSecret, { expiresIn: '1h' });
        
        // Set the token in a cookie and redirect to the dashboard
        res
            .cookie('token', token, { httpOnly: true, maxAge: 3600000 }) // Cookie valid for 1 hour
            .redirect('/userdashboard.html'); // Redirect to user dashboard
    } catch (error) {
        console.error("Signup failed:", error);
        res.status(500).json({ message: 'Sign-up failed', error });
    }
});

// Route to serve login page
router.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, '../views', 'Login.html'));
});

// Login Route
router.post('/login', async (req, res) => {
    console.log('Login request received');  // This will confirm if the route is hit
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            return res.status(400).json({ message: 'Email and password are required' });
        }

        const query = 'SELECT * FROM "Users" WHERE email = $1';
        const userResult = await pool.query(query, [email]);

        if (userResult.rows.length === 0) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        const user = userResult.rows[0];
        const passwordMatch = await bcrypt.compare(password, user.password);

        if (passwordMatch) {
            const token = jwt.sign({ userId: user.user_id, role: user.role_id }, jwtSecret, { expiresIn: '1h' });

            // Set the token in a cookie
            res.cookie('token', token, { httpOnly: true, maxAge: 3600000 });

            // Role-based redirection based on email
            let redirectPath = '/userdashboard.html';  // Default for regular users
            if (email === 'admin@ideahub.com') {
                redirectPath = '/admin-dashboard.html';
            } else if (email === 'manager@ideahub.com') {
                redirectPath = '/ManagerView/ManagerDashboard.html';
            } else if (email === 'coordinator@ideahub.com') {
                redirectPath = '/CoordinatorView/CoordinatorDashboard.html';
            }

            return res.json({ message: 'Login successful', redirect: redirectPath });
        } else {
            res.status(401).json({ message: 'Invalid credentials' });
        }
    } catch (error) {
        console.error("Login failed:", error);
        res.status(500).json({ message: 'Login failed', error });
    }
});

module.exports = router;

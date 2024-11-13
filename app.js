// const express = require('express');
// const path = require('path');
// const cors = require('cors');
// const multer = require('multer');
// const authRoutes = require('./routes/auth'); // Auth routes
// const userRoutes = require('./routes/user'); // User routes
// const ideaRoutes = require('./routes/ideas'); // Idea routes
// const authenticateUser = require('./middleware/authMiddleware'); // Authentication middleware

// const app = express();
// const port = process.env.PORT || 3000;

// // Middleware
// app.use(express.json());
// app.use(express.urlencoded({ extended: true }));
// app.use(cors());
// app.use('/css', express.static(path.join(__dirname, 'css')));
// app.use(express.static(path.join(__dirname, 'views')));

// // Routes
// app.use('/auth', authRoutes);
// app.use('/user', authenticateUser, userRoutes); // Protected routes for user
// app.use('/idea', authenticateUser, ideaRoutes); // Protected routes for ideas

// // Default route redirects to login
// app.get('/', (req, res) => res.redirect('/auth/login'));

// // Start the server
// app.listen(port, () => console.log(`Server running on http://localhost:${port}`));


const express = require('express');
const path = require('path');
const cors = require('cors');
const bodyParser = require('body-parser'); // Added body-parser middleware
const authRoutes = require('./routes/auth'); // Auth routes
const userRoutes = require('./routes/user'); // User routes
const ideaRoutes = require('./routes/ideas'); // Idea routes
const authenticateUser = require('./middleware/authMiddleware'); // Authentication middleware

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json()); // Middleware to parse JSON request bodies
app.use(express.urlencoded({ extended: true })); // Middleware for URL-encoded data
app.use('/css', express.static(path.join(__dirname, 'css'))); // Serve static files
app.use(express.static(path.join(__dirname, 'views'))); // Serve static files (like HTML files)

// Routes
app.use('/auth', authRoutes); // Public authentication routes
app.use('/user', authenticateUser, userRoutes); // Protected routes for user (requires JWT)
app.use('/ideas', authenticateUser, ideaRoutes); // Protected routes for ideas (requires JWT)


// Default route serves the welcome page
app.get('/', (req, res) => res.sendFile(path.join(__dirname, 'views', 'welcome.html')));


// Start the server
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});


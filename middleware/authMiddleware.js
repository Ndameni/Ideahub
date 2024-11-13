const jwt = require('jsonwebtoken');
const jwtSecret = process.env.JWT_SECRET || 'secret';

// Middleware to authenticate JWT token
function authenticateUser(req, res, next) {
    const token = req.header('Authorization')?.split(' ')[1];
    if (!token) return res.status(403).json({ message: 'Access denied' });

    try {
        const decoded = jwt.verify(token, jwtSecret);
        req.user = decoded; // Set decoded token info (e.g., userId, role) in req.user
        next();
    } catch (error) {
        res.status(400).json({ message: 'Invalid token' });
    }
}

module.exports = authenticateUser;



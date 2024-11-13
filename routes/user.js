const express = require('express');
const path = require('path');
const router = express.Router();

// Serve User Dashboard
router.get('/dashboard', (req, res) => {
    res.sendFile(path.join(__dirname, '../views', 'UserDashboard.html'));
});

module.exports = router;

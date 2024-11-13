const bcrypt = require('bcrypt');

// async function hashPassword(password) {
//     return await bcrypt.hash(password, 10);
// }

// module.exports = hashPassword;

async function hashPassword(password) {
    const saltRounds = 10;
    return await bcrypt.hash(password, saltRounds);
}

module.exports = { hashPassword };

onst pg = require('pg');
const bcrypt = require('bcrypt');
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const cors = require('cors');

const port = 3000;

const pool = new pg.Pool({
    user: 'secadv',
    host: 'db',
    database: 'pxldb',
    password: 'ilovesecurity',
    port: 5432,
    connectionTimeoutMillis: 5000
});

console.log("Connecting...:");

app.use(cors({ origin: 'http://localhost:8080' }));
app.use(bodyParser.json());
app.use(
    bodyParser.urlencoded({
        extended: true,
    })
);

app.get('/authenticate/:username/:password', async (request, response) => {
    const username = request.params.username;
    const password = request.params.password;

    const query = `SELECT * FROM users WHERE user_name=$1`;
    try {
        const result = await pool.query(query, [username]);
        const user = result.rows[0];
        if (!user) {
            response.status(401).json({ message: "Authentication failed. User not found." });
            return;
        }
        const hashedPassword = user.password;

        const match = await bcrypt.compare(password, hashedPassword);
        if (match) {
            response.status(200).json({ message: "Authentication successful." });
        } else {
            response.status(401).json({ message: "Authentication failed. Incorrect password." });
        }
    } catch (error) {
        console.error("Error while authenticating:", error);
        response.status(500).json({ message: "Internal server error." });
    }
});

app.listen(port, () => {
    console.log(`App running on port ${port}.`);
});

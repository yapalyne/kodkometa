const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const db = require('../db');

// ======================
// РЕГИСТРАЦИЯ
// ======================

router.post('/register', async (req, res) => {

    const { username, email, password } = req.body;

    try {

        const existingUsers = await new Promise((resolve, reject) => {
            db.query('SELECT * FROM users WHERE email = ?', [email], (err, results) => {
                if (err) reject(err);
                else resolve(results);
            });
        });

        if (existingUsers.length > 0) {
            return res.status(400).json('User already exists');
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        const result = await new Promise((resolve, reject) => {
            db.query(
                'INSERT INTO users(username, email, password) VALUES (?, ?, ?)',
                [username, email, hashedPassword],
                (err, result) => {
                    if (err) reject(err);
                    else resolve(result);
                }
            );
        });

        const userId = result.insertId;

        const courseMap = {
            'html': 1,
            'css': 2,
            'js': 3,
            'ts': 4,
            'react': 5,
            'vue': 6,
            'angular': 7
        };

        for (const [course, courseId] of Object.entries(courseMap)) {

            const topics = await new Promise((resolve, reject) => {
                db.query(
                    'SELECT id FROM topics WHERE course_id = ? ORDER BY topic_order ASC',
                    [courseId],
                    (err, results) => {
                        if (err) reject(err);
                        else resolve(results);
                    }
                );
            });

            for (let i = 0; i < topics.length; i++) {
                await new Promise((resolve, reject) => {
                    db.query(
                        `INSERT INTO user_progress (user_id, topic_id, completed, unlocked, completed_at, course)
                         VALUES (?, ?, 0, ?, null, ?)`,
                        [userId, topics[i].id, i === 0 ? 1 : 0, course],
                        (err) => {
                            if (err) reject(err);
                            else resolve();
                        }
                    );
                });
            }
        }

        res.json({
            message: 'User registered',
            user: {
                id: userId,
                username: username,
                email: email
            }
        });

    } catch (error) {
        console.log(error);
        res.status(500).json('Server error');
    }

});

// ======================
// ЛОГИН
// ======================

router.post('/login', (req, res) => {

    const { email, password } = req.body;

    db.query(
        'SELECT * FROM users WHERE email = ?',
        [email],
        async (err, results) => {

            if (err) {
                console.log(err);
                return res.status(500).json('Database error');
            }

            if (results.length === 0) {
                return res.status(404).json('User not found');
            }

            const user = results[0];

            const isMatch = await bcrypt.compare(password, user.password);

            if (!isMatch) {
                return res.status(401).json('Wrong password');
            }

            res.json({
                message: 'Login successful',
                user: {
                    id: user.id,
                    username: user.username,
                    email: user.email,
                    level: user.level,
                    exp: user.exp,
                    streak: user.streak
                }
            });

        }
    );

});

module.exports = router;
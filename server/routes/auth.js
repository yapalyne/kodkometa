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

        db.query(
            'SELECT * FROM users WHERE email = ?',
            [email],

            async (err, results) => {

                if(err){
                    console.log(err);
                    return res.status(500).json('Database error');
                }

                if(results.length > 0){
                    return res.status(400).json('User already exists');
                }

                const hashedPassword =
                    await bcrypt.hash(password, 10);

                db.query(

                    'INSERT INTO users(username, email, password) VALUES (?, ?, ?)',

                    [username, email, hashedPassword],

                    (err, result) => {

                        if(err){
                            console.log(err);
                            return res.status(500).json('Database error');
                        }

                        const userId =
                            result.insertId;

                        const courses = [

                            'html',
                            'css',
                            'js',
                            'ts',
                            'react',
                            'vue',
                            'angular'

                        ];

                        courses.forEach(course => {

                            for(let i = 1; i <= 13; i++) {

                                db.query(

                                    `INSERT INTO user_progress
                                    (
                                        user_id,
                                        topic_id,
                                        completed,
                                        unlocked,
                                        completed_at,
                                        course
                                    )

                                    VALUES (?, ?, ?, ?, ?, ?)`,

                                    [

                                        userId,

                                        i,

                                        0,

                                        i === 1 ? 1 : 0,

                                        null,

                                        course

                                    ]

                                );

                            }

                        });

                        res.json({

                            message: 'User registered',

                            user: {

                                id: userId,

                                username: username,

                                email: email

                            }

                        });

                    }

                );

            }

        );

    }

    catch(error){

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

            if(err){
                console.log(err);
                return res.status(500).json('Database error');
            }

            // Пользователь не найден
            if(results.length === 0){
                return res.status(404).json('User not found');
            }

            const user = results[0];

            // Проверка пароля
            const isMatch = await bcrypt.compare(password, user.password);

            if(!isMatch){
                return res.status(401).json('Wrong password');
            }

            // Успешный вход
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
const express = require('express');

const router = express.Router();

const db = require('../db');


// ======================
// ПОЛУЧИТЬ ПРОГРЕСС КУРСА
// ======================

router.get('/:userId/:course', (req, res) => {

    const { userId, course } = req.params;

    db.query(
        `
        SELECT * FROM user_progress
        WHERE user_id = ?
        AND course = ?
        `,
        [userId, course],
        (err, results) => {

            if(err){
                console.log(err);
                return res.status(500).json('Database error');
            }

            res.json(results);

        }
    );

});


// ======================
// ЗАВЕРШИТЬ ТЕМУ
// ======================

router.post('/complete', (req, res) => {

    const { userId, course } = req.body;

    const topicId = Number(req.body.topicId);
    const score = Number(req.body.score) || 0;

    db.query(
        `
        UPDATE user_progress
        SET completed = 1,
        completed_at = NOW(),
        score = ?
        WHERE user_id = ?
        AND topic_id = ?
        AND course = ?
        `,
        [score, userId, topicId, course],
        (err, result) => {

            if(err){
                console.log(err);
                return res.status(500).json('Database error');
            }

        console.log('UPDATED ROWS:', result.affectedRows);
        console.log(userId, topicId, course);

            db.query(
                `
                UPDATE user_progress
                SET unlocked = 1
                WHERE user_id = ?
                AND topic_id = ?
                AND course = ?
                `,
                [userId, topicId + 1, course],
                (err2) => {

                    if(err2){
                        console.log(err2);
                        return res.status(500).json('Database error');
                    }

                    res.json({
                        message: 'Topic completed'
                    });

                }
            );

        }
    );

});

// ======================
// СОХРАНИТЬ SCORE (без изменения completed/unlocked)
// ======================

router.post('/score', (req, res) => {

    const { userId, course } = req.body;

    const topicId = Number(req.body.topicId);
    const score = Number(req.body.score) || 0;

    db.query(
        `
        UPDATE user_progress
        SET score = ?
        WHERE user_id = ?
        AND topic_id = ?
        AND course = ?
        `,
        [score, userId, topicId, course],
        (err) => {

            if(err){
                console.log(err);
                return res.status(500).json('Database error');
            }

            res.json({ message: 'Score saved' });

        }
    );

});

module.exports = router;
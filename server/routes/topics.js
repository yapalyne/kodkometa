const express = require('express');

const router = express.Router();

const db = require('../db');


// ======================
// ПОЛУЧИТЬ ТЕМЫ КУРСА
// ======================

router.get('/:courseId', (req, res) => {

    const courseId = req.params.courseId;

    db.query(
        'SELECT * FROM topics WHERE course_id = ? ORDER BY topic_order ASC',
        [courseId],
        (err, results) => {

            if(err){
                console.log(err);
                return res.status(500).json('Database error');
            }

            res.json(results);

        }
    );

});

module.exports = router;
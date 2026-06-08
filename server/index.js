const express = require('express');
const cors = require('cors');
const path = require('path');

const db = require('./db');

const authRoutes = require('./routes/auth');
const topicsRoutes = require('./routes/topics');
const progressRoutes = require('./routes/progress');

const app = express();

app.get('/healthz', (req, res) => {
    res.status(200).send('ok');
});

app.use(cors({ origin: '*' }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/auth', authRoutes);
app.use('/topics', topicsRoutes);
app.use('/progress', progressRoutes);

app.get('/fix-progress/:userId', async (req, res) => {
    const { userId } = req.params;

    try {
        const topics = await new Promise((resolve, reject) => {
            db.query('SELECT * FROM topics ORDER BY course_id, topic_order', (err, rows) => {
                if (err) reject(err); else resolve(rows);
            });
        });

        const courses = await new Promise((resolve, reject) => {
            db.query('SELECT * FROM courses', (err, rows) => {
                if (err) reject(err); else resolve(rows);
            });
        });

        const courseMap = {};
        for (const c of courses) {
            courseMap[c.id] = c.title;
        }

        for (const topic of topics) {
            const courseName = courseMap[topic.course_id];
            const unlocked = topic.topic_order === 1 ? 1 : 0;

            await new Promise((resolve, reject) => {
                db.query(
                    `INSERT IGNORE INTO user_progress (user_id, topic_id, course, completed, unlocked)
                     VALUES (?, ?, ?, 0, ?)`,
                    [userId, topic.id, courseName, unlocked],
                    (err) => { if (err) reject(err); else resolve(); }
                );
            });
        }

        res.send(`Progress fixed for user ${userId}!`);
    } catch (e) {
        res.status(500).send(e.message);
    }
});

app.use(express.static(path.join(__dirname, '../client')));
app.use(express.static(path.join(__dirname, '../client/js')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../client/js/home.html'));
});

app.get('/test', (req, res) => {
    res.send('CORS WORKS');
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server started on port ${PORT}`);
});
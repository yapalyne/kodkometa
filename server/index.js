const express = require('express');
const cors = require('cors');

require('./db');

const authRoutes = require('./routes/auth');
const topicsRoutes = require('./routes/topics');
const progressRoutes = require('./routes/progress');

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/auth', authRoutes);
app.use('/topics', topicsRoutes);
app.use('/progress', progressRoutes);

app.get('/', (req, res) => {
    res.send('Server works!');
});

app.get('/test', (req, res) => {
    res.send('CORS WORKS');
});

app.listen(3000, () => {
    console.log('Server started on port 3000');
});
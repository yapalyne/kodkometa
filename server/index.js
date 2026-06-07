const express = require('express');
const cors = require('cors');
const path = require('path');

require('./db');

const authRoutes = require('./routes/auth');
const topicsRoutes = require('./routes/topics');
const progressRoutes = require('./routes/progress');

const app = express();

// Healthcheck
app.get('/healthz', (req, res) => {
    res.status(200).send('ok');
});

app.use(cors({ origin: '*' }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// API
app.use('/auth', authRoutes);
app.use('/topics', topicsRoutes);
app.use('/progress', progressRoutes);

// Раздача фронтенда
app.use(express.static(path.join(__dirname, '../client')));
app.use(express.static(path.join(__dirname, '../client/js')));

// Главная страница сайта
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
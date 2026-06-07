const express = require('express');
const cors = require('cors');

require('./db');

const authRoutes = require('./routes/auth');
const topicsRoutes = require('./routes/topics');
const progressRoutes = require('./routes/progress');

const app = express();

// Healthcheck ДО всех middleware
app.get('/healthz', (req, res) => {
    res.status(200).send('ok');
});

app.use(cors({ origin: '*' }));
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

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server started on port ${PORT}`);
});
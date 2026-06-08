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

app.get('/init-topics', async (req, res) => {
    const topics = [
        // CSS (course_id=2)
        { course_id: 2, name: 'Основы CSS',               topic_order: 1 },
        { course_id: 2, name: 'Селекторы',                topic_order: 2 },
        { course_id: 2, name: 'Бокс-модель',              topic_order: 3 },
        { course_id: 2, name: 'Флексбокс',                topic_order: 4 },
        { course_id: 2, name: 'Гриды',                    topic_order: 5 },
        { course_id: 2, name: 'Цвета и фон',              topic_order: 6 },
        { course_id: 2, name: 'Текст и шрифты',           topic_order: 7 },
        { course_id: 2, name: 'Анимации',                 topic_order: 8 },
        { course_id: 2, name: 'Трансформации',            topic_order: 9 },
        { course_id: 2, name: 'Переходы',                 topic_order: 10 },
        { course_id: 2, name: 'Медиа-запросы',            topic_order: 11 },
        { course_id: 2, name: 'Адаптивный дизайн',        topic_order: 12 },
        { course_id: 2, name: 'Современные возможности',  topic_order: 13 },

        // JS (course_id=3)
        { course_id: 3, name: 'Основы JS',                topic_order: 1 },
        { course_id: 3, name: 'Типы данных',              topic_order: 2 },
        { course_id: 3, name: 'Функции',                  topic_order: 3 },
        { course_id: 3, name: 'Массивы',                  topic_order: 4 },
        { course_id: 3, name: 'Объекты',                  topic_order: 5 },
        { course_id: 3, name: 'DOM',                      topic_order: 6 },
        { course_id: 3, name: 'События',                  topic_order: 7 },
        { course_id: 3, name: 'Асинхронность',            topic_order: 8 },
        { course_id: 3, name: 'Fetch и API',              topic_order: 9 },
        { course_id: 3, name: 'Классы',                   topic_order: 10 },
        { course_id: 3, name: 'Модули',                   topic_order: 11 },
        { course_id: 3, name: 'Обработка ошибок',         topic_order: 12 },
        { course_id: 3, name: 'Современный JS',           topic_order: 13 },

        // TypeScript (course_id=4)
        { course_id: 4, name: 'Основы TS',                topic_order: 1 },
        { course_id: 4, name: 'Типы',                     topic_order: 2 },
        { course_id: 4, name: 'Интерфейсы',               topic_order: 3 },
        { course_id: 4, name: 'Классы',                   topic_order: 4 },
        { course_id: 4, name: 'Дженерики',                topic_order: 5 },
        { course_id: 4, name: 'Декораторы',               topic_order: 6 },
        { course_id: 4, name: 'Модули',                   topic_order: 7 },
        { course_id: 4, name: 'Утилитарные типы',         topic_order: 8 },
        { course_id: 4, name: 'Типы функций',             topic_order: 9 },
        { course_id: 4, name: 'Объединения и пересечения',topic_order: 10 },
        { course_id: 4, name: 'Конфигурация',             topic_order: 11 },
        { course_id: 4, name: 'Интеграция с JS',          topic_order: 12 },
        { course_id: 4, name: 'Продвинутые типы',         topic_order: 13 },

        // React (course_id=5)
        { course_id: 5, name: 'Основы React',             topic_order: 1 },
        { course_id: 5, name: 'JSX',                      topic_order: 2 },
        { course_id: 5, name: 'Компоненты',               topic_order: 3 },
        { course_id: 5, name: 'Props',                    topic_order: 4 },
        { course_id: 5, name: 'State',                    topic_order: 5 },
        { course_id: 5, name: 'Хуки',                     topic_order: 6 },
        { course_id: 5, name: 'Эффекты',                  topic_order: 7 },
        { course_id: 5, name: 'Контекст',                 topic_order: 8 },
        { course_id: 5, name: 'Маршрутизация',            topic_order: 9 },
        { course_id: 5, name: 'Формы',                    topic_order: 10 },
        { course_id: 5, name: 'Оптимизация',              topic_order: 11 },
        { course_id: 5, name: 'Тестирование',             topic_order: 12 },
        { course_id: 5, name: 'Продвинутые паттерны',     topic_order: 13 },

        // Vue (course_id=6)
        { course_id: 6, name: 'Основы Vue',               topic_order: 1 },
        { course_id: 6, name: 'Шаблоны',                  topic_order: 2 },
        { course_id: 6, name: 'Компоненты',               topic_order: 3 },
        { course_id: 6, name: 'Props и события',          topic_order: 4 },
        { course_id: 6, name: 'Реактивность',             topic_order: 5 },
        { course_id: 6, name: 'Вычисляемые свойства',     topic_order: 6 },
        { course_id: 6, name: 'Директивы',                topic_order: 7 },
        { course_id: 6, name: 'Жизненный цикл',           topic_order: 8 },
        { course_id: 6, name: 'Роутер',                   topic_order: 9 },
        { course_id: 6, name: 'Pinia',                    topic_order: 10 },
        { course_id: 6, name: 'Композиция',               topic_order: 11 },
        { course_id: 6, name: 'Анимации',                 topic_order: 12 },
        { course_id: 6, name: 'Оптимизация',              topic_order: 13 },

        // Angular (course_id=7)
        { course_id: 7, name: 'Основы Angular',           topic_order: 1 },
        { course_id: 7, name: 'Компоненты',               topic_order: 2 },
        { course_id: 7, name: 'Шаблоны',                  topic_order: 3 },
        { course_id: 7, name: 'Директивы',                topic_order: 4 },
        { course_id: 7, name: 'Сервисы',                  topic_order: 5 },
        { course_id: 7, name: 'Dependency Injection',     topic_order: 6 },
        { course_id: 7, name: 'Роутинг',                  topic_order: 7 },
        { course_id: 7, name: 'Формы',                    topic_order: 8 },
        { course_id: 7, name: 'HTTP клиент',              topic_order: 9 },
        { course_id: 7, name: 'RxJS',                     topic_order: 10 },
        { course_id: 7, name: 'Pipes',                    topic_order: 11 },
        { course_id: 7, name: 'Тестирование',             topic_order: 12 },
        { course_id: 7, name: 'Оптимизация',              topic_order: 13 },
    ];

    try {
        for (const topic of topics) {
            await new Promise((resolve, reject) => {
                db.query(
                    'INSERT IGNORE INTO topics (course_id, name, topic_order) VALUES (?, ?, ?)',
                    [topic.course_id, topic.name, topic.topic_order],
                    (err) => { if (err) reject(err); else resolve(); }
                );
            });
        }
        res.send('Topics created! Now delete this route and push again.');
    } catch(e) {
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

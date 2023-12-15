const express = require('express');
const { addUser, getAllUsers } = require('../data/users');
const router = express.Router();
const userData = require('../data/users'); // Temporary users file for testing purposes. Remove when database is complete.
const users = getAllUsers();
// const dal = require('../data/dal');

// For logging
const fs = require('fs');
const path = require('path');

router.use((req, res, next) => {
    if (!req.session || !req.session.user) {
        if (req.url !== '/login') {
            return res.redirect('/login');
        }
    }
    next();
});

router.get('/', async (req, res) => {
    user = req.session.user;
    try {
        res.render('index', { pageTitle: 'Index', user });
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error');
    }
});

router.post('/log', async (req, res) => {
    const { testLogging } = req.body;
    console.log(testLogging);
    const username = req.session.user.username;
    const currentDate = new Date();
    const dateString = currentDate.toISOString().split('T')[0];

    const logData = `${currentDate.toISOString()} | ${username} | ${testLogging}\n`;

    const logFileName = `/logs/log_${dateString}.txt`;
    const logFilePath = path.join(__dirname, '..', logFileName);

    const logsFolder = path.join(__dirname, '..', 'logs');
    if (!fs.existsSync(logsFolder)) {
        fs.mkdirSync(logsFolder);
    }

    fs.appendFileSync(logFilePath, logData);

    res.redirect('/');
})

router.get('/login', async (req, res) => {
    user = req.session.user;
    try {
        res.render('login', { pageTitle: 'Login',  message: '', user });
        console.log(users);
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
    }
});

router.post('/login', async (req, res) => {
    const { username, password } = req.body;

    const user = users.find(u => u.username === username && u.password === password);

    if (user) {
        req.session.user = user;
        res.redirect('/');
    } else {
        res.render('login', { pageTitle: 'Login', message: 'Invalid username or password' });
    }
});

router.get('/register', async (req, res) => {
    user = req.session.user;
    try {
        res.render('register', { pageTitle: 'Register', user });
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
    }
});

router.post('/register', async (req, res) => {
    const { username, password, email } = req.body;

    const newUser = {
        id: users.length + 1,
        username,
        password,
        email
    };

    
    // Doesn't properly add users to the array.
    addUser(newUser);
    console.log(users);

    req.session.user = newUser;
    res.redirect('/');
});

router.get('/logout', async (req, res) => {
    req.session.destroy((err) => {
        if (err) {
            console.log(err);
            res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
        } else {
            res.redirect('/');
        }
    });
})

module.exports = router;
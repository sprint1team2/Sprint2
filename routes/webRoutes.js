const express = require('express');
const router = express.Router();
const dal = require('../data/dal');

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

    console.log(logData);
});

router.get('/results', async (req, res) => {
    try {
        user = req.session.user;
        const db = req.query.dbselect;
        const query = req.query.query;
        let results;

        logSearch(user.username, query);

        if (db === 'postgres') {
            results = await dal.findMoviesByRegexPostgres(query);
            console.log("Querying Postgres");
        } else if (db === 'mongo') {
            results = await dal.findMoviesByRegexMongo(query);
            console.log("Querying Mongo");
        } else {
            postgresResults = await dal.findMoviesByRegexPostgres(query);
            mongoResults = await dal.findMoviesByRegexMongo(query);
            console.log("Querying Postgres and Mongo");

            results = [...postgresResults, ...mongoResults];
        }

        const standardizeResults = (results) => {
            return results.map(result => {
                return Object.keys(result).reduce((acc, key) => {
                    acc[key.toLowerCase()] = result[key];
                    return acc;
                }, {});
            });
        };

        results = standardizeResults(results);
    
        res.render('results', { pageTitle: 'Results', user, db, query, results });

        } catch (error) {
            console.log(error);
            res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
        }
});

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
        res.render('register', { pageTitle: 'Register', message: '', user });
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
    }
});

router.post('/register', async (req, res) => {
    const { username, password, email, firstName, lastName } = req.body;

    // Make sure username and email are unique
    if (await dal.findUserByUsernamePostgres(username)) {
        res.render('register', { pageTitle: 'Register', message: 'Username already exists', user });
        return;
    }

    if (await dal.findUserByEmailPostgres(email)) {
        res.render('register', { pageTitle: 'Register', message: 'Email already exists', user });
        return;
    }

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
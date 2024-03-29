const express = require('express');
const router = express.Router();
const dal = require('../data/dal');

// For logging
const fs = require('fs');
const path = require('path');

router.use((req, res, next) => {
    if (!req.session || !req.session.user) {
        if (req.url !== '/login' && req.url !== '/register') {
            return res.redirect('/login');
        }
    }
    next();
});

router.get('/', async (req, res) => {
    user = req.session.user;
    try {
        res.render('index', { user });
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error');
    }
});

function logSearch(username, query) {
    const currentDate = new Date();
    const dateString = currentDate.toISOString().split('T')[0];

    const logData = `${currentDate.toISOString()} | ${username} | ${query}\n`;

    const logFileName = `/logs/log_${dateString}.txt`;
    const logFilePath = path.join(__dirname, '..', logFileName);

    const logsFolder = path.join(__dirname, '..', 'logs');

    if (!fs.existsSync(logsFolder)) {
        fs.mkdirSync(logsFolder);
    }

    fs.appendFileSync(logFilePath, logData);

    console.log(logData);
}

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
    
        res.render('results', { user, db, query, results });

        } catch (error) {
            console.log(error);
            res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
        }
})

router.get('/login', async (req, res) => {
    user = req.session.user;
    try {
        res.render('login', { message: '', user });
        // console.log(users);
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
    }
});

router.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;

        const user = await dal.authenticateUserPostgres(username, password);

        if (!user) {
            res.render('login', { message: 'Invalid username or password', user });
            return;
        }

        req.session.user = user;
        res.redirect('/');
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
    }
});

router.get('/register', async (req, res) => {
    user = req.session.user;
    try {
        res.render('register', { message: '', user });
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
    }
});

router.post('/register', async (req, res) => {
    const { username, password, email, firstName, lastName } = req.body;

    // Make sure username and email are unique
    if (await dal.findUserByUsernamePostgres(username)) {
        res.render('register', { message: 'Username already exists', user });
        return;
    }

    if (await dal.findUserByEmailPostgres(email)) {
        res.render('register', { message: 'Email already exists', user });
        return;
    }

    try {
        const newUser = {
            Username: username,
            Password: password,
            Email: email,
            FirstName: firstName,
            LastName: lastName
        }

        const user = await dal.registerUserPostgres(newUser);

        req.session.user = user;

        res.redirect('/');
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
    }
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
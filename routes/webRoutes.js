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
        res.render('index', { pageTitle: 'Movie Search Engine', user });
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error');
    }
});

// router.get('/search', async (req, res) => {
//     user = req.session.user;
//     const database = req.query.dbselect;
//     const query = req.query.query;

//     logSearch(user.username, query);

//     try {
//         res.redirect(`/results?db=${database}&query=${query}`, { pageTitle: 'Results', user });
//     } catch (error) {
//         console.log(error);
//         res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
//     }
// })

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
        let results = [];

        console.log("TEST: " + db + " " + query + " " + user.username);

        logSearch(user.username, query);

        if (db === 'postgres') {
            results = await dal.findMoviesByRegexPostgres(query);
        } else if (db === 'mongo') {
            results = await dal.findMoviesByRegexMongo(query);
        } else {
            // If both databases are selected...
        }
    
        console.log(results);
        res.render('results', { pageTitle: 'Results', user, db, query, results });

        } catch (error) {
            console.log(error);
            res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
        }
})

router.get('/login', async (req, res) => {
    user = req.session.user;
    try {
        res.render('login', { pageTitle: 'Login',  message: '', user });
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
            res.render('login', { pageTitle: 'Login', message: 'Invalid username or password', user });
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
        res.render('register', { pageTitle: 'Register', user });
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error<br><a href="/">Home</a>');
    }
});

router.post('/register', async (req, res) => {
    const { username, password, email, firstName, lastName } = req.body;

    // Make sure username and email are unique

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
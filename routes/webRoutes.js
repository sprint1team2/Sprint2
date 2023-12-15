const express = require('express');
const { addUser } = require('../data/users');
const router = express.Router();
const usersData = require('../data/users'); // Temporary users file for testing purposes. Remove when database is complete.
const users = usersData.users;
// const dal = require('../data/dal');

router.get('/', async (req, res) => {
    user = req.session.user;
    try {
        res.render('index', { pageTitle: 'Index', user });
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/login', async (req, res) => {
    user = req.session.user;
    try {
        res.render('login', { pageTitle: 'Login', user });
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
        res.render('login', { pageTitle: 'Login', error: 'Invalid username or password' });
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

    addUser(newUser);

    res.session.user = newUser;
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
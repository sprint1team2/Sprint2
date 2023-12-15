const express = require('express');
const router = express.Router();
// const dal = require('../data/dal');

router.get('/', async (req, res) => {
    try {
        res.render('index');
    } catch (error) {
        console.log(error);
        res.status(500).send('Internal Server Error');
    }
});

module.exports = router;
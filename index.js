const express = require('express');
const methodOverride = require('method-override');
const morgan = require('morgan');
const session = require('express-session');
const app = express();
const port = 3000;

app.use(session({
    // May want to move to another file, and may want to make the secret more secure.
    secret: 'asecretpassword',
    resave: false,
    saveUninitialized: true
}));

app.use((req, res, next) => {
    console.log(`Received request: ${req.method} at URL: ${req.url}`);
    next();
});

app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));
app.set('view engine', 'ejs');
app.use(morgan('dev'));
app.use(methodOverride('_method'));

const webRoutes = require('./routes/webRoutes');

app.use('/', webRoutes);

app.listen(port, () => {
    console.log(`Listening on port ${port}!`);
});
////////////// Modules ////////////////////////
require('dotenv').config()
const express = require('express');
const path = require('path');
const db = require('./models');
const apiRoutes = require('./routes/apiRoutes');
const expressSession = require('express-session');
const SessionStore = require('express-session-sequelize')(expressSession.Store)
const cookieParser = require('cookie-parser');
const passport = require('./passport')

// update the config folder with your un and pw. Make sure the DB is created first before server is running



////////////// Configuration //////////////////
const PORT = process.env.PORT || 3001;
const app = express();
app.use(express.urlencoded());
app.use(express.json());
app.use(cookieParser());
app.use(apiRoutes)

db.sequelize.sync({
    force: true
}).then(() => {
    db.Unit.create({
      unitName: "Big Office",
      rate: 90
    });

    const sequelizeSessionStore = new SessionStore({
        db: db.sequelize,
    });
    // app.use(cookieParser());
    app.use(expressSession({
        secret: 'a whop bop baloobop.',
        store: sequelizeSessionStore,
        resave: false,
        saveUninitialized: false,
    }));

    app.use(passport.initialize())
    app.use(passport.session()) // will call the deserializeUser
}).then(() => {
    ////////////// Routing ////////////////////////
    app.use('/auth', require('./auth'));
    app.use('/static', express.static(path.join(__dirname, 'client', 'build', 'static')));
    app.get('*', (req, res) => {
        var indexPath = path.join(__dirname, 'client', 'build', 'index.html');
        res.sendfile(indexPath);

    });

    app.listen(PORT, () => {
        console.log('Listening on port ' + PORT);
    });
})

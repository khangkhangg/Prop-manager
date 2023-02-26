////////////// Modules ////////////////////////
require('dotenv').config()
const moment = require('moment');
moment().format();
const db = require('./models');
const expressSession = require('express-session');
const appSettings = require('./appSettings');
// const enforce = require('express-sslify');



// update the config folder with your un and pw. Make sure the DB is created first before server is running
global.db = db;

db.sequelize.sync(
    { force: true }
).then(() => {
    // Generate default user(s) and settings, when applicable
    return Promise.all([
        appSettings.init(),
        generateDatabaseSeed(),
    ]);
})


/** Seeds the database when applicable. Returns a promise that resolves when the operation is complete. */
function generateDatabaseSeed() {
    if (process.env.NODE_ENV == 'production') {
        return db.User.count()
            .then(count => {
                if (count > 0) return Promise.resolve();
                return db.User.create({
                    fullname: "Administrator",
                    role: "admin",
                    activationCode: "admin",
                    authtype: null,
                    local_username: null,
                    local_password: null,
                    googleId: null,
                    phone: "000-000-0000",
                    email: "none@none.com",
                    address: "none",
                    city: "none",
                    state: "CA",
                    zip: 90210,
                });
            })

    }

    // var newUnitPromise = db.appSettings.create({
    //     name: "PRIVATE_KEY",
    //     value: "",
    // });
    // var newUnitPromise = db.appSettings.create({
    //     name: "DOMAIN",
    //     value: "",
    // });
    var newUnitPromise = db.Unit.create({
        unitName: "Big Office",
        rate: 90
    });
    var newAdminPromise = db.User.create({
        fullname: "admin j. user",
        role: "admin",
        activationCode: "admin",
        authtype: null,
        local_username: 'admin',
        local_password: 'admin',
        googleId: null,
        phone: "000-000-0000",
        email: "fake@web.com",
        address: "none",
        city: "none",
        state: "CA",
        zip: 90210,
    });
    var newTenantPromise = db.User.create({
        fullname: "Freddy McTenant",
        role: "tenant",
        activationCode: "tenant",
        authtype: null,
        local_username: 'tenant',
        local_password: 'tenant',
        googleId: null,
        phone: "000-000-0000",
        email: "fake@mail.com",
        address: "none",
        city: "none",
        state: "CA",
        zip: 90210,
    });
    var newPaymentPromise = db.Payment.create({
        amount: 450,
        paid: false,
        due_date: '2018-04-17 00:58:52',
        UnitId: 1
    });

    return Promise
        .all([newUnitPromise, newAdminPromise, newTenantPromise, newPaymentPromise])
        .then(([newUnit, newAdmin, newTenant]) => {
            newUnit.addUsers([newAdmin, newTenant]);
            // newAdmin.addUnit(newUnit).then(()=>
            //     newTenant.addUnit(newUnit))
        });

}

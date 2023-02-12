/*
    App Settings - Retrieves and updates application settings stored in the database.

    Settings that are not found are retrieved from process.env.
*/

const db = require('./models');


function createDefaultAppSettings() {
    // Names must be unique
    var defaultSettings = [
        // Prepended to any relative paths (e.g. /tenant/activate/code) for display in UI or 
        // in email correspondance.Construct the full path using url.resolve(urlPrefix, relativePath)
        {
            name: 'urlPrefix',
            value: 'http://localhost:3001/',
            description: 'The domain to use in correspondence',
        },
        {
            name: 'appTitle',
            value: 'Tenant Service Portal',
            description: 'Page title',
        },
        {
            name: 'stripeApiKey',
            value: 'pk_test_edJT25Bz1YVCJKIMvmBGCS5Y',
            description: 'Shareable stripe api key',
        },
        {
            name: 'bannerText',
            value: '132 Chapel St',
            description: 'Text to display in the navbar',
        },
        {
            name: 'DOMAIN',
            value: 'mg.propyty.com',
            description: 'mailgun domain',
        },
        {
            name: 'PRIVATE_KEY',
            value: '96ccaab2966f51524690354622d8cf12-d1a07e51-29129807',
            description: 'mailgun private key',
        },
        {
            name: 'GOOGLE_CLIENT_ID',
            value: '65718648734-6287l7c33m77jpm0civ9s2m4qnqv9ges.apps.googleusercontent.com',
            description: 'mailgun private key',
        },
        {
            name: 'GOOGLE_CLIENT_SECRET',
            value: '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',
            description: 'mailgun private key',
        },
    ];

    return db.AppSetting
        .bulkCreate(defaultSettings)
        .then(() => defaultSettings)
        .catch(err => {
            console.error(err);
            process.exit(); // Consider this a fatal error
        });
}

module.exports = {
    /** @type {{name: string, value: string}[]} */
    settings: [],

    /**
     * Returns a promise which resolves when the settings have been loaded from the database.
     */
    init: function () {
        return db.AppSetting.findAll()
            .then(settings => {
                this.settings = settings;
                if (this.settings.length == 0) {
                    return createDefaultAppSettings()
                        .then(defSettings => {
                            this.settings = defSettings;
                        });
                }
            });
    },

    /** Returns an app setting by the specified name
     * @param {string} name - Name of the setting to get
     */
    getSetting: function (name) {
        var setting = this.settings.find(setting => (setting.name == name));
        if (setting) return setting.value;

        // defer to environment if we don't have a setting by the requested name.
        if (process.env[name] !== undefined) return process.env[name];

        // null indicates setting not found
        return null;
    },

    /**
     * Gets all app settings
     */
    getAllSettings: function () {
        return [...(this.settings)];
    },

    /** Returns Promis<{name, value}> when the database is updated.
     *  
     * @param {string} name - Name of the setting to get
     * @param {string} value - Name of the setting to set
     * 
     */
    changeSetting: function (name, value, description) {
        // Find, then update or create new as needed. Then update this.settings
        return db.AppSetting
            .findOne({
                where: { name: name }
            }).then(setting => {
                var attributes = {};
                if (value || value == '') attributes.value = value;
                if (description || description == '') attributes.description = description;

                if (setting) {
                    return setting.update(attributes);
                } else {
                    attributes.name = name;
                    return db.AppSetting.create(attributes);
                }
            }).then(setting => {
                var newSetting = { name: name, value: setting.value, description: setting.description };

                var indexOf = this.settings.findIndex(item => item.name === name);
                if (indexOf < 0) indexOf = this.settings.length;
                this.settings[indexOf] = newSetting;

                return { name: setting.name, value: setting.value, description: setting.description };
            });
    }
};
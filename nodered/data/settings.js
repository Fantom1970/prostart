module.exports = {
    flowFile: 'flows.json',
    credentialSecret: "prostart-dev-secret-change-in-prod",
    uiPort: process.env.PORT || 1880,
    httpAdminRoot: '/',
    httpNodeRoot: '/',
    functionGlobalContext: {},
    disableEditor: false,
    httpNodeCors: { origin: "*", headers: "*" },
    logging: {
        console: { level: "info", metrics: false, audit: false }
    }
};

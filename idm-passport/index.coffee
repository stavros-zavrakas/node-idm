passport = require "./passport"

module.exports = (options, imports, register) ->

  console.log "idm-node: passport initialisation"

  models = imports.models

  passportLib = passport.init models.users, models.clients, models.tokens

  register null,
    passport: passportLib
    localAuth:
      isAuthenticated: passportLib.authenticate "local", { successReturnToOrRedirect: "/", failureRedirect: "/login" }
    basicAuth:
      isAuthenticated: passportLib.authenticate ["basic", "bearer"], session: false
    clientBasicAuth:
      isAuthenticated: passportLib.authenticate "client-basic", session: false
    bearerAuth:
      isAuthenticated: passportLib.authenticate "bearer", session: false

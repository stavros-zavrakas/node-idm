controllers = require "./controllers"

module.exports = (options, imports, register) ->
  console.log "idm-node: controllers initialisation"

  controllers = controllers.init imports.models, imports.oauth

  register null,
    controllers: controllers

routes = require "./users"

module.exports = (options, imports, register) ->
  console.log "routes initialized"

  app = imports.express

  app.get "/users", routes.get

  register()

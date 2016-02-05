routes = require "./users"

module.exports = (options, imports, register) ->
  console.log "routes initialized"

  app = imports.express
  users = imports.usersModel

  app.get "/users", routes.get

  register()

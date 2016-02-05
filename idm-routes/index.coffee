module.exports = (options, imports, register) ->
  console.log "routes initialized"

  app = imports.express
  getUsersController = imports.getUsersController

  app.get "/users", getUsersController

  register()

module.exports = (options, imports, register) ->
  console.log "routes initialized"

  app = imports.express
  getUsersRoute = imports.getUsersRoute

  app.get "/users", getUsersRoute

  register()

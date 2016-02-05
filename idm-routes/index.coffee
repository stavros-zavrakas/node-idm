module.exports = (options, imports, register) ->
  console.log "routes initialized"

  app = imports.express
  getUsersController = imports.getUsersController
  getSingleUsersController = imports.getSingleUsersController
  postUsersController = imports.postUsersController

  app.get "/users", getUsersController
  
  app.get "/users/:uid", getSingleUsersController

  app.post "/users", postUsersController

  register()

get = require "./routes/get"

module.exports = (options, imports, register) ->
  console.log "users routes initialized"

  usersModel = imports.usersModel
  getUsersRoute = get.get usersModel

  register null,
    getUsersRoute: getUsersRoute

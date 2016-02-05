get = require "./routes/get"

module.exports = (options, imports, register) ->
  console.log "users routes initialized"

  usersModel = imports.usersModel
  getUsersController = get.get usersModel

  register null,
    getUsersController: getUsersController

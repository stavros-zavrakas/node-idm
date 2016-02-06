controllers = require "./controllers"

module.exports = (options, imports, register) ->
  console.log "users controllers initialized"

  usersModel = imports.models.users

  getUsers = controllers.users.get usersModel
  getUsersSingle = controllers.users.getSingle usersModel
  postUsers = controllers.users.post usersModel

  register null,
    controllers:
      users:
        get: getUsers
        getSingle: getUsersSingle
        post: postUsers

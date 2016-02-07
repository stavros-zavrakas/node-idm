controllers = require "./controllers"

module.exports = (options, imports, register) ->
  console.log "idm-node: controllers initialisation"

  usersModel = imports.models.users
  passport = imports.passport

  getUsers = controllers.users.get usersModel
  getUsersSingle = controllers.users.getSingle usersModel
  postUsers = controllers.users.post usersModel

  basicAuth = controllers.login.basicAuth passport

  register null,
    controllers:
      users:
        get: getUsers
        getSingle: getUsersSingle
        post: postUsers
      login:
        basicAuth: basicAuth

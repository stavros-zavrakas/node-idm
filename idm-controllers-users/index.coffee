controllers = require "./controllers"

module.exports = (options, imports, register) ->
  console.log "idm-node: controllers initialisation"

  usersModel = imports.models.users
  clientsModel = imports.models.clients
  passport = imports.passport
  oauth = imports.oauth

  getUsers = controllers.users.get usersModel
  getUsersSingle = controllers.users.getSingle usersModel
  postUsers = controllers.users.post usersModel

  basicAuth = controllers.login.basicAuth passport

  oauthAuthorisation = controllers.oauth.authorization oauth.server, clientsModel

  register null,
    controllers:
      users:
        get: getUsers
        getSingle: getUsersSingle
        post: postUsers
      login:
        basicAuth: basicAuth
      oauth:
        authorisation: oauthAuthorisation

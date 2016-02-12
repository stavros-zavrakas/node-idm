login = require "./login"
oauthCtrl = require "./oauth"
users = require "./users"

init = (models, oauth) ->

  # users
  getUsers = users.get models.users
  getUsersSingle = users.getSingle models.users
  postUsers = users.post models.users

  # passport
  basicAuth = login.basicAuth()

  # oauth
  oauthAuthorisation = oauthCtrl.authorization oauth.server, models.clients
  oauthToken = oauthCtrl.token oauth.server
  oauthDecision = oauthCtrl.decision oauth.server

  return (
    users:
      get: getUsers
      getSingle: getUsersSingle
      post: postUsers
    login:
      basicAuth: basicAuth
    oauth:
      authorisation: oauthAuthorisation
      token: oauthToken
      decision: oauthDecision
  )

module.exports =
  init: init
login = require "connect-ensure-login"

module.exports = (oauthServer, clientsModel) -> [
  login.ensureLoggedIn()
  oauthServer.authorization (clientId, redirectUri, callback) ->
    clientsModel.findOne id: clientId, (err, client) ->
      if err
        return callback err

      return callback null, client, redirectUri
  (req, res) ->
      res.render "layouts/dialog", transactionID: req.oauth2.transactionID, user: req.user, client: req.oauth2.client
]

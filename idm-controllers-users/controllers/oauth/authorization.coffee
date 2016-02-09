module.exports = (oauthServer, clientsModel) -> 
  oauthServer.authorization (clientId, redirectUri, callback) ->
    clientsModel.findOne id: clientId, (err, client) ->
      if err
        return callback err

      return callback null, client, redirectUri

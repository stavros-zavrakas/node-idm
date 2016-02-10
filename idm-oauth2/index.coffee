oauth2orize = require "oauth2orize"

uid = (len) ->
  buf = []
  chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
  charlen = chars.length
  i = 0
  while i < len
    buf.push chars[getRandomInt(0, charlen - 1)]
    ++i

  return buf.join ""

getRandomInt = (min, max) ->
  Math.floor(Math.random() * (max - min + 1)) + min

module.exports = (options, imports, register) ->

  models = imports.models
  
  console.log "idm-node: oauth2 initialisation"

  Clients = models.clients
  Codes = models.codes
  Tokens = models.tokens

  server = oauth2orize.createServer()

  server.serializeClient (client, callback) ->
    return callback null, client._id

  server.deserializeClient (id, callback) ->
    Clients.findOne _id: id, (err, client) ->
      if err
        return callback err

      return callback null, client

  server.grant oauth2orize.grant.code (client, redirectUri, user, ares, callback) ->
    code = new Codes
      value: uid 16
      clientId: client._id
      redirectUri: redirectUri
      uid: user._id

    code.save (err) ->
      if err
        return callback err

      return callback null, code.value

  server.exchange oauth2orize.exchange.code (client, code, redirectUri, callback) ->
    Codes.findOne value: code, (err, authCode) ->
      if err
        return callback err
      else if not authCode
        return callback null, false
      else if client._id.toString() isnt authCode.clientId
        return callback null, false
      else if redirectUri isnt authCode.redirectUri
        return callback null, false

      authCode.remove (err) ->
        if err
          return callback err

        token = new Tokens
          accessToken: uid 256
          refreshToken: uid 256
          clientId: authCode.clientId
          uid: authCode.uid

        token.save (err) ->
          if err
            return callback err

          callback null, token

  register null,
    oauth:
      server: server
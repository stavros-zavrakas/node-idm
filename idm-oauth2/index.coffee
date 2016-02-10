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

  Users = models.users
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

  # @example: /oauth2/authorize?client_id=client_id&response_type=code&redirect_uri=http://localhost:3000
  # /oauth2/token (grant_type: code)
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

  # @example: /oauth2/token (grant_type: password)
  server.exchange oauth2orize.exchange.password (client, username, password, scope, callback) ->
    Users.findOne email: username, (err, user) ->
      if err
        return callback err
      else if not user
        return callback null, false

      user.verifyPassword password, (err, isMatch) ->
        if err
          return callback err
        else if not isMatch
          callback null, false

        ###
        # @todo: should we treat the refresh tokens as different collection?
        token = utils.uid(256)
        refreshToken = utils.uid(256)
        tokenHash = crypto.createHash('sha1').update(token).digest('hex')
        refreshTokenHash = crypto.createHash('sha1').update(refreshToken).digest('hex')
        expirationDate = new Date(new Date().getTime() + (3600 * 1000))
        ###

        token = new Tokens
          accessToken: uid 256
          refreshToken: uid 256
          clientId: client.id
          uid: user._id

        token.save token, (err) ->
          if err
            return callback err

          callback null, token
          
  register null,
    oauth:
      server: server
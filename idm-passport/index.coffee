passport = require "passport"

BasicStrategy = require("passport-http").BasicStrategy
BearerStrategy = require("passport-http-bearer").Strategy

module.exports = (options, imports, register) ->

  console.log "idm-node: passport initialisation"

  models = imports.models

  Users = models.users
  Clients = models.clients
  Tokens = models.tokens

  passport.serializeUser (user, done) ->
    done null, user

  passport.deserializeUser (obj, done) ->
    done null, obj

  passport.use new BasicStrategy (

    (username, password, done) ->
      Users.findOne email: username, (err, user) ->
        if err 
          return done err
        else if not user
          return done null, false

        user.verifyPassword password, (err, isMatch) ->
          if err
            return done err
          else if not isMatch
            return done null, false

          return done null, user
  )

  passport.use "client-basic", new BasicStrategy(

    (username, password, callback) ->
      Clients.findOne id: username, (err, client) ->
        if err 
          return callback err

        if not client or client.secret isnt password
          return callback null, false

        return callback null, client
  )

  passport.use new BearerStrategy(

    (accessToken, callback) ->
      Tokens.findOne accessToken: accessToken, (err, token) ->
        if err
          return callback err
        else if not token
          return callback null, false

        Users.findOne _id: token.uid, (err, user) ->
          if err
            return callback err
          else if not user
            return callback null, false

          return callback null, user, scope: "*"
  )

  register null,
    passport: passport
    basicAuth:
      isAuthenticated: passport.authenticate ["basic", "bearer"], session: false
    clientBasicAuth:
      isAuthenticated: passport.authenticate "client-basic", session: false
    bearerAuth:
      isAuthenticated: passport.authenticate "bearer", session: false

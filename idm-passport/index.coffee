passport = require 'passport'

BasicStrategy = require('passport-http').BasicStrategy;

module.exports = (options, imports, register) ->

  console.log "idm-node: passport initialisation"

  models = imports.models

  Users = models.users
  Clients = models.clients

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

  passport.use 'client-basic', new BasicStrategy(
    (username, password, callback) ->
      Clients.findOne id: username, (err, client) ->
        if err 
          return callback err

        if  not client or client.secret isnt password
          return callback null, false

        return callback null, client
  )

  register null,
    passport: passport
    basicAuth:
      isAuthenticated: passport.authenticate 'basic', session: false
    clientBasic:
      isAuthenticated: passport.authenticate 'client-basic', session: false
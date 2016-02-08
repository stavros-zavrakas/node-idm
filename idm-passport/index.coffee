passport = require 'passport'

BasicStrategy = require('passport-http').BasicStrategy;

module.exports = (options, imports, register) ->

  console.log "idm-node: passport initialisation"

  models = imports.models
  User = models.users

  passport.serializeUser (user, done) ->
    done null, user

  passport.deserializeUser (obj, done) ->
    done null, obj

  passport.use new BasicStrategy (
    (username, password, done) ->
      User.findOne email: username, (err, user) ->
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

  register null,
    passport: passport
passport = require 'passport'

BasicStrategy = require('passport-http').BasicStrategy;

module.exports = (options, imports, register) ->

  console.log "idm-node: passport initialisation"

  passport.serializeUser (user, done) ->
    done null, user

  passport.deserializeUser (obj, done) ->
    done null, obj

  passport.use new BasicStrategy (
    (username, password, done) ->
      console.log "hereee"
      return done(null, 'success');
      # User.findOne username: userid, (err, user) ->
      #   if err 
      #     return done err
      #   else if not user
      #     return done null, false
      #   else if not user.verifyPassword password
      #     return done null, false

      #   return done(null, user);
  )

  register null,
    passport: passport
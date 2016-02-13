FacebookStrategy = require("passport-facebook").Strategy;

module.exports = (passport, config, Users) ->

  passport.use new FacebookStrategy 
      clientID: config.facebook.clientID
      clientSecret: config.facebook.clientSecret
      callbackURL: config.facebook.callbackURL
      profileFields: ["id", "email", "name", "gender", "photos"]
    ,
    (accessToken, refreshToken, profile, done) ->
      # @see: https://scotch.io/tutorials/easy-node-authentication-facebook
      process.nextTick () ->
        console.log accessToken
        console.log refreshToken
        console.log profile._json

        return done null, true

        ###
        User.findOrCreate (err, user) ->
          if err
            return done err
          done null, user
        ###
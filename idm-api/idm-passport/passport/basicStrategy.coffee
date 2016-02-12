BasicStrategy = require("passport-http").BasicStrategy

module.exports = (passport, Users) ->
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
LocalStrategy = require("passport-local").Strategy;

module.exports = (passport, Users) ->

  passport.use new LocalStrategy(
    (username, password, done) ->
      Users.findOne email: username, (err, user) ->
        if err
          return done err
        else if not user
          return done null, false
        # @todo: check against user password
        # else if user.password isnt password
        #   return done null, false

        return done null, user
  )
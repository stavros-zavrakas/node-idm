BearerStrategy = require("passport-http-bearer").Strategy

module.exports = (passport, Users, Tokens) ->
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

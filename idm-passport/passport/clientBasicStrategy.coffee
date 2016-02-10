BasicStrategy = require("passport-http").BasicStrategy

module.exports = (passport, Clients) ->
  passport.use "client-basic", new BasicStrategy(

    (username, password, callback) ->
      Clients.findOne id: username, (err, client) ->
        if err 
          return callback err

        if not client or client.secret isnt password
          return callback null, false

        return callback null, client
  )

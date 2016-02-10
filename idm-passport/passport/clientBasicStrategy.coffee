BasicStrategy = require("passport-http").BasicStrategy

module.exports = (passport, Clients) ->
  passport.use "client-basic", new BasicStrategy(

    (clientId, clientSecret, callback) ->
      Clients.findOne id: clientId, (err, client) ->
        if err 
          return callback err

        if not client or client.secret isnt clientSecret
          return callback null, false

        return callback null, client
  )

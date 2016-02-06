assert = require "assert"

mongoose = require "mongoose"

module.exports = (options, imports, register) ->
  assert options.host, "Option 'host' is required"
  assert options.databaseName, "Option 'databaseName' is required"

  console.log "mongoose initialized"

  mongoose.connection.on "error", (err) ->
    console.log "Couldn't connect to MongoDB"
    console.log err
    throw err

  mongoose.connection.on "open", () ->
    console.log "Successfully connected to MongoDB"

    register null,
      mongoose: mongoose

  mongoose.connect "mongodb://#{options.host}/#{options.databaseName}"
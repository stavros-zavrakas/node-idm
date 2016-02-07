assert = require "assert"

mongoose = require "mongoose"

module.exports = (options, imports, register) ->
  assert options.host, "Option 'host' is required"
  assert options.databaseName, "Option 'databaseName' is required"

  console.log "idm-node: mongoose initialisation"

  mongoose.connection.on "error", (err) ->
    console.log "idm-node: Couldn't connect to mongoDB"
    console.log err
    throw err

  mongoose.connection.on "open", () ->
    console.log "idm-node: successfully connected to mongoDB"

    register null,
      mongoose: mongoose

  mongoose.connect "mongodb://#{options.host}/#{options.databaseName}"
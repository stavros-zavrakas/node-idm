path = require "path"
architect = require "architect"
architect_config = architect.loadConfig path.join(__dirname, "plugins.json")

arch = architect.createApp architect_config, () ->
  console.log "application started"

arch.on "error", (err) ->
  console.log err
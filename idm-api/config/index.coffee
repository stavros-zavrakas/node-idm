# @todo: to be substituted from DB driven configuration
configValues = require "./configValues"

module.exports = (options, imports, register) ->

  console.log "idm-node: config initialisation"

  config = configValues

  register null,
    config: config

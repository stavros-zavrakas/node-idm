# controllers = require "./controllers"

module.exports = (options, imports, register) ->
  console.log "idm-node: client controllers initialisation"

  clientControllers = 
    index: (req, res) ->
      res.render "layouts"
    login: (req, res) ->
      res.render "layouts/login"

  register null,
    clientControllers: clientControllers

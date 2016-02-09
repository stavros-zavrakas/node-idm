assert = require 'assert'

express = require 'express'
http = require 'http'
bodyParser = require 'body-parser'

module.exports = (options, imports, register) ->
  assert options.port, "Option 'port' is required"

  controllers = imports.controllers
  basicAuth = imports.basicAuth

  console.log "idm-node: server initialisation"

  app = express();

  app.set "port", options.port

  app.use bodyParser.urlencoded extended: true
  app.use bodyParser.json()

  app.get "/users", controllers.users.get
  app.get "/users/:uid", controllers.users.getSingle
  app.post "/users", controllers.users.post

  app.post "/login",
    basicAuth.isAuthenticated
    controllers.login.basicAuth

  http.createServer(app).listen app.get('port'), () ->
    console.log "idm-node: express server listening on port #{app.get('port')}"

  register null,
    express: app


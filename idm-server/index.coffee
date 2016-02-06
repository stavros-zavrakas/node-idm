assert = require 'assert'

express = require 'express'
http = require 'http'
bodyParser = require 'body-parser'

module.exports = (options, imports, register) ->
  assert options.port, "Option 'port' is required"

  userControllers = imports.usersControllers;

  console.log "server initialized"

  expr = express();

  expr.set "port", options.port

  expr.use bodyParser.urlencoded extended: false
  expr.use bodyParser.json()

  expr.get "/users", userControllers.get
  expr.get "/users/:uid", userControllers.getSingle
  expr.post "/users", userControllers.post

  http.createServer(expr).listen expr.get('port'), () ->
    console.log "Express server listening on port #{expr.get('port')}"

  register null,
    express: expr


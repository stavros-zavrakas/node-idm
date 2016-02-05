assert = require 'assert'

express = require 'express'
http = require 'http'
bodyParser = require 'body-parser'

module.exports = (options, imports, register) ->
  assert options.port, "Option 'port' is required"

  console.log "server initialized"

  expr = express();

  expr.set "port", options.port

  expr.use bodyParser.urlencoded extended: false
  expr.use bodyParser.json()

  http.createServer(expr).listen expr.get('port'), () ->
    console.log "Express server listening on port #{expr.get('port')}"

  register null,
    express: expr


assert = require 'assert'

express = require 'express'
ejs = require 'ejs'
http = require 'http'
session = require 'express-session'
bodyParser = require 'body-parser'

module.exports = (options, imports, register) ->
  assert options.port, "Option 'port' is required"

  controllers = imports.controllers
  basicAuth = imports.basicAuth
  clientBasicAuth = imports.clientBasicAuth

  console.log "idm-node: server initialisation"

  app = express();

  app.set "port", options.port
  app.set "view engine", "ejs"

  app.use bodyParser.urlencoded extended: true
  app.use bodyParser.json()
  app.use session
    secret: "Super Secret Session Key"
    saveUninitialized: true
    resave: true


  app.get "/users", controllers.users.get
  app.get "/users/:uid", controllers.users.getSingle

  app.post "/users",
    basicAuth.isAuthenticated 
    controllers.users.post

  app.post "/login",
    basicAuth.isAuthenticated
    controllers.login.basicAuth

  app.get "/oauth2/authorize",
    basicAuth.isAuthenticated
    controllers.oauth.authorisation
  
  app.post "/oauth2/authorize",
    basicAuth.isAuthenticated
    controllers.oauth.decision

  app.post "/oauth2/token",
    clientBasicAuth.isAuthenticated
    controllers.oauth.token

  http.createServer(app).listen app.get('port'), () ->
    console.log "idm-node: express server listening on port #{app.get('port')}"

  register null,
    express: app


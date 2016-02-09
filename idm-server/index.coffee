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

  # oauth testing start
  oauth = imports.oauth

  authorization = [
    controllers.oauth.authorisation,
    (req, res) ->
      res.render 'dialog', transactionID: req.oauth2.transactionID, user: req.user, client: req.oauth2.client
  ]

  token = [
    oauth.server.token(),
    oauth.server.errorHandler()
  ]

  decision = [
    oauth.server.decision()
  ]
  # oauth testing end

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
    authorization
  
  app.post "/oauth2/authorize",
    basicAuth.isAuthenticated
    decision

  app.post "/oauth2/token",
    clientBasicAuth.isAuthenticated
    token

  http.createServer(app).listen app.get('port'), () ->
    console.log "idm-node: express server listening on port #{app.get('port')}"

  register null,
    express: app


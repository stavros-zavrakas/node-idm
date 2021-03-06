# @see: http://security.stackexchange.com/questions/38802/how-is-saml-solving-the-cross-domain-single-sign-on-problem
# @see: https://rwlive.wordpress.com/
# @see: http://dejanglozic.com/2014/10/07/sharing-micro-service-authentication-using-nginx-passport-and-redis/

assert = require "assert"
path = require "path"

express = require "express"
exphbs = require "express-handlebars"
http = require "http"
session = require "express-session"
bodyParser = require "body-parser"

passportTmp = require "passport"

module.exports = (options, imports, register) ->
  assert options.port, "Option 'port' is required"

  config = imports.config
  controllers = imports.controllers
  clientControllers = imports.clientControllers
  passport = imports.passport
  localAuth = imports.localAuth
  basicAuth = imports.basicAuth
  clientBasicAuth = imports.clientBasicAuth
  facebookAuth = imports.facebookAuth

  console.log "idm-node: server initialisation"

  app = express();

  app.set "port", options.port

  viewsPath = path.join __dirname, "..", "idm-client/views"
  layoutsDir = path.resolve path.join viewsPath, "layouts"
  partialsDir = path.resolve path.join viewsPath, "partials"

  app.engine "handlebars", exphbs 
    layoutsDir: layoutsDir
    partialsDir: partialsDir
    defaultLayout: "main"

  app.set "views", path.resolve viewsPath
  app.set "view engine", "handlebars"

  app.use bodyParser.urlencoded extended: true
  app.use bodyParser.json()
  app.use session
    secret: "Super Secret Session Key"
    saveUninitialized: true
    resave: true

  app.use passport.initialize()
  app.use passport.session()

  app.use "/static", express.static(path.join(__dirname, "../idm-client/public"))

  app.use (req, res, next) ->
    # @todo: get the clientId from the query params 
    # find  the client by clientId and add it to the session
    # If does not exist in the session or in the query param, return error.
    if not req.session.clientId
      req.session.clientId = "client_id"

    return next()

  app.get "/",
    clientControllers.index

  app.get "/login",
    clientControllers.login

  app.post "/login",
    localAuth.isAuthenticated

  app.get "/auth/facebook",
    facebookAuth.authenticate

  app.get "/auth/facebook/callback",
    facebookAuth.authenticateCallback
    (req, res) ->
      if req.session.clientId
        console.log req.session.clientId

      res.redirect "/"

  app.get "/oauth2/authorize",
    controllers.oauth.authorisation
  
  app.post "/oauth2/authorize",
    controllers.oauth.decision

  app.post "/oauth2/token",
    clientBasicAuth.isAuthenticated
    controllers.oauth.token

  app.get "/users", controllers.users.get
  app.get "/users/:uid", controllers.users.getSingle

  app.post "/users",
    basicAuth.isAuthenticated 
    controllers.users.post

  http.createServer(app).listen app.get("port"), () ->
    console.log "idm-node: express server listening on port #{app.get('port')}"

  register null,
    express: app


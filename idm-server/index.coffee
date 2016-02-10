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

module.exports = (options, imports, register) ->
  assert options.port, "Option 'port' is required"

  passport = imports.passport
  controllers = imports.controllers
  localAuth = imports.localAuth
  basicAuth = imports.basicAuth
  clientBasicAuth = imports.clientBasicAuth

  console.log "idm-node: server initialisation"

  app = express();

  app.set "port", options.port

  app.engine "handlebars", exphbs {layout:false}
  app.set "views", path.join(__dirname, '../client/views')
  app.set "view engine", "handlebars"

  app.use bodyParser.urlencoded extended: true
  app.use bodyParser.json()
  app.use session
    secret: "Super Secret Session Key"
    saveUninitialized: true
    resave: true

  app.use passport.initialize()
  app.use passport.session()

  app.get "/",
    (req, res) ->
      res.render "layouts"

  app.get "/users", controllers.users.get
  app.get "/users/:uid", controllers.users.getSingle

  app.get "/login",
    (req, res) ->
      res.render "layouts/login"

  app.post "/login",
    localAuth.isAuthenticated

  app.post "/users",
    basicAuth.isAuthenticated 
    controllers.users.post

  app.get "/oauth2/authorize",
    controllers.oauth.authorisation
  
  app.post "/oauth2/authorize",
    controllers.oauth.decision

  app.post "/oauth2/token",
    clientBasicAuth.isAuthenticated
    controllers.oauth.token

  http.createServer(app).listen app.get("port"), () ->
    console.log "idm-node: express server listening on port #{app.get('port')}"

  register null,
    express: app


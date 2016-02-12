login = require "connect-ensure-login"

module.exports = (oauthServer) -> [
  login.ensureLoggedIn()
  oauthServer.decision()
]

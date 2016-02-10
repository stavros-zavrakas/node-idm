module.exports = (oauthServer) -> [
  oauthServer.token(),
  oauthServer.errorHandler()
]


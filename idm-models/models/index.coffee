users = require "./users"
clients = require "./clients"
tokens = require "./tokens"
codes = require "./codes"

init = (mongoose) ->
  users: users.init(mongoose),
  clients: clients.init(mongoose)
  tokens: tokens.init(mongoose)
  codes: codes.init(mongoose)

module.exports =
  init: init
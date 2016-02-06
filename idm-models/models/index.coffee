users = require "./users"
clients = require "./clients"
tokens = require "./tokens"

init = (mongoose) ->
  users: users.init(mongoose),
  clients: clients.init(mongoose)
  tokens: tokens.init(mongoose)

module.exports =
  init: init
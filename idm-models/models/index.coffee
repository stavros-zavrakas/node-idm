users = require "./users"
clients = require "./clients"

init = (mongoose) ->
  users: users.init(mongoose),
  clients: clients.init(mongoose)

module.exports =
  init: init
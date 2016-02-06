usersSchema = require "./users"
clientsSchema = require "./users"

generator = require "./generator"

module.exports = (options, imports, register) ->

  mongoose = imports.mongoose;

  usersModel = generator.createModel mongoose, "users", usersSchema

  clientsModel = generator.createModel mongoose, "clients", clientsSchema

  register null,
    models:
      users: usersModel
      clients: clientsModel
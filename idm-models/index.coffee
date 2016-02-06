models = require "./models"

generator = require "./generator"

module.exports = (options, imports, register) ->

  mongoose = imports.mongoose;

  usersModel = generator.createModel mongoose, "users", models.users

  clientsModel = generator.createModel mongoose, "clients", models.clients

  register null,
    models:
      users: usersModel
      clients: clientsModel
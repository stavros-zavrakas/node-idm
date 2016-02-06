models = require "./models"

generator = require "./generator"

module.exports = (options, imports, register) ->

  mongoose = imports.mongoose;

  modelsSchemas = models.init mongoose

  usersModel = generator.createModel mongoose, "users", modelsSchemas.users

  clientsModel = generator.createModel mongoose, "clients", modelsSchemas.clients

  register null,
    models:
      users: usersModel
      clients: clientsModel
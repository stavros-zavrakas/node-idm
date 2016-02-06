models = require "./models"

generator = require "./generator"

module.exports = (options, imports, register) ->

  mongoose = imports.mongoose;

  modelsData = models.init mongoose

  usersModel = generator.createModel mongoose, modelsData.users.name, modelsData.users.schema
  clientsModel = generator.createModel mongoose, modelsData.clients.name, modelsData.clients.schema
  tokensModel = generator.createModel mongoose, modelsData.tokens.name, modelsData.tokens.schema

  register null,
    models:
      users: usersModel
      clients: clientsModel
      tokensModel: tokensModel
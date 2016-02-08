models = require "./models"

generator = require "./generator"

module.exports = (options, imports, register) ->

  mongoose = imports.mongoose;

  console.log "idm-node: models initialisation"

  modelsData = models.init mongoose

  usersModel = generator.createModel mongoose, modelsData.users.name, modelsData.users.schema, modelsData.users.methods
  clientsModel = generator.createModel mongoose, modelsData.clients.name, modelsData.clients.schema
  tokensModel = generator.createModel mongoose, modelsData.tokens.name, modelsData.tokens.schema

  register null,
    models:
      users: usersModel
      clients: clientsModel
      tokensModel: tokensModel
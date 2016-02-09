models = require "./models"

generator = require "./generator"

module.exports = (options, imports, register) ->

  mongoose = imports.mongoose;

  console.log "idm-node: models initialisation"

  modelsData = models.init mongoose

  usersModel = generator.createModel mongoose, modelsData.users
  clientsModel = generator.createModel mongoose, modelsData.clients
  tokensModel = generator.createModel mongoose, modelsData.tokens
  codesModel = generator.createModel mongoose, modelsData.codes

  register null,
    models:
      users: usersModel
      clients: clientsModel
      tokens: tokensModel
      codes: codesModel
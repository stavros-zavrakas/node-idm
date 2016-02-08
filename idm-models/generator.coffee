createModel = (mongoose, modelName, schemaObject, methods) ->

  schema = new mongoose.Schema schemaObject

  if methods
    for methodName, methodFunction of methods
      schema.methods[methodName] = methodFunction

  mongooseSchema = mongoose.model modelName, schema

  return mongooseSchema

module.exports =
  createModel: createModel

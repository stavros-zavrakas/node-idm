createModel = (mongoose, model) ->

  schema = new mongoose.Schema model.schema

  if model.preHookMethods
    for preMethodName, preMethodFunction of model.preHookMethods
      schema.pre 'save', preMethodFunction

  if model.methods
    for methodName, methodFunction of model.methods
      schema.methods[methodName] = methodFunction

  mongooseSchema = mongoose.model model.name, schema

  return mongooseSchema

module.exports =
  createModel: createModel

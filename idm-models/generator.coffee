createModel = (mongoose, modelName, schemaObject) ->

  schema = new mongoose.Schema schemaObject

  mongooseSchema = mongoose.model modelName, schema

  return mongooseSchema

module.exports =
  createModel: createModel

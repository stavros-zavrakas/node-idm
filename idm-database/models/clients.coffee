mongoose = require "mongoose"

schema = new mongoose.Schema
  clientId: "string",
  clientSecret: "string",
  createdFromUser: "string",
  secretAppToken: "string",
  permissions: Array,
  isDeleted: Boolean

clients = mongoose.model "clients", schema

module.exports = {
  model: clients
}

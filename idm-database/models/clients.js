'use strict';

var mongoose = require('mongoose');

var schema = new mongoose.Schema({
  clientId: 'string',
  clientSecret: 'string',
  createdFromUser: 'string',
  secretAppToken: 'string',
  permissions: Array,
  isDeleted: Boolean
});

var clients = mongoose.model('clients', schema);

module.exports = {
  model: clients
};

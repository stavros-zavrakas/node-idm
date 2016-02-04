'use strict';

var assert = require('assert');

var mongoose = require('mongoose');

module.exports = function setup(options, imports, register) {
  assert(options.host, 'Option "host" is required');
  assert(options.databaseName, 'Option "databaseName" is required');

  console.log('mongoose initialized');

  mongoose.connection.on('error', function (err) {
    console.log('Couldn\'t connect to MongoDB');
    console.log(err);
    throw err;
  });

  mongoose.connection.on('open', function () {
    console.log('Successfully connected to MongoDB');

    register(null, {
      mongoose: mongoose
    });
  });

  mongoose.connect('mongodb://' + options.host + '/' + options.databaseName);
};

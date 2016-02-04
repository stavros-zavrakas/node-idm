'use strict';

var routes = require('./users');

module.exports = function setup(options, imports, register) {
  console.log('routes initialized');

  var app = imports.express;

  app.get('/users', routes.get);

  register();
};

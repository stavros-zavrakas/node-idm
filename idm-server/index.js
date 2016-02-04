'use strict';

var assert = require('assert');

var express = require('express');
var http = require('http');

module.exports = function setup(options, imports, register) {
  assert(options.port, 'Option "port" is required');

  console.log('server initialized');

  var expr = express();

  expr.set('port', options.port);

  http.createServer(expr).listen(expr.get('port'), function () {
    console.log('Express server listening on port ' + expr.get('port'));
  });

  register(null, {
    express: expr
  });
};

'use strict';

var express = require('express');
var http = require('http');

module.exports = function setup(options, imports, register) {
  console.log('server initialized');

  var expr = express();

  // all environments
  expr.set('port', options.port);
  expr.set('views', '/');

  expr.set('view engine', 'ejs');

  http.createServer(expr).listen(expr.get('port'), function () {
    console.log('Express server listening on port ' + expr.get('port'));
  });

  register(null, {
    express: expr
  });
};

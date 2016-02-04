'use strict';

var path = require('path');

var architect = require('architect');

var architect_config = architect.loadConfig(path.join(__dirname, 'plugins.json'));

var arch = architect.createApp(architect_config, function () {
  console.log('application started');
});

arch.on('error', function (err) {
  console.log(err);
});

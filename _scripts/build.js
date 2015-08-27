'use strict'

var
  repo,
  contPath,
  container,
  containers,
  childProcess;

childProcess = require('child_process');

containers = require('../manifest.json');

for (contPath in containers) {
  container = containers[contPath];
  repo = container.user + '/' + container.repository + ':' + container.tag;

  // Build.
  console.log('Running: docker build -t ' + repo + ' ' + contPath);
  childProcess.execSync('docker build -t ' + repo + ' ' + contPath, {
    stdio: 'inherit'
  });
}

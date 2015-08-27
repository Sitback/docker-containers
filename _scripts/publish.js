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

  // Push.
  console.log('Running: docker push ' + repo);
  childProcess.execSync('docker push ' + repo, {
    stdio: 'inherit'
  });
}

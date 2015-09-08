require 'docker'

Docker.url = 'unix:///var/run/docker.sock'

puts Docker.info

# Trigger error
exit 5

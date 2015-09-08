require 'docker'

Docker.url = 'unix:///var/run/docker.sock'
Docker.url = ENV['DOCKER_HOST']

puts Docker.info

# Trigger error
exit 5

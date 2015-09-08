require 'docker'

Docker.url = 'unix:///var/run/docker.sock'

puts Docker.info

container = Docker::Container.create('Cmd' => ['ls'], 'Image' => 'chinthakagodawita/soe:php5.5')
puts container.json
puts "Starting container"
container.start
puts container.json
container.stop

# Trigger error
exit 5

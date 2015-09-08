require 'docker'

Docker.url = 'unix:///var/run/docker.sock'
# Docker.url = ENV['DOCKER_HOST']

puts Docker.info

img_name = 'chinthakagodawita/soe:php5.5'
# image1 = Docker::Image.get(img_name)
image2 = Docker::Image.create('fromImage' => img_name)
container = Docker::Container.create('Cmd' => ['ls'], 'Image' => image2.id)
puts container.json
puts "Starting container"
container.start
puts container.json
container.stop

# Trigger error
exit 5

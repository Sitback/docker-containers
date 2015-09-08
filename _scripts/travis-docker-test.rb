require 'docker'

Docker.url = 'unix:///var/run/docker.sock'

puts Docker.info

img_name = 'chinthakagodawita/soe:php5.5'
image1 = Docker::Image.get(img_name)
image2 = Docker::Image.create('fromImage' => img_name)
container = Docker::Container.create('Cmd' => ['ls'], 'Image' => image1.id)
puts container.json
container2 = Docker::Container.create('Cmd' => ['ls'], 'Image' => image1.id)
puts container2.json
puts "Starting container"
container.start
puts container.json
container.stop

# Trigger error
exit 5

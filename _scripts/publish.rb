require_relative 'helpers.rb'

# Login to the hub.
email = ENV['DOCKER_EMAIL']
user = ENV['DOCKER_USER']
pass = ENV['DOCKER_PASS']

system "docker login -e=\"#{email}\" -u=\"#{user}\" -p=\"#{pass}\""

manifest = load_manifest
load_manifest.each do |name, container|
  image = get_image_name name, container
  system! "docker push #{image}"
end

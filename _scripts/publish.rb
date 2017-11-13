require_relative 'helpers.rb'

# Login to the hub.
user = ENV['DOCKER_USER']
pass = ENV['DOCKER_PASS']
retries = 3

system "docker login -u=\"#{user}\" -p=\"#{pass}\""

manifest = load_manifest
load_manifest.each do |name, container|
  image = get_image_name name, container
  retries.times do
    system "docker push #{image}"
    break if $?.success?
  end
end

require_relative 'helpers.rb'

manifest = load_manifest
load_manifest.each do |name, container|
  image = get_image_name name, container
  system! "docker build --cache-from #{image} -t #{image} #{container['path']}"
end

require_relative 'helpers.rb'

manifest = load_manifest
load_manifest.each do |path, container|
  image = get_image_name container
  break unless system! "docker build -t #{image} #{path}"
end

require_relative 'helpers.rb'

# Update mtime to prevent unwanted builds.
if ENV['CIRCLECI']
  system! "git set-mtime"
end

manifest = load_manifest
load_manifest.each do |name, container|
  image = get_image_name name, container
  system! "docker build -t #{image} #{container['path']}"
end

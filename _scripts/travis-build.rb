require_relative 'helpers.rb'

CACHE_DIR = File.expand_path('~/docker').to_s

# Create cache directory if required.
system! "mkdir -p #{CACHE_DIR}"

manifest = load_manifest
load_manifest.each do |name, container|
  image = get_image_name name, container

  # Load from cache if we have one.
  cache_file = File.expand_path(sanitise_filename("#{name}.tar"), CACHE_DIR).to_s
  system! "docker load -i #{cache_file}" if File.exist?(cache_file)

  system! "docker build -t #{image} #{container['path']}"

  # Cache image for next build.
  system! "docker save #{image} > #{cache_file}"
end

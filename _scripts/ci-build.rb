require_relative 'helpers.rb'

CACHE_DIR = File.expand_path('~/docker').to_s

# Toggle to disable caching.
CACHE_ENABLED = false

# Create cache directory if required.
system! "mkdir -p #{CACHE_DIR}"

manifest = load_manifest
load_manifest.each do |name, container|
  image = get_image_name name, container

  # Load from cache if we have one.
  cache_file = File.expand_path(sanitise_filename("#{name}.tar"), CACHE_DIR).to_s
  if File.exist?(cache_file) and CACHE_ENABLED
    system! "docker load -i #{cache_file}", true
  else
    # Pull existing from Docker Hub, ignoring errors.
    system! "docker pull #{image}", true
  end

  system! "docker build -t #{image} #{container['path']}"

  # Cache image for next build.
  system! "docker save #{image} > #{cache_file}", true if CACHE_ENABLED
end

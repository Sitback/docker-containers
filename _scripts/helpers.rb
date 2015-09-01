require 'json'

def system! (cmd, ignore_exit = false)
  green_code = 32
  puts "\e[#{green_code}m#{cmd}\e[0m"
  system(cmd)

  # Non-zero exit on failure.
  exit $?.exitstatus unless $?.success? or ignore_exit
end

def load_manifest
  file = File.absolute_path('../manifest.json', File.dirname(__FILE__))
  manifest = File.read(file)
  return JSON.parse(manifest)
end

def get_image_name (name, container)
  return "#{container['user']}/#{name}"
end

# Inspired by http://stackoverflow.com/a/1939351.
def sanitise_filename (filename)
  # Get only the filename without the whole path and strip out non-ascii
  # characters.
  return filename.to_s.gsub(/^.*(\\|\/)/, '').gsub(/[^0-9A-Za-z.\-]/, '_')
end

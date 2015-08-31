require 'json'

def system! (cmd)
  green_code = 32
  puts "\e[#{green_code}m#{cmd}\e[0m"
  return system(cmd)
end

def load_manifest
  file = File.absolute_path('../manifest.json', File.dirname(__FILE__))
  manifest = File.read(file)
  return JSON.parse(manifest)
end

def get_image_name (container)
  return "#{container['user']}/#{container['repository']}:#{container['tag']}"
end

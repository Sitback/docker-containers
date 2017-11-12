require 'docker'

module Helpers
  def get_os_version
    command('lsb_release -a').stdout
  end

  def get_centos_os_version
    command('cat /etc/redhat-release').stdout
  end

  def get_docker_image_id (image_name)
    image = nil
    puts "getting for #{image_name}"
    puts "all:"
    puts Docker::Image.all
    Docker::Image.all.each do |image_def|
      puts image_def
      if image_def.info['RepoTags'].include?(image_name)
        image = image_def.id
        puts "image is #{image}"
        break
      end
    end
    return image
  end
end

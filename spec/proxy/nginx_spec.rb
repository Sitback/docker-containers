require 'spec_helper'

describe 'Base nginx proxy' do
  include_context 'proxy'

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}proxy:nginx"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

require 'spec_helper'

describe 'Nginx proxy for Node.js applications' do
  include_context 'proxy'

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}proxy:nginx-node"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

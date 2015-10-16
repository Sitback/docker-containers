require 'spec_helper'

describe 'Haproxy for Node.js applications' do
  include_context 'haproxy'

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}proxy:haproxy-node"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

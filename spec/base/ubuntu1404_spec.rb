require 'spec_helper'

describe 'Ubuntu 14.04 Base' do
  include_context 'base'

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}base:ubuntu-14.04"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

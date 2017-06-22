require 'spec_helper'

describe 'CentOS-7' do
  include_context 'base_centos'

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}base:centos-7"
    set :os, family: Constants::OS_FAMILY_CENTOS
    set :docker_image, get_docker_image_id(image_name)
  end
end

require 'spec_helper'

describe 'Ubuntu 16.04 Base' do
  include_context 'base' do
    let(:ubuntu_version) { '16.04' }
  end

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}base:ubuntu-16.04"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end

  after(:all) do
    puts "docker image was #{docker_image}"
  end
end

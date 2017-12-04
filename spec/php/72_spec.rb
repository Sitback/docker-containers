require 'spec_helper'

describe 'PHP 7.2' do
  include_context 'php' do
    let(:php_version) { '7.2' }
    let(:php_packages) { Constants::PHP72_PACKAGES }
    let(:apache_version) { '2.4.18' }
    let(:apache_php_mod) { 'php7_module' }
    let(:ubuntu_version) { '16.04' }
  end

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}php:7.2"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

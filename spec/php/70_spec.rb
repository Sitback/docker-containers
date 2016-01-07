require 'spec_helper'

describe 'PHP 7.0' do
  include_context 'php' do
    let(:php_version) { '7.0' }
    let(:php_packages) { Constants::PHP70_PACKAGES }
    let(:apache_php_mod) { 'php7_module' }
  end

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}php:7.0"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

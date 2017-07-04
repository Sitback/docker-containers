require 'spec_helper'

describe 'PHP 5.4' do
  include_context 'php_centos' 

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}php:5.4"
    set :os, family: Constants::OS_FAMILY_CENTOS
    set :docker_image, get_docker_image_id(image_name)
  end
end



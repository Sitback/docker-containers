require 'spec_helper'

describe 'PHP 5.6 SOE' do
  include_context 'soe' do
    let(:php_version) { '5.6' }
  end

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}soe:php5.6"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

require 'spec_helper'

describe 'PHP 7.0 CI' do
  include_context 'ci' do
    let(:php_version) { '7.0' }
  end

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}ci:php7.0"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

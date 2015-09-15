require 'spec_helper'

describe 'PHP 5.5 SOE' do
  include_context 'soe'

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}soe:php5.5"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

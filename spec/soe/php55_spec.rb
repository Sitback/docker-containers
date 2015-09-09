require 'spec_helper'

describe 'PHP 5.5 SOE' do
  include_context 'soe'

  before(:all) do
    image_name = "#{SoeConstants::IMAGE_PREFIX}php5.5"
    set :os, family: :debian
    set :docker_image, get_docker_image_id(image_name)
  end
end

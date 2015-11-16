require 'spec_helper'

describe 'Solr 5.3.x' do
  include_context 'solr'

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}solr:5.3"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

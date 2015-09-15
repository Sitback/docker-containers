require 'spec_helper'

describe 'PHP 5.3 SOE' do
  include_context 'soe' do
    let(:soe_packages) { Constants::PHP53_PACKAGES }
    let(:apache_version) { Constants::UBUNTU1204_APACHE_VERSION }
    let(:php_version) { '5.3' }
    let(:ubuntu_version) { '12.04' }
  end

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}soe:php5.3"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

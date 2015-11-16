require 'spec_helper'

describe 'PHP 5.4 SOE' do
  include_context 'soe' do
    # This SOE image doesn't inherit from a PHP one.
    let(:php_packages) { [] }
    let(:check_php_supervisord_file) { false }

    let(:soe_packages) { Constants::PHP54_PACKAGES }
    let(:apache_version) { Constants::UBUNTU1204_APACHE_VERSION }
    let(:php_version) { '5.4' }
    let(:ubuntu_version) { '12.04' }
  end

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}soe:php5.4"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

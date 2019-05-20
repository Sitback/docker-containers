require 'spec_helper'

describe 'PHP 7.2 SOE' do
  include_context 'soe' do
    let(:php_version) { '7.2' }
    let(:soe_packages) { Constants::PHP70_SOE_PACKAGES }
    let(:php_packages) { Constants::PHP72_PACKAGES }
    let(:apache_php_mod) { 'php7_module' }
    let(:ubuntu_version) { '16.04' }
    let(:apache_version) { '2.4.18' }
  end

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}soe:php7.2"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end

  describe 'SOE PHP Install' do
    describe command('php -m') do
      its(:stdout) { should include('xdebug') }
    end
  end
end

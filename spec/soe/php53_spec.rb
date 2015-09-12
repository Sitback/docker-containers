require 'spec_helper'

describe 'PHP 5.3 SOE' do
  include_context 'soe' do
    let(:soe_packages) { [
      'apache2',
      'php5',
      'socat',
      'mysql-client',
      'php5-gd',
      'php5-dev',
      'php5-curl',
      'php5-mcrypt',
      'php5-mysql',
      'php5-memcached',
      'php5-xdebug',
      'php-apc',
      'php-soap',
      'php-pear'
    ] }
    let(:apache_version) { '2.2.22' }
    let(:php_version) { '5.3' }
    let(:ubuntu_version) { '12.04' }
  end

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}soe:php5.3"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

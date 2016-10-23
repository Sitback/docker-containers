require 'spec_helper'

describe 'PHP 5.6' do
  include_context 'php' do
    let(:php_packages) { [
      'apache2',
      'php5.6',
      'mysql-client',
      'memcached',
      'php5.6-gd',
      'php5.6-dev',
      'php5.6-curl',
      'php5.6-mcrypt',
      'php5.6-mysql',
      'php-memcached',
      'php5.6-soap',
      'php-pear'
    ] }
    let(:php_version) { '5.6' }
  end

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}php:5.6"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

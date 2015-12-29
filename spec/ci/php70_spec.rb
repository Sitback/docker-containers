require 'spec_helper'

describe 'PHP 7.0 CI' do
  include_context 'ci' do
    let(:soe_packages) { [
      'socat',
      'ssmtp'
    ] }

    let(:php_version) { '7.0' }

    let(:php_packages) { [
     'apache2',
     'php7.0',
     'php7.0-cli',
     'mysql-client',
     'memcached',
     'php7.0-gd',
     'php7.0-dev',
     'php7.0-curl',
     'php7.0-mysql',
     'php-memcached',
     'php-soap',
     'php-pear'
    ] }

    let(:apache_php_mod) { 'php7_module' }
  end

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}ci:php7.0"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

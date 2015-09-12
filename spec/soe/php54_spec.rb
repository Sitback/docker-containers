require 'spec_helper'

describe 'PHP 5.4 SOE' do
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
      'php-apc',
      'php-soap',
      'php-pear'
    ] }
    let(:apache_version) { '2.2.22' }
    let(:php_version) { '5.4' }
    let(:ubuntu_version) { '12.04' }
  end

  before(:all) do
    image_name = "#{SoeConstants::IMAGE_PREFIX}soe:php5.4"
    set :os, family: :debian
    set :docker_image, get_docker_image_id(image_name)
  end
end

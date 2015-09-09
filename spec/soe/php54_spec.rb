require 'spec_helper'

describe 'Dockerfile' do
  include_context 'soe' do
    let(:packages) { [
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
  end

  UBUNTU_VERSION = '12.04'
  SOE_VERSION = 'php5.4'
end

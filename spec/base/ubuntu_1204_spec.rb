require 'spec_helper'

describe 'Ubuntu 12.04 Base' do
  include_context 'base' do
    let(:base_packages) { [
      'supervisor',
      'python-software-properties',
      'python-setuptools',
      'build-essential',
      'autoconf',
      'automake',
      'curl',
      'nano',
      'telnet',
      'net-tools',
      'rsync',
      'wget',
      'git',
      'vim'
    ] }
    let(:ubuntu_version) { '12.04' }
  end

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}base:ubuntu-12.04"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end
end

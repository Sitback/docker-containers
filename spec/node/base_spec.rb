require 'spec_helper'

describe 'Node.js base' do
  include_context 'base'

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}node:base"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end

  describe 'Node.js installed' do
    describe package('nodejs') do
      it { should be_installed }
    end
  end

  describe 'Working node command' do
    describe command('which node') do
      its(:stdout) { should match "/usr/bin/node" }
    end
  end

  describe 'Working node command' do
    describe command('which node') do
      its(:stdout) { should match "/usr/bin/node" }
    end
  end

  describe 'Correct node version' do
    describe command('node --version') do
      its(:stdout) { should match /^v0.12/ }
    end
  end

  describe 'Working PM2 command' do
    describe command('which pm2') do
      its(:stdout) { should match "/usr/bin/pm2" }
    end
  end

end

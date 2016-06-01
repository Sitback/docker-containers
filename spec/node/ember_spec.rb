require 'spec_helper'

describe 'Node.js Ember' do
  include_context 'base'

  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}node:ember"
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

  describe 'Correct node version' do
    describe command('node --version') do
      its(:stdout) { should match /^v5/ }
    end
  end

  describe 'Working Ember command' do
    describe command('which ember') do
      its(:stdout) { should match "/usr/bin/ember" }
    end
  end

  describe 'Working Bower command' do
    describe command('which bower') do
      its(:stdout) { should match "/usr/bin/bower" }
    end
  end

  describe 'Working XVFB command' do
    describe command('which xvfb') do
      its(:stdout) { should match "/usr/bin/xvfb" }
    end
  end

  describe 'Working Google Chrome command' do
    describe command('which google-chrome') do
      its(:stdout) { should match "/usr/bin/google-chrome" }
    end
  end

end

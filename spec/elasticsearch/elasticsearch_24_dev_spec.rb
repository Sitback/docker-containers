require 'spec_helper'

describe 'Elasticsearch 2.4 (development-only)' do
  before(:all) do
    image_name = "#{Constants::IMAGE_PREFIX}elasticsearch:2.4-dev"
    set :os, family: Constants::OS_FAMILY
    set :docker_image, get_docker_image_id(image_name)
  end

  describe 'Elasticsearch installed' do
    describe package('elasticsearch') do
      it { should be_installed }
    end
  end

  describe 'Correct elasticsearch version' do
    describe command('elasticsearch --version') do
      its(:stdout) { should match /^Version: 2\.4/ }
    end
  end
end

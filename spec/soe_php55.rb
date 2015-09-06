require 'serverspec'
require 'docker'

describe 'Dockerfile' do
  # image = Docker::Image.build_from_dir('.')

  set :os, family: :debian
  set :backend, :docker
  set :docker_image, 'chinthakagodawita/soe:php5.5'

  it 'installs the right version of Ubuntu' do
    expect(os_version).to include('Ubuntu 13')
  end

  it 'installs required packages' do
    expect(package('php')).to be_installed
  end

  def os_version
    command('lsb_release -a').stdout
  end
end

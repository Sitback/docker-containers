require 'serverspec'

shared_context 'soe' do
  PACKAGES = ['apache2', 'php5', 'socat', 'mysql-client']
  SOE_IMAGE_PREFIX = 'chinthakagodawita/soe:'
  SOE_OS_FAMILY = :debian

  before(:all) do
    puts "chinthakagodawita/soe:#{SOE_VERSION}"
    set :os, family: :debian
    set :docker_image, "chinthakagodawita/soe:#{SOE_VERSION}"
  end

  it 'Installs the right version of Ubuntu' do
    expect(get_os_version).to include("Ubuntu #{UBUNTU_VERSION}")
  end

  PACKAGES.each do |package|
    describe package(package) do
      it { should be_installed }
    end
  end

end

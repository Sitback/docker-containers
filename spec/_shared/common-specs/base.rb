require 'serverspec'

# Tests shared by all images that inherit some version of the base.
shared_context 'base' do
  let(:base_packages) { [
    'supervisor',
    'software-properties-common',
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
  let(:ubuntu_version) { '14.04' }

  it 'Installs the right version of Ubuntu' do
    expect(get_os_version).to include("Ubuntu #{ubuntu_version}")
  end

  it "Installs all required base packages" do
    base_packages.each do |package|
      puts "\tChecking package '#{package}'"
      expect(package(package)).to be_installed
    end
  end

  describe file('/etc/supervisor/conf.d/base.conf') do
    it { should be_file }
  end

  describe command('cat /etc/timezone') do
    its(:stdout) { should match 'Australia/Sydney' }
  end

end

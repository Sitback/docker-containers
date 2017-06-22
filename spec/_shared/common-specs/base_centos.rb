require 'serverspec'

# Tests shared by all images that inherit some version of the base.
shared_context 'base_centos' do
  let(:base_packages) { [
    'gcc', 
    'gcc-c++',
    'make',
    'openssl-devel',
    'kernel-devel',
    'make',
    'autoconf',
    'automake',
    'curl',
    'nano',
    'telnet',
    'net-tools',
    'rsync',
    'wget',
    'git',
  ] }
  let(:centos_version) { 'CentOS Linux release 7.3.1611 (Core)' }

  it 'Installs the right version of centos' do
    expect(get_centos_os_version).to include("#{centos_version}")
  end

  it "Installs all required base packages" do
    base_packages.each do |package|
      puts "\tChecking package '#{package}'"
      expect(package(package)).to be_installed
    end
  end

  #describe command('date | cut -c 21-24') do
  #  its(:stdout) { should match 'AEST' }
  #end
  describe command ('file /etc/localtime | cut -c 55-70') do
    its(:stdout) { should match 'Australia/Sydney'}
  end

  describe command('which vim') do
    its(:stdout) { should match '/usr/bin/vim' }
  end

  describe yumrepo('epel') do
    it { should exist }
  end

  describe yumrepo('epel') do
    it { should be_enabled }
  end

  describe file('/etc/supervisor/conf.d/base.conf') do
    it { should be_file }
  end

  describe command('which pip') do
    its(:stdout) { should match '/usr/bin/pip' }
  end

  describe command('which easy_install') do
    its(:stdout) { should match '/usr/bin/easy_install' }
  end

  describe command('which supervisord') do
    its(:stdout) { should match '/usr/bin/supervisord' }
  end
end

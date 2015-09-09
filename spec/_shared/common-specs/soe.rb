require 'serverspec'

shared_context 'soe' do
  SOE_OS_FAMILY = :debian
  SOE_IMAGE_PREFIX = 'chinthakagodawita/soe:'
  SERVICE_TIMEOUT = 30

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
    'php5-xdebug',
    'php5-memcached',
    'php-soap',
    'php-pear'
  ] }
  let(:service_count) { 5 }
  let(:service_running_msg) { 'RUNNING' }
  let(:apache_version) { '2.4.7' }
  let(:ports) { [80, 443, 8000] }

  before(:all) do
    image_name = "#{SOE_IMAGE_PREFIX}#{SOE_VERSION}"
    image = nil
    Docker::Image.all.each do |image_def|
      puts "#{image_def.info['RepoTags'][0]} eq #{image_name}"
      if image_def.info['RepoTags'][0] == image_name
        image = image_def.id
        break
      end
    end
    puts image
    set :os, family: SOE_OS_FAMILY
    # set :docker_image, image
    set :docker_image, image_name
    # set :docker_container_create_options, { 'Cmd' => ['/bin/bash'] }
  end

  it 'Installs the right version of Ubuntu' do
    expect(get_os_version).to include("Ubuntu #{UBUNTU_VERSION}")
  end

  it "Install all required packages" do
    packages.each do |package|
      puts "\tChecking package '#{package}'"
      expect(package(package)).to be_installed
    end
  end

  describe 'Apache Install' do
    describe command('apachectl -M') do
      its(:stdout) { should include('rewrite_module') }
      its(:stdout) { should include('php5_module') }
      its(:stdout) { should include('vhost_alias') }
      its(:stdout) { should include('ssl') }
      its(:stdout) { should include('headers') }
    end

    describe command('apachectl -V') do
      # test 'Prefork' exists between "Server MPM" and "Server compiled".
      its(:stdout) { should include('prefork') }

      # test 'conf/httpd.conf' exists after "SERVER_CONFIG_FILE".
      its(:stdout) { should include('apache2.conf') }

      # test 'Apache/2.2.15' exists before "Server built".
      its(:stdout) { should include("Apache/#{apache_version}") }
    end
  end

  describe "Supervisord services" do
    describe command("sleep #{SERVICE_TIMEOUT}") do
      its(:exit_status) { should eq 0 }
    end

    describe service('apache2') do
      it { should be_running.under('supervisor') }
    end
    describe service('socat') do
      it { should be_running.under('supervisor') }
    end
    describe service('apache2errorlog') do
      it { should be_running.under('supervisor') }
    end
    describe service('memcached') do
      it { should be_running.under('supervisor') }
    end
    describe service('stdout') do
      it { should be_running.under('supervisor') }
    end

    # PimpMyLog.
    describe port(8000) do
      it { should be_listening }
    end
  end

  describe 'Working Drush command' do
    describe command('which drush') do
      its(:stdout) { should match "/root/.composer/vendor/bin/drush" }
    end
  end

  describe 'Working Composer command' do
    describe command('which composer') do
      its(:stdout) { should match "/usr/local/bin/composer" }
    end
  end

  describe 'PHP config overrides' do
    context php_config('error_reporting') do
      # 32767 = E_ALL (http://php.net/manual/en/errorfunc.constants.php).
      its(:value) { should eq 32767 }
    end

    context php_config('display_errors') do
      its(:value) { should eq 'On' }
    end

    context php_config('post_max_size') do
      its(:value) { should eq '100M' }
    end

    context php_config('date.timezone') do
      its(:value) { should eq 'Australia/Sydney' }
    end
  end

end

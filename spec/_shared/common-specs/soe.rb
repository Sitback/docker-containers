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
    set :os, family: SOE_OS_FAMILY
    set :docker_image, image_name
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

  describe 'Supervisord Services' do
    describe command("supervisord && sleep #{SERVICE_TIMEOUT} && supervisorctl status") do
      describe 'All Services Running' do
        its(:stdout) { should contains_count service_count, service_running_msg }
      end

      # Sleeping to make sure all services come up.
      describe command("supervisord && sleep #{SERVICE_TIMEOUT}") do
        it "All required ports are listening" do
          ports.each do |port|
            puts "\tChecking port '#{port}'"
            expect(port(port)).to be_listening
          end
        end
      end
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

  # @TODO: Check PHP config settings.

end

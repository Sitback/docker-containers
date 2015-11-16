require 'serverspec'

shared_context 'php' do
  include_context 'base'

  let(:php_packages) { [
    'apache2',
    'php5',
    'mysql-client',
    'memcached',
    'php5-gd',
    'php5-dev',
    'php5-curl',
    'php5-mcrypt',
    'php5-mysql',
    'php5-memcached',
    'php-soap',
    'php-pear'
  ] }
  let(:php_supervisord_services) { [
    'apache2',
    'apache2errorlog',
    'memcached',
    'stdout'
  ] }
  let(:apache_version) { '2.4.7' }
  let(:php_version) { '5.5' }
  let(:check_php_supervisord_file) { true }

  it "Installs all required php packages" do
    php_packages.each do |package|
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

  describe 'PHP supervisord file check' do
    it 'Has config file' do
      if check_php_supervisord_file
        expect(file('/etc/supervisor/conf.d/php.conf')).to be_file
      end
    end
  end

  describe "PHP supervisord services" do
    describe command("sleep #{Constants::SUPERVISORD_SERVICE_TIMEOUT}") do
      its(:exit_status) { should eq 0 }
    end

    describe 'Service status' do
      it 'Has expected services' do
        php_supervisord_services.each do |supervisord_service|
          puts "\tChecking service '#{supervisord_service}'"
          expect(service(supervisord_service)).to be_running.under('supervisor')
        end
      end
    end

    describe port(80) do
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

  describe 'PHP version' do
    describe command 'php --version' do
      its(:stdout) { should include("PHP #{php_version}.") }
    end
  end

end

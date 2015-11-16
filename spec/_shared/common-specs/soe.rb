require 'serverspec'

shared_context 'soe' do
  include_context 'php'

  let(:soe_packages) { [
    'socat',
    'php5-xdebug',
    'ssmtp'
  ] }
  let(:soe_supervisord_services) { [
    'apache2',
    'socat',
    'apache2errorlog',
    'memcached',
    'mailhog',
    'stdout'
  ] }
  let(:apache_version) { '2.4.7' }
  let(:php_version) { '5.5' }

  it "Installs all required SOE packages" do
    soe_packages.each do |package|
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

  describe file('/etc/supervisor/conf.d/soe.conf') do
    it { should be_file }
  end

  describe "SOE supervisord services" do
    describe command("sleep #{Constants::SUPERVISORD_SERVICE_TIMEOUT}") do
      its(:exit_status) { should eq 0 }
    end

    describe 'Service status' do
      it 'Has expected services' do
        soe_supervisord_services.each do |supervisord_service|
          puts "\tChecking service '#{supervisord_service}'"
          expect(service(supervisord_service)).to be_running.under('supervisor')
        end
      end
    end

    # Disabled on CircleCI as it doesn't seem to support these any more.
    if !ENV['CIRCLECI']
      describe port(80) do
        it { should be_listening }
      end

      describe port(443) do
        it { should be_listening }
      end

      # Memcached.
      describe port(11211) do
        it { should be_listening }
      end

      # PimpMyLog.
      describe port(8000) do
        it { should be_listening }
      end

      # MailHog.
      describe port(1025) do
        it { should be_listening }
      end
      describe port(8025) do
        it { should be_listening }
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

  describe 'PHP version' do
    describe command 'php --version' do
      its(:stdout) { should include("PHP #{php_version}.") }
    end
  end

end

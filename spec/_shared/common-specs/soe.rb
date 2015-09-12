require 'serverspec'

shared_context 'soe' do
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
  let(:apache_version) { '2.4.7' }
  let(:php_version) { '5.5' }
  let(:ubuntu_version) { '14.04' }

  it 'Installs the right version of Ubuntu' do
    expect(get_os_version).to include("Ubuntu #{ubuntu_version}")
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
    describe command("sleep #{SoeConstants::SERVICE_TIMEOUT}") do
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

require 'serverspec'

shared_context 'ci' do
  include_context 'soe' do
    # We don't check for socat.
    let(:soe_supervisord_services) { [
      'apache2',
      'apache2errorlog',
      'memcached',
      'stdout'
    ] }
  end

  let(:ci_packages) { [
    'mysql-server'
  ] }

  it "Installs all required CI packages" do
    ci_packages.each do |package|
      puts "\tChecking package '#{package}'"
      expect(package(package)).to be_installed
    end
  end

  describe file('/etc/supervisor/conf.d/ci.conf') do
    it { should be_file }
  end

  # We don't have a service timeout sleep here as that's already handled
  # by the base 'SOE' context.
  describe "CI supervisord services" do
    describe service('mysql') do
      it { should be_running.under('supervisor') }
    end
    describe service('socat') do
      it { should_not be_running.under('supervisor') }
    end

    describe port(3306) do
      it { should be_listening }
    end
  end

  describe 'Expected MySQL config' do
    context mysql_config('max-allowed-packet') do
      # 104857600 = 100M.
      its(:value) { should eq 104857600 }
    end
  end

  describe 'Working PHPCS command' do
    describe command('which phpcs') do
      its(:stdout) { should match "/root/.composer/vendor/bin/phpcs" }
    end
  end

  describe 'PHPCS Drupal standards installed' do
    describe command('phpcs -i') do
      its(:stdout) { should include "Drupal" }
    end
  end

end

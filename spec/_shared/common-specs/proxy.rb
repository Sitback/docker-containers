require 'serverspec'

shared_context 'proxy' do
  include_context 'base'

  let(:proxy_packages) { [
    'nginx'
  ] }

  it "Installs all required proxy packages" do
    proxy_packages.each do |package|
      puts "\tChecking package '#{package}'"
      expect(package(package)).to be_installed
    end
  end

  describe file('/etc/supervisor/conf.d/nginx.conf') do
    it { should be_file }
  end

  describe file('/etc/nginx/nginx.conf') do
    it { should be_file }
  end

  describe "Proxy config" do
    # Setup a dummy upstream 'app' server so we can run tests.
    describe command('echo "127.0.0.1 app" >> /etc/hosts') do
      its(:exit_status) { should eq 0 }
    end

    # Test nginx config.
    describe command('nginx -t') do
      its(:exit_status) { should eq 0 }
    end

    describe "Proxy supervisord services" do
      describe command("sleep #{Constants::SUPERVISORD_SERVICE_TIMEOUT}") do
        its(:exit_status) { should eq 0 }
      end

      describe service('nginx') do
        it { should be_running.under('supervisor') }
      end

      describe port(80) do
        it { should be_listening }
      end
    end
  end

end

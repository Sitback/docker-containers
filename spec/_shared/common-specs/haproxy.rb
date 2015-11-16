require 'serverspec'

shared_context 'haproxy' do
  include_context 'base'

  let(:haproxy_packages) { [
    'haproxy'
  ] }

  it "Installs all required haproxy packages" do
    haproxy_packages.each do |package|
      puts "\tChecking package '#{package}'"
      expect(package(package)).to be_installed
    end
  end

  describe file('/etc/supervisor/conf.d/haproxy.conf') do
    it { should be_file }
  end

  describe file('/etc/haproxy/haproxy.cfg') do
    it { should be_file }
  end

  describe "Proxy config" do
    # Setup a dummy upstream 'app' server so we can run tests.
    describe command('echo "127.0.0.1 app" >> /etc/hosts') do
      its(:exit_status) { should eq 0 }
    end

    describe "Proxy supervisord services" do
      describe command("sleep #{Constants::SUPERVISORD_SERVICE_TIMEOUT}") do
        its(:exit_status) { should eq 0 }
      end

      describe service('haproxy') do
        it { should be_running.under('supervisor') }
      end

      if !ENV['CIRCLECI']
        describe port(80) do
          it { should be_listening }
        end
      end
    end
  end

end

require 'spec_helper'

describe 'Dockerfile' do
  include_context 'soe'

  SERVICE_TIMEOUT = 1
  SERVICE_COUNT = 4
  UBUNTU_VERSION = '14.04'
  PORTS = [80, 443]
  SOE_VERSION = 'php5.5'

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
      its(:stdout) { should include('Apache/2.4.7') }
    end
  end

  describe 'Misc installed packages' do
    describe command('which supervisord') do
      its(:stdout) { should match "/usr/bin/supervisord" }
    end
  end

  describe 'Supervisord Services' do
    describe command("sleep #{SERVICE_TIMEOUT} && supervisorctl status") do
      describe 'All Services Running' do
        its(:stdout) { should contains_count SERVICE_COUNT, "RUNNING" }
      end

      describe port(80) do
        it { should be_listening }
      end

      describe port(443) do
        it { should be_listening }
      end
    end
  end
end

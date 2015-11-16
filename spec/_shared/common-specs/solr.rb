require 'serverspec'

shared_context 'solr' do
  include_context 'base'

  let(:solr_version) { '5.3' }

  describe file('/etc/supervisor/conf.d/solr.conf') do
    it { should be_file }
  end

  describe file('/opt/solr') do
    it { should be_directory }
  end

  describe command('head -11 /opt/solr/CHANGES.txt') do
    its(:stdout) { should include(" #{solr_version}.") }
  end

  describe file('/opt/solr/bin/solr') do
    it { should be_executable }
  end

  describe "Solr config" do
    describe "Solr supervisord services" do
      describe command("sleep #{Constants::SUPERVISORD_SERVICE_TIMEOUT}") do
        its(:exit_status) { should eq 0 }
      end

      describe service('solr') do
        it { should be_running.under('supervisor') }
      end

      describe service('solrlogs') do
        it { should be_running.under('supervisor') }
      end

      describe port(8983) do
        it { should be_listening }
      end
    end
  end

end

module Helpers
  def get_os_version
    command('lsb_release -a').stdout
  end
end

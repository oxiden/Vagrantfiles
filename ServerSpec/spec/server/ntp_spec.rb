require 'spec_helper'

# package is installed
describe package('ntp') do
  it { should be_installed }
end
describe package('ntpdate') do
  it { should be_installed }
end

# service is active
describe service('ntpd') do
  # service is enabled(automatically start when OS booting up)
  it { should be_enabled }
  # service is running
  it { should be_running }
end

# ntpd is listening
describe port(123) do
  it { should be_listening }
end

# configuration of service is correct
describe file('/etc/ntp.conf') do
  it { should be_file }
  it { should contain '^server ntp.jst.mfeed.ad.jp' }
end

# time is synchronised
describe command('ntpq -pn') do
  its(:stdout) { should contain('^\*\d+') }
end

# timezone
describe file('/etc/localtime') do
  it { should be_linked_to '/usr/share/zoneinfo/right/UTC' }
end
describe command('date') do
  its(:stdout) { should contain('\sUTC\s') }
end

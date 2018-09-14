describe port(80) do
  it { should be_listening }
end

# describe ssl(port: 443).protocols('ssl3') do
#   it { should_not be_enabled }
# end

# describe http('http://localhost/') do
#   its('status') { should cmp 200 }
#   its('body') { should match /Hello, World!/ }
# end

describe port(22) do
  it { should be_listening }
end

# extend tests with metadata
control '01' do
  impact 0.7
  title 'Verify apache2 service'
  desc 'Ensures apache2 service is up and running'
  describe service('apache2') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

# implement os dependent tests
web_user = 'www-data'
web_user = 'httpd' if os[:family] == 'centos'

describe user(web_user) do
  it { should exist }
end

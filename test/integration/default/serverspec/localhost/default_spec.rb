require 'serverspec'
set :backend, :exec

#include Serverspec::Helper::Exec
#include Serverspec::Helper::DetectOS

#RSpec.configure do |c|
#  if ENV['ASK_SUDO_PASSWORD']
#    require 'highline/import'
#    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
#  else
#    c.sudo_password = ENV['SUDO_PASSWORD']
#  end
#  c.before :all do
#    c.os = backend(Serverspec::Commands::Base).check_os
#  end
#  c.path = '/sbin:/usr/sbin'
#end

describe package('analog') do
  it { should be_installed }
end

describe file("/usr/bin/analog") do
  it { should be_file }
  it { should be_mode 755 }
end

describe command("/usr/bin/analog 2> /dev/null | grep 'analog 6.0'") do
#  it { should return_exit_status 0 }
  its(:exit_status) { should eq 0 }
end


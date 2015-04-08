#
# Cookbook Name:: analog
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
case node[:platform]
when "centos"
  platform_version = node[:platform_version].to_f

  if platform_version >= 6.0 then
    rpmfile = "analog-6.0.4-1.x86_64.rpm"
  elsif platform_version >= 5.0 then
    rpmfile = "analog-6.0.4-1.el5.i386.rpm"
  else
    raise "This recipe cannot be applied to this environment!!"
  end

  remote_file "#{Chef::Config[:file_cache_path]}/#{rpmfile}" do
    source "http://www.iddl.vt.edu/~jackie/analog/#{rpmfile}"
  end

  %w{perl}.each do |pkg|
    package pkg do
      action :install
    end
  end

  package "analog" do
    action :install
    source "#{Chef::Config[:file_cache_path]}/#{rpmfile}"
    provider Chef::Provider::Package::Rpm
  end
end


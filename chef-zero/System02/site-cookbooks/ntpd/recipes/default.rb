#
# Cookbook Name:: ntpd
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{ntpdate ntp}.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/ntp/step-tickers" do
  source "step-tickers.erb"
  owner "root"
  group "root"
  mode 0644
end

template "/etc/ntp.conf" do
  source "ntp.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[ntpd]"
end

%w{ntpd}.each do |pkg|
  service pkg do
    supports :restart => true, :reload => false, :status => true
    action [:enable, :start]
  end
end

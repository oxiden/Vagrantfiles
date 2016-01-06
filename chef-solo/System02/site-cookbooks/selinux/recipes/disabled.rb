#
# Cookbook Name:: selinux
# Recipe:: disabled
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
template "/etc/selinux/config" do
  source "selinux-config.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
              "selinux" => "disabled",
              "type"    => "targeted"
            })
end

#template "/etc/grab.conf" do

bash "disable_selinux" do
  code "setenforce 0 || true"
end

#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright (C) 2017 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

#Installing Mysql Server
windows_package "MySQL Server"  do
	checksum node[:mysql][:checksum]
	installer_type :msi
	source node['mysql']['windows']['url']
	options %W[
    /quiet
    INSTALLDIR="#{node['mysql']['windows']['dir']}"
  ].join(' ')
end
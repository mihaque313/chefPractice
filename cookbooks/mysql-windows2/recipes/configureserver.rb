#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright (C) 2017 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'mysql-windows2::developer'

execute 'Configure MySQL Server' do
	command "\"#{node[:mysql][:windows][:dir]}/MySQLInstallerConsole.exe\" configure server:rootpasswd=#{node[:mysql][:server_root_password]} -silent"
end


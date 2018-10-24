#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright (C) 2017 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'mysql-windows2::install'

execute 'Install MySQL' do
	command "\"#{node[:mysql][:windows][:dir]}/MySQLInstallerConsole.exe\" install workbench;#{node[:mysql][:workbench_version]};x64  -silent"
end


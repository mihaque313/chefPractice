#
# Cookbook:: jnj_mssql_odbc
# Recipe:: windows.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

local_source_path = "C:/ProgramData/JnJ/odbc/#{node['jnj_mssql_odbc']['odbc_driver_version']}"
directory local_source_path do
  recursive true
  action :create
end

# Download package
scm_storage_file_get "#{local_source_path}/msodbcsql.msi" do
  remote_path node['jnj_mssql_odbc']['sourcepath']
  local_path local_source_path
  guard_interpreter :powershell_script
  not_if "[System.Version]#{node['jnj_mssql_odbc']['current_version']} -ge [System.Version]#{node['jnj_mssql_odbc']['odbc_driver_version']}"
end

# install package
windows_package 'installs odbc drivers' do
  guard_interpreter :powershell_script
  options '/qn /norestart IACCEPTMSODBCSQLLICENSETERMS=YES ADDLOCAL=ALL REBOOT=ReallySuppress'
  installer_type :msi
  source "#{local_source_path}/msodbcsql.msi"
  version node['jnj_mssql_odbc']['odbc_driver_version']
  not_if "[System.Version]#{node['jnj_mssql_odbc']['current_version']} -ge [System.Version]#{node['jnj_mssql_odbc']['odbc_driver_version']}"
end

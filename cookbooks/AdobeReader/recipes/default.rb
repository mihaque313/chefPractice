#
# Cookbook:: jnj_mssql_odbc
# Recipe:: default
#
# Copyright:: 2017, Johnson and Johnson, All Rights Reserved.

# List of the additionally included SCM Framework or other Functional Cookbooks
# EXAMPLE:
# include_recipe 'scm_jenkins'

version_and_hostindatabag = resolve_version_hostname(cookbook_name, nil)
odbc_driver_version = version_and_hostindatabag[0]
hostname_in_databag_or_new_server = version_and_hostindatabag[1]
begin
  current_version = powershell_out('(Get-WmiObject -Class Win32_Product | Where-Object -FilterScript {$_.Name -like "*ODBC Driver*"}).version').stdout if node['os'] == 'windows'
rescue
  current_version = ''
end
current_version = current_version.chomp
odbc_driver_version = odbc_driver_version.chomp
node.default['jnj_mssql_odbc']['odbc_driver_version'] = odbc_driver_version
node.default['jnj_mssql_odbc']['current_version'] = if current_version != ''
                                                      current_version
                                                    else
                                                      '0'
                                                    end

node.default['jnj_mssql_odbc']['sourcepath'] = if node['kernel']['os_info']['os_architecture'] == '64-bit'
                                                 "#{node['jnj']['scm_packages']}/odbc/#{odbc_driver_version}/64bit/msodbcsql.msi"
                                               else
                                                 "#{node['jnj']['scm_packages']}/odbc/#{odbc_driver_version}/32bit/msodbcsql.msi"
                                               end

if hostname_in_databag_or_new_server == true
  # if hostname is in databag or the server is new
  include_recipe "jnj_mssql_odbc::#{node['os']}"
elsif node['jnj']['scm_hosting_platform'] != 'OPC' && hostname_in_databag_or_new_server == false && node['jnj_mssql_odbc']['current_version'] == '0'
  # if hostname is not in databag and current installed version is equal to latest version (for new servers)
  # and current installed version might be nil for newly provisioned servers
  include_recipe "jnj_mssql_odbc::#{node['os']}"
end

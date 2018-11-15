#
# Cookbook:: jnj_adobe_reader
# Recipe:: default
#
# Copyright:: 2017, Johnson and Johnson, All Rights Reserved.

# List of the additionally included SCM Framework or other Functional Cookbooks
# EXAMPLE:
# include_recipe 'scm_jenkins'

version_and_hostindatabag = resolve_version_hostname(cookbook_name, nil)
adobe_reader_version = version_and_hostindatabag[0]
hostname_in_databag_or_new_server = version_and_hostindatabag[1]
begin
  current_version = powershell_out('(Get-WmiObject -Class Win32_Product | Where-Object -FilterScript {$_.Name -like "*Adobe reader*"}).version').stdout if node['os'] == 'windows'
rescue
  current_version = ''
end
current_version = current_version.chomp
adobe_reader_version = adobe_reader_version.chomp
node.default['jnj_adobe_reader']['adobe_reader_version'] = adobe_reader_version
node.default['jnj_adobe_reader']['current_version'] = if current_version != ''
                                                      current_version
                                                    else
                                                      '0'
                                                    end

node.default['jnj_adobe_reader']['sourcepath'] = "#{node['jnj']['scm_packages']}/AdobeReader/#{adobe_reader_version}/AdobeReader_11.0.00.zip"
                                              #if node['kernel']['os_info']['os_architecture'] == '64-bit'
                                                # "#{node['jnj']['scm_packages']}/odbc/#{adobe_reader_version}/64bit/msodbcsql.msi"
                                               #else
                                                # "#{node['jnj']['scm_packages']}/odbc/#{adobe_reader_version}/32bit/msodbcsql.msi"
                                               #end

if hostname_in_databag_or_new_server == true
  # if hostname is in databag or the server is new
  include_recipe "jnj_adobe_reader::#{node['os']}"
elsif node['jnj']['scm_hosting_platform'] != 'OPC' && hostname_in_databag_or_new_server == false && node['jnj_adobe_reader']['current_version'] == '0'
  # if hostname is not in databag and current installed version is equal to latest version (for new servers)
  # and current installed version might be nil for newly provisioned servers
  include_recipe "jnj_adobe_reader::#{node['os']}"
end

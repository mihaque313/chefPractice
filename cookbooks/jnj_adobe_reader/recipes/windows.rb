#
# Cookbook:: jnj_adobe_reader
# Recipe:: windows.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

local_source_path = "C:/ProgramData/JnJ/AdobeReader/#{adobe_reader_version}"
directory local_source_path do
  recursive true
  action :create
end

# Download package
#scm_storage_file_get "#{local_source_path}/msodbcsql.msi" do
#  remote_path node['jnj_adobe_reader']['sourcepath']
#  local_path local_source_path
#  guard_interpreter :powershell_script
#  not_if "[System.Version]#{node['jnj_adobe_reader']['current_version']} -ge [System.Version]#{node['jnj_adobe_reader']['odbc_driver_version']}"
#end

poise_archive 'fetch trend' do
    # path node['jnj_trendmicro']['download_url']
    path  "#{node['jnj']['scm_packages']}/AdobeReader/#{adobe_reader_version}/AdobeReader_11.0.00.zip"
    destination local_source_path
    group 'Administrators'
    keep_existing false
    strip_components 0
    action :unpack
    notifies :install, "windows_package[installs Adobe Reader]", :immediately
    #only_if { node['jnj']['jnj_core']['exceptions']['trendmicro'] }
  end

# install package
windows_package 'installs Adobe Reader' do
  guard_interpreter :powershell_script
  options '/qn'
  installer_type :msi
  action :nothing
  source "#{local_source_path}/AdobeReader_11.0.00/AcroRead.msi"
  version node['jnj_adobe_reader']['adobe_reader_version']
  not_if "current_version -ge adobe_reader_version"
end

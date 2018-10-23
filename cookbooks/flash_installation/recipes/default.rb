major_version = node['flash']['version'].split('.')[0]
system = node['kernel']['machine'] == 'x86_64' ? 'SysWOW64' : 'System32'

# plugin-free ie: https://msdn.microsoft.com/library/hh968248(v=vs.85).aspx
if platform?('windows')
  windows_package "Adobe Flash Player #{major_version} ActiveX" do
    source "#{node['flash']['download_url']}/#{node['flash']['version']}/"\
      "install_flash_player_#{major_version}_active_x.msi"
    options '/qn'
    installer_type :custom
    only_if { node['flash']['ie'] && !Flash::IE.flash_preinstalled?(node) }
  end

  powershell_script 'Flash is pre-installed but not enabled' do
    code <<-EOH
      import-module ServerManager
      Add-WindowsFeature -name Desktop-Experience,qWave -IncludeAllSubFeature -IncludeManagementTools
    EOH
    only_if { node['flash']['ie'] && !Flash::IE.flash_enabled_by_default?(node) }
  end

  windows_package "Adobe Flash Player #{major_version} NPAPI" do
    source "#{node['flash']['download_url']}/#{node['flash']['version']}/"\
      "install_flash_player_#{major_version}_plugin.msi"
    options '/qn'
    installer_type :custom
    only_if { node['flash']['npapi'] }
  end

  windows_package "Adobe Flash Player #{major_version} PPAPI" do
    source "#{node['flash']['download_url']}/#{node['flash']['version']}/install_flash_player_ppapi.exe"
    options '-install'
    installer_type :custom
    only_if { node['flash']['ppapi'] }
  end

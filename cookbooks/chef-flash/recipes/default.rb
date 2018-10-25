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

  powershell_script 'Flash is pre-installed but not enabled on Windows Server 2012' do
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

  # The Global FlashPlayerTrust directory
  trust_dir = "#{ENV['WINDIR']}\\#{system}\\Macromed\\FlashPlayerTrust"

  directory trust_dir do
    only_if { Dir.exist?("#{ENV['WINDIR']}\\#{system}\\Macromed") }
  end

  file "#{trust_dir}\\ChefGeneratedTrust.cfg" do
    content node['flash']['trust'].join("\r\n")
    only_if { Dir.exist?("#{ENV['WINDIR']}\\#{system}\\Macromed") }
  end

  # Privacy and security settings (mms.cfg)
  mms_cfg_path = "#{ENV['WINDIR']}\\#{system}\\Macromed\\Flash\\mms.cfg"

  file mms_cfg_path do
    action :create_if_missing
    only_if { Dir.exist?("#{ENV['WINDIR']}\\#{system}\\Macromed\\Flash") }
  end

  ruby_block "Manage #{mms_cfg_path}" do
    block do
      file = Chef::Util::FileEdit.new(mms_cfg_path)
      node['flash']['mms_cfg'].each do |k, v|
        file.search_file_replace_line(/#{k}/, "#{k}=#{v}")
        file.insert_line_if_no_match(/#{k}/, "#{k}=#{v}")
      end
      file.write_file
    end
    only_if { Dir.exist?("#{ENV['WINDIR']}\\#{system}\\Macromed\\Flash") }
  end
else
  Chef::Log.warn("Platform #{node['platform']} not supported!")
end

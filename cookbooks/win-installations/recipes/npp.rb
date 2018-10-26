directory 'C:\temp\installers\notepad++' do
  #owner 'root'
  #group 'root'
  mode '0755'
  action :create
end

remote_file 'C:\temp\installers\npp.7.5.9.Installer.x64.exe' do
  source 'https://notepad-plus-plus.org/repository/7.x/7.5.9/npp.7.5.9.Installer.x64.exe'
  mode '0755'
end

windows_package 'notepad++' do
  source 'C:\temp\installers\npp.7.5.9.Installer.x64.exe'
  action :install
  options '/Q'
end

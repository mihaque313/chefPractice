remote_file 'C:\Program Files\adobe_flash\install_flash_player_31_active_x.msi' do
   source 'https://fpdownload.adobe.com/get/flashplayer/pdc/31.0.0.122/install_flash_player_31_active_x.msi'
   mode '0755'
end


windows_package 'Adobe Reader' do
  source 'C:\Program Files\adobe_flash\install_flash_player_31_active_x.msi'
  action :install
  options '/Q'
end

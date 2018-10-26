remote_file 'C:\temp\installers\install_flash_player_31_active_x.msi' do
   source 'https://fpdownload.adobe.com/get/flashplayer/pdc/31.0.0.122/install_flash_player_31_active_x.msi'
   mode '0755'
end


windows_package 'Adobe Reader' do
  source 'C:\temp\installers\AdbeRdr11000_mui_Std\AcroRead.msi'
  action :install
  options '/Q'
end

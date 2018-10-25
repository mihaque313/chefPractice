remote_file 'C:\temp\installers\readerdc_uk_xa_crd_install.exe' do
   source 'https://admdownload.adobe.com/bin/live/readerdc_uk_xa_crd_install.exe'
   mode '0755'
end

windows_package 'Google chrome' do
  source 'C:\temp\installers\readerdc_uk_xa_crd_install.exe'
  installer_type :custom
  options '/Q'
end

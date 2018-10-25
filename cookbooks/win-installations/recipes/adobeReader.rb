batch 'create a directory for zip downloads' do
  code 'if not exist "C:\temp\archives" mkdir C:\temp\archives'
end


remote_file 'C:\temp\archives\AdbeRdr11000_mui_Std.zip' do
   source 'https://files01.tchspt.com/temp/AdbeRdr11000_mui_Std.zip'
   mode '0755'
end
dsc_resource 'example' do
   resource :archive
   property :ensure, 'Present'
   property :path, 'C:\temp\archives\AdbeRdr11000_mui_Std.zip'
   property :destination, 'C:\temp\installers'
 end

windows_package 'Adobe Reader' do
  source 'C:\temp\installers\AdbeRdr11000_mui_Std\Setup.exe'
  installer_type :custom
  options '/Q'
end

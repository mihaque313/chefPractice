remote_file 'C:\temp\installers\python-3.7.1-amd64.exe' do
   source 'https://www.python.org/ftp/python/3.7.1/python-3.7.1-amd64.exe'
   mode '0755'
end

windows_package 'python' do
  source 'C:\temp\installers\python-3.7.1-amd64.exe'
  installer_type :custom
  options '/Q'
end

windows_env 'PATH' do
   value "C:\\Users\\Administrator\\AppData\\Local\\Programs\\Python\\Python37"
   delim ";"
   action :modify
end
windows_env 'PATH' do
   value "%PATH%"
   delim ";"
   action :modify
end

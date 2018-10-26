ieversion1 = powershell_out('(Get-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Internet Explorer" -name svcupdateversion).svcupdateversion').stdout.split('.').first(1).map{|v| v.to_i}
puts "#{ieversion1}"
if ieversion1[0] < 11
  directory 'C:\\Program Files\\Internet-Explorer' do
    #owner 'root'
    #group 'root'
    mode '0755'
    action :create
  end

  remote_file 'C:\\Program Files\\Internet-Explorer\\IE11-Windows6.1-x64-en-us.exe' do
    source 'https://download.microsoft.com/download/7/1/7/7179A150-F2D2-4502-9D70-4B59EA148EAA/IE11-Windows6.1-x64-en-us.exe'
    mode '0755'
  end

  windows_package 'Internet-Explorer' do
    source 'C:\\Program Files\\Internet-Explorer\\IE11-Windows6.1-x64-en-us.exe'
    action :install
    options '/Q'
  end
end

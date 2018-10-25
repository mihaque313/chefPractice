remote_file 'C:\temp\installers\googlechromestandaloneenterprise64.msi' do
   source 'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B37B72E12-740F-8E92-6783-7C421DCEE03D%7D%26lang%3Den%26browser%3D4%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue%26ap%3Dx64-stable-statsdef_1%26brand%3DGCEA/dl/chrome/install/googlechromestandaloneenterprise64.msi'
   mode '0755'
end

windows_package 'Google chrome' do
  action :install
  source 'C:\temp\installers\googlechromestandaloneenterprise64.msi'
end

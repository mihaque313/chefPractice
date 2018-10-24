
#Installing Mysql Server
windows_package "MySQL Server"  do
  installer_type :msi
	source node['mysql']['windows']['url']
	options %W[
    /quiet
    INSTALLDIR="#{node['mysql']['windows']['dir']}"
  ].join(' ')
end

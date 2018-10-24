# passwords
default['mysql']['server_root_password'] = 'root'

# port
default['mysql']['port'] = '3306'

# version
default['mysql']['msi_version'] = '8.0.13.0'
default['mysql']['mysql_version'] = '8.0.13'
default['mysql']['checksum'] = "4ffa5a022d4aa3995d2a33118b2c32cc"
default['mysql']['workbench_version'] = '6.3.8'



# Source URL of Mysql Server
default['mysql']['windows']['url'] = "https://cdn.mysql.com//Downloads/MySQLInstaller/mysql-installer-community-#{node['mysql']['msi_version']}.msi"

default['mysql']['windows']['dir'] = "C:/Program Files (x86)/MySQL/MySQL Installer for Windows"

# MySQL Instance Configuration

#default['mysql']['windows']['AddBinToPath'] = 'no' # accepted values {yes | no}
default['mysql']['windows']['ServerType'] = 'DEVELOPER' # accepted values {DEVELOPMENT | SERVER | DEDICATED}
#default['mysql']['windows']['DatabaseType'] = 'MIXED' # accepted values {MIXED | INNODB | MYISAM}
#default['mysql']['windows']['ConnectionUsage'] = 'DSS' # accepted values {DSS | OLTP}
#default['mysql']['windows']['SkipNetworking'] = 'yes' # accepted values {yes | no}. Specifying yes disables network access altogether
#default['mysql']['windows']['StrictMode'] = 'yes' # accepted values {yes | no}

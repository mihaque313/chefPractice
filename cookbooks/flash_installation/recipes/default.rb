
# Cookbook:: flash_installation
# Recipe:: default
# Author:: Inzamam
#

major_version = node['flash']['version'].split('.')[0]
system = node['kernel']['machine'] == 'x86_64' ? 'SysWOW64' : 'System32'


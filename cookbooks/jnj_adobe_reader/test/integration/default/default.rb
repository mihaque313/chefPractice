# encoding: utf-8
# copyright: 2018, Johnson & Johnson
# license: All rights reserved

require 'json'
current_version = '(Get-WmiObject -Class Win32_Product | Where-Object -FilterScript {$_.Name -like "*ODBC Driver 13*"}).version'

describe package('Microsoft ODBC Driver 13 for SQL Server') do
  it { should be_installed }
end

describe command(current_version) do
  its(:stdout) { should cmp > '13.1' }
end

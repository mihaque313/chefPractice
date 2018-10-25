# Encoding: utf-8
require 'serverspec'

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
else
  set :backend, :cmd
  set :os, family: 'windows'
end

case os[:family]
when 'windows'
  describe file('C:\Windows\SysWOW64\Macromed\FlashPlayerTrust\ChefGeneratedTrust.cfg') do
    its(:content) { should match(/# trust home directory/) }
    its(:content) { should match(/C:\\Users\\vagrant/) }
  end

  describe file('C:\Windows\SysWOW64\Macromed\Flash\mms.cfg') do
    its(:content) { should match(/AutoUpdateDisable=0/) }
    its(:content) { should match(/SilentAutoUpdateEnable=1/) }
  end
end

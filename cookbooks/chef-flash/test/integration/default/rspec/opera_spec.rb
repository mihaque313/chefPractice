require 'rspec_helper'
require 'rbconfig'

if WINDOWS || (LINUX && `gcc --version` =~ /Ubuntu/)
  describe 'Opera Grid' do
    before(:all) do
      caps = Selenium::WebDriver::Remote::Capabilities.chrome
      if WINDOWS
        binary = 'C:\Program Files (x86)\Opera\launcher.exe'
      else
        binary = '/usr/bin/opera'
      end
      caps[:chromeOptions] = { binary: binary }
      caps[:browserName] = 'operablink'
      @selenium = Selenium::WebDriver.for(:remote, desired_capabilities: caps)
    end

    after(:all) do
      @selenium.quit
    end

    it 'Checks if Flash installed' do
      @selenium.get('https://helpx.adobe.com/flash-player.html')
      element = @selenium.find_element(:id, 'displaybutton')
      element.click
      element = @selenium.find_element(:id, 'flashversioninfo')
      expect(element.text).to_not eq('Not installed')
    end
  end
end

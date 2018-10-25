require 'rspec_helper'

describe 'Firefox Grid' do
  before(:all) do
    @selenium = Selenium::WebDriver.for(:remote, desired_capabilities: :firefox)
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

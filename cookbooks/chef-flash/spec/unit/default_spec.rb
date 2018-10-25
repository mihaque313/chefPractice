# Encoding: utf-8

require_relative 'spec_helper'

describe 'flash::default' do
  describe 'windows' do
    before do
      ENV['WINDIR'] = 'C:\Windows'
      allow(Dir).to receive(:exist?).and_return(true)
      allow(Flash::IE).to receive(:flash_preinstalled?).and_return(true)
      allow(Flash::IE).to receive(:flash_enabled_by_default?).and_return(false)
    end

    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2012R2', log_level: ::LOG_LEVEL) do |node|
        node.set['flash']['trust'] = ['# comment', 'C:\trust\directory']
      end.converge(described_recipe)
    end

    it 'enables pre-install on Windows Server for Internet Explorer' do
      expect(chef_run).to run_powershell_script('Flash is pre-installed but not enabled on Windows Server 2012')
    end

    it 'installs for Internet Explorer - ActiveX' do
      expect(chef_run).to_not install_windows_package('Adobe Flash Player 20 ActiveX')
    end

    it 'installs for Firefox - NPAPI' do
      expect(chef_run).to install_windows_package('Adobe Flash Player 20 NPAPI')
    end

    it 'installs for Chome and Opera - PPAPI' do
      expect(chef_run).to install_windows_package('Adobe Flash Player 20 PPAPI')
    end

    it 'creates FlashPlayerTrust directory' do
      expect(chef_run).to create_directory('C:\Windows\SysWOW64\Macromed\FlashPlayerTrust')
    end

    it 'creates ChefGeneratedTrust.cfg' do
      expect(chef_run).to create_file('C:\Windows\SysWOW64\Macromed\FlashPlayerTrust\ChefGeneratedTrust.cfg').with(
        content: "# comment\r\nC:\\trust\\directory"
      )
    end

    it 'creates mms.cfg file' do
      expect(chef_run).to create_file_if_missing('C:\Windows\SysWOW64\Macromed\Flash\mms.cfg')
    end

    it 'manages mms.cfg' do
      expect(chef_run).to run_ruby_block('Manage C:\Windows\SysWOW64\Macromed\Flash\mms.cfg')
    end
  end
end

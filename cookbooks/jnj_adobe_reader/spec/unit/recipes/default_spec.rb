#
# Cookbook::jnj_adobe_reader
# Spec:: default
#
# Copyright:: 2017, Johnson and Johnson, All Rights Reserved.
require 'spec_helper'

current_version = '13.1.4414.46'
odbc_driver_version = '13.1.4414.46'

describe 'jnj_adobe_reader::windows' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'windows', version: '2012R2') do |node|
      node.default['jnj_adobe_reader']['sourcepath'] = 'http://http://itsusablsp00956.jnj.com/jnj-dvl-opcx-scm/packages/odbc/13.1.4414.46/64bit'
      node.default['jnj']['scm_hosting_platform'] = 'OPC'
      node.default['jnj']['opcx_region'] = 'na'
      node.default['jnj']['scm_region'] = 'na'
      node.default['jnj']['scm_instance_id'] = 'na'
      node.default['jnj']['opcx_environment'] = 'development'
      node.default['jnj_adobe_reader']['odbc_driver_version'] = odbc_driver_version
      node.default['jnj_adobe_reader']['current_version'] = current_version
    end.converge(described_recipe)
  end
  before(:each) do
    stub_command("[System.Version]#{current_version} -ge [System.Version]#{odbc_driver_version}").and_return(false)
  end

  it 'create directory' do
    expect(chef_run).to create_directory('C:/ProgramData/JnJ/odbc/13.1.4414.46')
  end

  it 'installs odbc drivers' do
    expect(chef_run).to install_windows_package('installs odbc drivers')
  end
end

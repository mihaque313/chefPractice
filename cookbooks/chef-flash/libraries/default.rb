# Flash Player
module Flash
  # Internet Explorer
  module IE
    class << self
      #  Flash is pre-installed but not enabled on Windows Server 2012+
      def flash_enabled_by_default?(node)
        return unless node['platform'] == 'windows'
        require 'chef/win32/version'
        windows_version = Chef::ReservedNames::Win32::Version.new
        !(flash_preinstalled?(node) && windows_version.marketing_name.match(/Windows Server/))
      end

      #  Flash is pre-installed on Windows 8+ and Windows Server 2012+
      def flash_preinstalled?(node)
        return unless node['platform'] == 'windows'
        catentate_windows_version(node) >= 62
      end

      private

      # Catenate Windows major and minor version e.g., 6.2.9200 -> 62
      def catentate_windows_version(node)
        ver_array = node['platform_version'].split('.')
        "#{ver_array[0]}#{ver_array[1]}".to_i
      end
    end
  end
end unless defined?(Flash) # https://github.com/sethvargo/chefspec/issues/562

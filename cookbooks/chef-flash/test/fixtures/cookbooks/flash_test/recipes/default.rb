include_recipe 'flash'

include_recipe 'java_se'
node.set['mozilla_firefox']['version'] = 'latest-esr'
node.set['selenium_grid']['username'] = 'vagrant'
node.set['selenium_grid']['password'] = 'vagrant'
node.set['selenium_grid']['display']['windows'] = false
node.set['selenium_grid']['chrome']['max_instances'] = 1
node.set['selenium_grid']['firefox']['max_instances'] = 1
node.set['selenium_grid']['ie']['max_instances'] = 1
node.set['selenium_grid']['opera']['max_instances'] = 1
include_recipe 'selenium_grid::hub'
include_recipe 'selenium_grid::node'

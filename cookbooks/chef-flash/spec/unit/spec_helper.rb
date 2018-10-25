# Encoding: utf-8
require 'chefspec'
require 'chefspec/berkshelf'
require_relative '../../libraries/default'

ChefSpec::Coverage.start!

::LOG_LEVEL = :warn

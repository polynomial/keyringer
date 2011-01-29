# internal requires
$:.unshift File.dirname(__FILE__)
require 'keyring'
require 'keyringer/decrypt'
require 'keyringer/bash_wrapper'
require 'keyringer/recipients'

module Keyring
  VERSION = '2.0-alpha'
end

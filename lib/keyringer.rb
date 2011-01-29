# internal requires
$:.unshift File.dirname(__FILE__)
require 'keyring'
require 'keyringer/bash_wrapper'
require 'keyringer/parser'
require 'keyringer/actions/decrypt'

module Keyringer
  VERSION = '2.0-alpha'
end

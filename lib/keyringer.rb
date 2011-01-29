# internal requires
$:.unshift File.dirname(__FILE__)
require 'keyring'
require 'keyringer/bash_wrapper'
require 'keyringer/parser'
require 'keyringer/checker'
require 'keyringer/actions/decrypt'
require 'keyringer/actions/recipients'

module Keyringer
  VERSION = '2.0-alpha'
end

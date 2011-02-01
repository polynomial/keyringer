#!/usr/bin/env ruby
#
# Keyringer secret management system.
#
# Copyright (C) 2011 Keyringer Development Team.
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# general requires
require 'singleton'

# internal requires
$:.unshift File.dirname(__FILE__)
require 'keyring'
require 'keyringer/bash_wrapper'
require 'keyringer/parser'
require 'keyringer/checker'
require 'keyringer/console'
require 'keyringer/actions/decrypt'
require 'keyringer/actions/recipients'
require 'keyringer/actions/init'

module Keyringer
  VERSION = '2.0-alpha'
end

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

module Keyring
  class UserConfig
    include Singleton

    def initialize(path = nil)
      self.loadMainConfig
      self.check
    end

    def loadMainConfig
      @user_config = ENV['HOME'] + '/.keyringer/config'
      @keyrings    = Backend::parse_config(@user_config)
      @path        = @keyrings.get_value($keyring)
    end

    # TODO
    def saveMainConfig
      # TODO: copy each keyring definition to a hash
      # update path of the current keyring
      file = open(@user_config, 'w')
    end

    def keyrings
      @keyrings
    end

    def path
      @path
    end

    def setPath(path)
      @path = path
      saveMainConfig
    end

    def check
      raise "Not a directory: #{@path}" if !File::directory?(@path)
      raise "No keydir configured for #{$keyring} keyring." if @path.nil?
    end
  end
end

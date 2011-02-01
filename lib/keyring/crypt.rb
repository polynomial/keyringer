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
  class Crypt
    def initialize
      @keyStore = UserConfig.instance.path + '/keys'
    end

    def decrypt(filename)
      file    = Backend::Fs.new
      crypt   = Backend::Crypt.new(nil)
      content = file.get_as_string(filename)
      crypt.decrypt(content)
    end

    # Determine the file name for a given key
    def keyFile(name)
      @keyStore + '/' + File.dirname(name) + '/' + File.basename(name, '.asc') + '.asc'
    end

    def decryptKey(name)
      decrypt(keyFile(name))
    end
  end
end

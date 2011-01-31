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

module Keyringer
  module Actions
  class Recipients
    def execute
      subCommand = $args[0]

      recipients    = Keyring::Recipients.new
      
      if subCommand == "add"
        recipients.addRecipient($args[1], $args[2])
      elsif subCommand == "remove"
        recipients.removeRecipient($args[1])
      elsif subCommand == "list"
        recipients.listRecipients().each() do |recipient|
          puts("#{recipient.email}     #{recipient.keySignature}")
        end
      else
        throw "Invalid recipients command: #{subCommand} "
      end
      
      return ""
    end
  end
  end
end

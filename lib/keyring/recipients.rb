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
  class Recipients
    def initialize(path = nil)
      if !path
        path = UserConfig.instance.path
      end

      # Load backend and ensure that the file exists
      @recipientsStore = Backend::RecipientsStore.new(path)
      @recipientsStore.create()
    end
    def addRecipient(anEmail, aKeySignature)

      @recipientsStore.load()
      @recipientsStore.addRecipient(anEmail, aKeySignature)
      @recipientsStore.save()
    end
    
    def removeRecipient(aKeySignature)
      @recipientsStore.load()
      @recipientsStore.removeRecipient(aKeySignature)
      @recipientsStore.save()
    end
    
    def listRecipients()
      @recipientsStore.load()
      
      return @recipientsStore.getRecipients()
    end
  end
end

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

module Backend
  # a store for the recipients configuration
  class RecipientsStore
    # Instantiates and stores password
    def initialize(aBaseDir = "")
      @baseDir = aBaseDir
    end
    
    def addRecipient(aRecipientAddress, aRecipientKey)
      @recipients.push(Recipient.new(aRecipientAddress, aRecipientKey))
    end
    
    def removeRecipient(aRecipientKey)
#      read()
#      @recipients.push(Recipient.new(aRecipientAddress, aRecipientKey))
#      write()
    end
    
    def getRecipients()
      return @recipients
    end
    
    def load()
      read()
    end

    def save()
      write()
    end

    private

    def read()
      fileName = File.join(@baseDir, "config", "recipients")
      file = File.new(fileName, "r")
      begin
        recipients = []
       
        while (line = file.gets)
          parts = line.split()
          if (parts.length == 2)
            recipients.push(Recipient.new(parts[1], parts[0]))
          end
        end
        
        @recipients = recipients
      rescue => err
        throw err
      ensure
        file.close
      end
    end

    def write()
      fileName = File.join(@baseDir, "config", "recipients")
      file = File.new(fileName, "w")
      begin
        @recipients.each do |recipient|
          file.puts("#{recipient.email} #{recipient.keySignature}")
        end
      rescue => err
        throw err
      ensure
        file.close
      end
    end

  end
  
  class Recipient
    def initialize(aKeySignature, anEmail)
      @keySignature = aKeySignature
      @email = anEmail
    end
    
    attr_reader :keySignature
    attr_reader :email
  end
end

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

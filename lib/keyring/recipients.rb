module Keyring
  class Recipients
    def initialize(aBaseDirectory = '..')
      @recipientsStore = Backend::RecipientsStore.new(aBaseDirectory)

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

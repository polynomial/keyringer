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

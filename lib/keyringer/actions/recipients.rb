module Keyringer
  class Recipients
    def execute
      subCommand = ARGV[2]
      parameters = ARGV[3..-1]

      recipients    = Keyring::Recipients.new
      
      if subCommand == "add"
        recipients.addRecipient(ARGV[3], ARGV[4])
      elsif subCommand == "remove"
        recipients.removeRecipient(ARGV[3])
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

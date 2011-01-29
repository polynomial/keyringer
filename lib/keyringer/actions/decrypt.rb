module Keyringer
  module Actions
    class Decrypt
      def execute
        filename = $args[0]
        crypt    = Keyring::Crypt.new
        output   = crypt.decrypt(filename)
        return output
      end
    end
  end
end

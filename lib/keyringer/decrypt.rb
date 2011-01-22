module Keyringer
  class Decrypt
    def execute
      filename = ARGV[2]
      crypt    = Keyring::Crypt.new
      output   = crypt.decrypt(filename)
      return output
    end
  end
end

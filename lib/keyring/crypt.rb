module Keyring
  class Crypt
    def decrypt(filename)
      file    = Fs.new()
      content = file.get_as_string(filename)
      crypt   = Backend::Crypt.new(nil)
      return crypt.decrypt(content)
    end
  end
end

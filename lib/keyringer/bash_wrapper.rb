module Keyringer
  class BashWrapper
    def execute
      exec("keyringer #{$keyring} #{$action} " + $args.join(' '))
    end
  end
end

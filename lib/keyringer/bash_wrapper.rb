module Keyringer
  class BashWrapper
    def execute
      exec("keyringer " + ARGV.join(' '))
    end
  end
end

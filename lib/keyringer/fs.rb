module Keyringer
  class Fs
    def get_as_string(filename)
      data = ''
      f = File.open(filename, "r") 
      f.each_line do |line|
        data += line
      end
      return data
    end
  end
end


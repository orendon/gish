require 'securerandom'

module Gish
  module InputHelpers
    def prompt(message)
      print message
      STDIN.gets.chomp
    end

    def confirm(message)
      print message
      STDIN.gets.chomp == 'y'
    end

    def capture_editor_input(content=nil)
      unique_file = "/tmp/#{SecureRandom.hex}"
      File.open(unique_file, 'w+'){|f| f.write(content) }

      command = "#{Gish.editor} #{unique_file} < `tty` > `tty`"
      %x{#{command}}
      ouput = %x{cat #{unique_file}}
      
      File.delete(unique_file)
      ouput.length < 1 ? nil : ouput
    end
  end
end
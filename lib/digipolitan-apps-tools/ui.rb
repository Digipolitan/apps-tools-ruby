module Digipolitan

  class UI

    def self.input(message)
      puts "#{message}\n"
      return gets.strip()
    end

    def self.confirm(message)
      puts "#{message} y/n\n"
      while data = getc
        if data == "y"
          return true
        elsif data == "n"
          return false
        else
          puts "\nYou must select only y/n\n"
        end
      end
    end

  end

end

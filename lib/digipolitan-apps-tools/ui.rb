module Digipolitan

  class UI

    def self.message(msg)
      $stdout.puts("#{msg}\n")
    end

    def self.input(msg)
      self.message(msg)
      return $stdin.gets().strip()
    end

    def self.error(msg)
      self.message("\n[!] ERROR : #{msg}")
    end

    def self.confirm(msg)
      self.message("#{msg} y/n")
      while data = $stdin.getc()
        if data == "y"
          return true
        elsif data == "n"
          return false
        else
          self.error("Select y/n only")
        end
      end
    end

  end

end

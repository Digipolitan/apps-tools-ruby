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
      while c = $stdin.getch()
        if c == "y"
          return true
        elsif c == "n"
          return false
        else
          self.error("Select y/n only")
        end
      end
    end

    def self.crash(msg)
      abort("\n[!!!] CRASH : #{msg}\n")
    end

  end

end

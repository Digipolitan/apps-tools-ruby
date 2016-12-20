require 'colorize'

module Digipolitan

  class UI

    def self.message(msg, color = nil)
      if color != nil
        msg = msg.colorize(color)
      else
        msg = "#{msg}\n"
      end
      $stdout.puts(msg)
    end

    def self.success(msg)
      self.message(msg, :green)
    end

    def self.input(msg)
      self.message(msg)
      return $stdin.gets().strip()
    end

    def self.error(msg)
      self.message("\n[!] ERROR : #{msg}", :red)
    end

    def self.confirm(msg)
      self.message("#{msg} (y/n)", :yellow)
      while c = $stdin.getch()
        if c == "y"
          return true
        elsif c == "n"
          return false
        else
          self.error("Select yes or no only")
        end
      end
    end

    def self.select(msg, values)
      self.message(msg)
      i = 0
      values.each { |value|
        i += 1
        self.message("#{i} - #{value}")
      }
      while val = self.input("Select a value between [1 - #{i}]").to_i
        if val >= 1 && val <= i
          return values[val-1]
        end
      end
    end

    def self.crash(msg)
      abort("\n[!!!] CRASH : #{msg}".colorize(:red))
    end

  end
end

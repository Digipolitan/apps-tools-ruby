module Digipolitan

  class Argv

    def self.parse
      map = {}
      count = ARGV.count
      i = 0
      while i < count
          arg = ARGV[i]
          if arg.index('-') == 0
              key = arg
              data = []
              i += 1
              while i < count
                  arg = ARGV[i]
                  if arg.index('-') != 0
                      data.push(arg)
                      i += 1
                  else
                      i -= 1
                      break
                  end
              end
              data_count = data.count
              if data_count > 1
                  map[key] = data
              elsif data_count > 0
                  map[key] = data[0]
              else
                  map[key] = true
              end
          end
          i += 1
      end
      return map
    end
  end
end

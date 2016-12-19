#!/usr/bin/ruby

def write_to_file(path, content = "")
  File.open(path, "w") { |file|
    file.puts(content)
  }
end

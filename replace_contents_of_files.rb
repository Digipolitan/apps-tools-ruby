#!/usr/bin/ruby

require 'write_to_file'

def replace_contents_of_files(pattern, replacement, path = ".", recursive = true)
  if pattern == nil || replacement == nil
    abort "Missing required parameters (pattern, replacement)"
  end
  entries = Dir.entries(path)
  entries.each do |entry|
    file_path = File.join(path, entry)
    if file_path != __FILE__
      if recursive && File.directory?(file_path) && entry != "." && entry != ".."
        replace_contents_of_files(pattern, replacement, file_path, recursive)
      elsif File.file?(file_path)
        content = File.read(file_path)
        if content.include?(pattern)
          write_to_file(file_path, content.gsub(pattern, replacement))
        end
      end
    end
  end
end

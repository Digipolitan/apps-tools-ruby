#!/usr/bin/ruby

def rename_files(pattern, replacement, path = ".", recursive = true)
  if pattern == nil || replacement == nil
    abort "Missing required parameters (pattern, replacement)"
  end
  entries = Dir.entries(path)
  entries.each do |entry|
    replaced = entry
    replaced_path = File.join(path, entry)
    if replaced_path != __FILE__
      if entry.include?(pattern)
        replaced = entry.gsub(pattern, replacement)
        replaced_path = File.join(path, replaced)
        File.rename(File.join(path, entry), replaced_path)
      end
      if recursive && File.directory?(replaced_path) && replaced != "." && replaced != ".."
        rename_files(pattern, replacement, replaced_path, recursive)
      end
    end
  end
end

module Digipolitan

  class FileUtils

    def self.rename_files(pattern, replacement, ignored_entries = nil, path = ".", recursive = true)
      entries = Dir.entries(path)
      entries.each do |entry|
        replaced = entry
        replaced_path = File.join(path, entry)
        if replaced_path != __FILE__ && (ignored_entries == nil || ignored_entries.index(entry) == nil)
          if entry.include?(pattern)
            replaced = entry.gsub(pattern, replacement)
            replaced_path = File.join(path, replaced)
            File.rename(File.join(path, entry), replaced_path)
          end
          if recursive && File.directory?(replaced_path) && replaced != "." && replaced != ".."
            self.rename_files(pattern, replacement, ignored_entries, replaced_path, recursive)
          end
        end
      end
    end

    def self.replace_contents_of_files(pattern, replacement, ignored_entries = nil, path = ".", recursive = true)
      entries = Dir.entries(path)
      entries.each do |entry|
        file_path = File.join(path, entry)
        if file_path != __FILE__ && (ignored_entries == nil || ignored_entries.index(entry) == nil)
          if recursive && File.directory?(file_path) && entry != "." && entry != ".."
            self.replace_contents_of_files(pattern, replacement, ignored_entries, file_path, recursive)
          elsif File.file?(file_path)
            content = File.read(file_path)
            if content.include?(pattern)
              self.write_to_file(file_path, content.gsub(pattern, replacement))
            end
          end
        end
      end
    end

    def self.write_to_file(path, content = "")
      File.open(path, "w") { |file|
        file.puts(content)
      }
    end

    def self.remove_dir(path)
      if File.directory?(path)
          entries = Dir.entries(path)
          entries.each do |entry|
            if entry != "." && entry != ".."
              self.remove_dir(File.join(path, entry))
            end
          end
          Dir.delete(path)
      else
        File.delete(path)
      end
    end
  end
end

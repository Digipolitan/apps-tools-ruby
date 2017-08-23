module Digipolitan

  class FileUtils

    def self.rename_files(pattern, replacement, ignored_entries = nil, path = '.', recursive = true)
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
          if recursive && File.directory?(replaced_path) && replaced != '.' && replaced != '..'
            self.rename_files(pattern, replacement, ignored_entries, replaced_path, recursive)
          end
        end
      end
    end

    def self.replace_contents_of_files(pattern, replacement, ignored_entries = nil, path = '.', recursive = true)
      entries = Dir.entries(path)
      entries.each do |entry|
        file_path = File.join(path, entry)
        if file_path != __FILE__ && (ignored_entries == nil || ignored_entries.index(entry) == nil)
          if recursive && File.directory?(file_path) && entry != '.' && entry != '..'
            self.replace_contents_of_files(pattern, replacement, ignored_entries, file_path, recursive)
          elsif File.file?(file_path)
            content = File.read(file_path)
            if content.include?(pattern)
              begin
                self.write_to_file(file_path, content.gsub(pattern, replacement))
              rescue
                Digipolitan::UI.warning("Error during replacement of file at path #{file_path}")
              end
            end
          end
        end
      end
    end

    def self.write_to_file(path, content = '')
      File.open(path, 'w') { |file|
        file.puts(content)
      }
    end

    def self.remove_dir(path)
      if File.directory?(path)
          entries = Dir.entries(path)
          entries.each do |entry|
            if entry != '.' && entry != '..'
              self.remove_dir(File.join(path, entry))
            end
          end
          Dir.delete(path)
      elsif File.exist?(path)
        File.delete(path)
      end
    end

    def self.mkdir_p(path)
      arr = path.split(File::SEPARATOR)
      count = arr.count
      i = 0
      f_path = nil
      while i < count
        f_name = arr[i]
        if f_path == nil && f_name.length != 0
          f_path = f_name
        else
          f_path = File.join(f_path != nil ? f_path : '', f_name)
        end
        if f_name.length != 0
          if !Dir.exist?(f_path)
            Dir.mkdir(f_path)
          end
        end
        i += 1
      end
    end
  end
end
